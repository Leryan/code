import os

from configparser import ConfigParser


class ConfigInvalidSection(Exception):
    pass


class ConfigSection(object):
    pass


class Config(object):
    """
    Read INI-style configuration file.

    Instantiate globaly (per-process) with Config().

    Access configuration with Config.section.option
    """

    __PROTECTED_ATTRS = []

    def __new__(cls, configuration_file=''):
        instance = super(Config, cls).__new__(cls)

        if os.path.isfile(configuration_file):
            conf_paths = [configuration_file]
        else:
            conf_paths = ['simplecacher.ini', os.path.join(
                os.path.expanduser('~'), 'simplecacher.ini'), '/etc/simplecacher.ini']

        conf_paths = map(os.path.abspath, conf_paths)

        cls.config = ConfigParser()
        cls.config.read(conf_paths)
        cls.__PROTECTED_ATTRS.extend(dir(cls))
        cls.__set_attributes()
        return instance

    @classmethod
    def __set_attributes(cls):
        sections = cls.config.sections()

        for section in sections:
            secobj = ConfigSection()
            secname = section.lower().replace('-', '_')
            setattr(cls, secname, secobj)

            for option in cls.config.options(section):
                opname = option.lower().replace('-', '_')
                value = cls.config.get(section, option)
                setattr(secobj, opname, value)

    @classmethod
    def __setattr__(cls, name, value):
        if name in cls.__PROTECTED_ATTRS:
            raise ConfigInvalidSection(
                'Section "{0}" is invalid.'.format(name))
        else:
            super(Config, cls).__setattr__(name, value)
