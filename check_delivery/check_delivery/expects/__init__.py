import re as rem
import configparser


class ExpectsChecks(object):

    @staticmethod
    def eq(in_value, chk_value):
        """
        Check for equality. Both values will be converted to string.
        """
        return str(in_value) == str(chk_value)

    @staticmethod
    def neq(in_value, chk_value):
        """
        Oposit of eq
        """
        return not ExpectsChecks.eq(in_value, chk_value)

    @staticmethod
    def regexp(in_value, chk_value):
        """
        Check the returned value against a python regex.
        """
        re = rem.compile(chk_value)
        return re.match(in_value)

    @staticmethod
    def nregexp(in_value, chk_value):
        return not ExpectsChecks.regexp(in_value, chk_value)

class Expects(object):

    def __init__(self, file_path, expects_class):
        with open(file_path, 'r') as conf_file:
            self.config = configparser.ConfigParser(
                interpolation=configparser.ExtendedInterpolation())
            self.config.read_file(conf_file)

        self._expects_class = expects_class

    def check(self, output, scenario):
        section = self.config['expects']

        exp_scenario = scenario + '.'

        exp_infos = [[x[len(exp_scenario):].split('.'), section[x]]
                     for x in section if x.startswith(exp_scenario)]

        if len(exp_infos) == 0:
            return None

        conditions = []

        for exp_info in exp_infos:
            in_value = getattr(output, exp_info[0][0])
            chk_value = exp_info[1]
            chk_method = getattr(self._expects_class, exp_info[0][1])

            res = chk_method(in_value, chk_value)

            conditions.append(res)

        return all(conditions)
