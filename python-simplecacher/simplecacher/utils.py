from subprocess import Popen, PIPE

class Utils(object):
    @staticmethod
    def popen_process(cmd, shell=True):
        p = Popen(
            cmd,
            shell=shell,
            stdout=PIPE,
            stderr=PIPE)
        pstdout, pstderr = p.communicate()
        pretcode = p.returncode

        return p, pstdout, pstderr, pretcode

    @staticmethod
    def popen_fulloutput(output):
        full_output = output[1]
        full_output += output[2]
        return full_output