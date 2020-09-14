import os

from simplecacher.config import Config


class Streamer(object):

    @staticmethod
    def get_socket_data(source_socket):
        buffs = int(Config.streamer.recv_buffer)
        while True:
            chunk = source_socket.recv(buffs)
            if not chunk:
                break
            yield chunk

    @staticmethod
    def data_direct_streamer(source_stream):
        """
        Iterator for direct stream from remote source.
        """
        buffs = int(Config.streamer.recv_buffer)
        while True:
            chunk = source_stream.read(buffs)
            if not chunk:
                break
            yield chunk

    @staticmethod
    def data_cached_streamer(source_file_path):
        """
        Iterator for cached data streaming.
        """
        with open(source_file_path, 'rb') as f:
            buffs = int(Config.streamer.cache_read_buffer)
            while True:
                chunk = f.read(buffs)
                if not chunk:
                    break
                yield chunk

    @staticmethod
    def data_cacher_streamer(source_stream, dest_file_path):
        """
        Iterator for streaming data from source and writing to cache.
        """
        with open(dest_file_path, 'wb') as f:
            buffs = int(Config.streamer.recv_buffer)
            while True:
                chunk = source_stream.read(buffs)
                if not chunk:
                    break
                f.write(chunk)
                yield chunk
