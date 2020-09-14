import re
import os
import hashlib
import time

from simplecacher.streamer import Streamer
from simplecacher.sclogger import SCLogger
from simplecacher.config import Config


class Cacher(object):

    CACHE_OBJECT_ID_MODE_PATH = 0
    CACHE_OBJECT_ID_MODE_FILENAME = 1

    CACHE_OBJECT_ID_MODES = {
        'path': CACHE_OBJECT_ID_MODE_PATH,
        'filename': CACHE_OBJECT_ID_MODE_FILENAME
    }

    def __init__(self, *args, **kwargs):
        super(Cacher, self).__init__(*args, **kwargs)

        self.re_allowed_exts = []
        self.re_allowed_urls = []

        self.cache_enable = int(Config.cache.enable)

        if not self.cache_enable:
            self.cache_data = self.cache_data_disable
            SCLogger.cache.info('Cache is disabled')
        else:
            self.compile_allowed_exts()
            self.compile_allowed_urls()

            if not os.path.isdir(Config.cache.object_path):
                os.makedirs(Config.cache.object_path)

            self.cache_compute_mode = self.CACHE_OBJECT_ID_MODES[
                Config.cachecompute.mode]

            self.validity_seconds = int(Config.cache.validity_seconds)

    def cache_data_disable(self, host, path, response, **kwargs):
        return self.cache_bypass(response)

    def cache_data(self, host, path, response, filesize=-1):
        """
        Cache prepare data caching.

        Based on the mode, a sha256 sum is used to store data on disk.

        FIXME: incomplete download will be sent if the same file is asked.
        """
        cache_allowed = self.check_cache_allowed(host, path)
        if not cache_allowed:
            SCLogger.cache.debug('Not allowed: {0}{1}'.format(host, path))
            return self.cache_bypass(response)
        else:
            cached_file_path = self.get_cache_filepath(host, path)
            cache_file_path_tmp = self.get_cache_filepath(host, path) + '.tmp'
            cached = self.check_cached_data(
                cached_file_path, filesize=filesize)

            if cached:
                cache_hit = True
                SCLogger.cache.info('Hit: {0}{1}'.format(host, path))
                streamer = Streamer.data_cached_streamer(cached_file_path)
            else:
                cache_hit = False
                SCLogger.cache.info('Miss: {0}{1}'.format(host, path))
                streamer = Streamer.data_cacher_streamer(
                    response, cache_file_path_tmp)

            return cache_hit, cached_file_path, streamer

    def complete_cache_data(self, cached_file_path, filesize):
        if self.check_cached_data(cached_file_path + '.tmp', filesize):
            os.rename(cached_file_path + '.tmp', cached_file_path)
            return True
        return False

    def cache_bypass(self, response):
        cache_hit = False
        cached_file_path = None
        streamer = Streamer.data_direct_streamer(response)
        return cache_hit, cached_file_path, streamer

    def get_cache_filepath(self, host, path):
        if self.cache_compute_mode == Cacher.CACHE_OBJECT_ID_MODE_FILENAME:
            opath = os.path.basename(path)
        else:
            opath = path

        if os.path.isabs(opath):
            opath = os.path.curdir + opath

        if int(Config.cachecompute.with_host):
            opath = os.path.join(host, opath)

        opath = os.path.normpath(opath)

        if int(Config.cachecompute.hash_filename):
            opath = hashlib.sha256(
                opath.encode('utf-8')).hexdigest() + '.cache'
        else:
            fpath = os.path.dirname(opath)
            fname = os.path.basename(opath)
            cfpath = os.path.join(Config.cache.object_path, fpath)
            if not os.path.exists(cfpath):
                os.makedirs(cfpath)
            opath = os.path.join(fpath, fname)

        opath = os.path.normpath(opath)

        SCLogger.cache.debug('Relative object path: {0}'.format(opath))

        cached_file_path = os.path.abspath(
            os.path.join(Config.cache.object_path, opath)) + '.cache'

        SCLogger.cache.debug('Final object path: {0}'.format(cached_file_path))

        return cached_file_path

    def check_cache_allowed(self, host, path):
        """
        Check if resource is eligible for caching.
        """
        if self.check_cache_exts(host, path):
            return True
        elif self.check_cache_urls(host, path):
            return True

        return False

    def check_cache_exts(self, host, path):
        for allowed_re in self.re_allowed_exts:
            m = allowed_re.match(path)
            if m:
                return True
        return False

    def compile_allowed_exts(self):
        allowed_exts = Config.cache.allowed_ext.split(' ')
        for allowed_ext in allowed_exts:
            rer = r'^.*\.{0}$'.format(allowed_ext)
            r = re.compile(rer)
            self.re_allowed_exts.append(r)
            SCLogger.cache.debug('Added allowed ext re: {0}'.format(rer))

    def compile_allowed_urls(self):
        if os.path.isfile(Config.cache.allowed_urls):
            lists = [Config.cache.allowed_urls]
        else:
            lists = os.listdir(Config.cache.allowed_urls)

        for urllist in lists:
            with open(urllist, 'r') as furllist:
                for url in furllist:
                    url = url.replace('\n', '').replace('\r', '')
                    self.re_allowed_urls.append(re.compile(url))
                    SCLogger.cache.debug(
                        'Added allowed url re: {0}'.format(url))

    def check_cache_urls(self, host, path):
        for allowed_re in self.re_allowed_urls:
            m = allowed_re.match('{0}{1}'.format(host, path))
            if m:
                return True
        return False

    def remove_cached_data(self, cached_file_path, reason=None):
        if reason:
            SCLogger.cache.debug(
                'Remove: {0}: {1}'.format(reason, cached_file_path))
        else:
            SCLogger.cache.debug('Remove: {0}'.format(cached_file_path))
        os.remove(cached_file_path)

    def check_cached_data(self, cached_file_path, filesize=-1):
        # if file isn't present
        if not os.path.isfile(cached_file_path):
            return False

        # if file is present but we dont have validity time
        if self.validity_seconds == 0:
            return True

        # if file is present and we have validity time
        stat = os.stat(cached_file_path)
        if time.time() - stat.st_mtime > self.validity_seconds:
            self.remove_cached_data(cached_file_path, reason='outdated')
            return False

        # check if the file size is ok
        if filesize > -1:
            cached_size = os.stat(cached_file_path).st_size
            if cached_size == filesize:
                return True
            else:
                self.remove_cached_data(
                    cached_file_path, reason='wanted {0} but got {1} bytes'.format(filesize, cached_size))
                return False

        return True
