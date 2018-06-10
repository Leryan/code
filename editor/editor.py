#!/usr/bin/env python
import sys
import argparse
import tty
import termios
import shutil
import time


class Output(object):

    def write(self, raw, computed):
        raise NotImplementedError()

    def close(self):
        raise NotImplementedError()


class Input(object):

    def read():
        raise NotImplementedError()

    def close(self):
        raise NotImplementedError()


class KeyboardInput(Input):

    def read(self):
        """
        Must return the raw input and the computed input.
        """
        raise NotImplementedError()


class ScreenOutput(Output):

    def cleanup(self):
        raise NotImplementedError()


class Codes:

    EOT = 3
    ESC = 27
    BS = 127
    ARROW_UP = 256
    ARROW_RIGHT = 257
    ARROW_DOWN = 258
    ARROW_LEFT = 259
    NEWLINE = 260
    HOME = 261
    END = 262


class InputUnixTerm(KeyboardInput):

    def __init__(self, *args, **kwargs):
        super(InputUnixTerm, self).__init__(*args, **kwargs)

        self._fdin = sys.stdin.fileno()
        self._oldcfg = termios.tcgetattr(self._fdin)
        tty.setraw(self._fdin)

    def read(self):
        raw_in = [sys.stdin.read(1), ]
        computed_in = None

        if raw_in[0] == '\x1b':
            raw_in.append(sys.stdin.read(1))
            if raw_in[1] == '[':
                raw_in.append(sys.stdin.read(1))
                if raw_in[2] == 'A':
                    computed_in = Codes.ARROW_UP
                elif raw_in[2] == 'B':
                    computed_in = Codes.ARROW_DOWN
                elif raw_in[2] == 'C':
                    computed_in = Codes.ARROW_RIGHT
                elif raw_in[2] == 'D':
                    computed_in = Codes.ARROW_LEFT
                elif raw_in[2] == 'H':
                    computed_in = Codes.HOME
                elif raw_in[2] == 'F':
                    computed_in = Codes.END

        elif raw_in[0] == '\x0d':
            computed_in = Codes.NEWLINE

        elif raw_in[0] == '\x7f' or raw_in[0] == '\x08':
            computed_in = Codes.BS

        elif raw_in[0] == '\x03':
            computed_in = Codes.EOT

        return ''.join(raw_in), computed_in

    def close(self):
        termios.tcsetattr(self._fdin, termios.TCSADRAIN, self._oldcfg)


class OutputFile(Output):

    def __init__(self, path, *args, **kwargs):
        super(OutputFile, self).__init__(*args, **kwargs)
        self._path = path
        self._f = open(path, 'w')

    def write(self, raw, computed):
        self._f.write(raw)
        self._f.flush()

    def close(self):
        self._f.close()


class OutputUnixTerm(Output):

    def __init__(self, *args, **kwargs):
        super(OutputUnixTerm, self).__init__(*args, **kwargs)
        self.max_row = 1
        self.max_col = 1

    def update_term_size(self):
        term_size = shutil.get_terminal_size()

        self.max_row = term_size.lines
        self.max_col = term_size.columns

    def setup(self):
        sys.stdout.write("\x1b[H")
        sys.stdout.flush()

        self.update_term_size()

        for i in range(1, self.max_row):
            sys.stdout.write("\x1b[{};{}f".format(i, 1))
            for j in range(1, self.max_col):
                sys.stdout.write(' ')

        sys.stdout.write("\x1b[H")
        sys.stdout.flush()

    def write(self, raw, computed):
        if computed == Codes.NEWLINE:
            sys.stdout.write('\r\n')
        elif computed == Codes.ARROW_UP:
            sys.stdout.write("\x1b[A")
        elif computed == Codes.ARROW_DOWN:
            sys.stdout.write("\x1b[B")
        elif computed == Codes.ARROW_RIGHT:
            sys.stdout.write("\x1b[C")
        elif computed == Codes.ARROW_LEFT:
            sys.stdout.write("\x1b[D")
        else:
            sys.stdout.write(raw)

        sys.stdout.flush()

    def close(self):
        pass

    def cleanup(self):
        sys.stdout.write('\r')
        sys.stdout.flush()


class Editor(object):

    def __init__(self, kbd_input, scr_output):
        self._kin = kbd_input
        self._sout = scr_output

        self._outputs = []

        self._rows = 1
        self._current_row = 1
        self._current_col = 1

    def debug(self):
        with open('/tmp/editor.debug', 'w') as df:
            df.write('time: {}\n'.format(time.time()))
            df.write('rows: {}\n'.format(self._rows))
            df.write('col: {}\n'.format(self._current_col))
            df.write('row: {}\n'.format(self._current_row))
            df.write('max row: {}\n'.format(self._sout.max_row))
            df.write('max col: {}\n'.format(self._sout.max_col))

    def add_output(self, output):
        self._outputs.append(output)

    def quit(self):
        self._kin.close()
        self._sout.close()

        for output in self._outputs:
            output.close()

    def _handle_arrows(self, raw, computed):
        write_screen = False
        handled = False

        if computed == Codes.ARROW_UP:
            handled = True
            if self._current_row > 1:
                self._current_row -= 1
                write_screen = True

        elif computed == Codes.ARROW_RIGHT:
            handled = True
            if self._current_col < self._sout.max_col:
                self._current_col += 1
                write_screen = True

        elif computed == Codes.ARROW_DOWN:
            handled = True
            if self._current_row < self._sout.max_row:
                self._current_row += 1
                write_screen = True

        elif computed == Codes.ARROW_LEFT:
            handled = True
            if self._current_col > 1:
                self._current_col -= 1
                write_screen = True

        return write_screen, handled

    def _handle_alter(self, raw, computed):
        write_screen = False
        handled = False

        if computed == Codes.NEWLINE:
            self._rows += 1
            if self._current_row < self._sout.max_row:
                self._current_row += 1
            handled = True

        elif computed == Codes.BS:
            if self._current_col > 1:
                self._current_col -= 1
            handled = True

        return write_screen, handled

    def run(self):
        ex_quit = None
        try:
            self._sout.setup()
            while True:
                self._sout.update_term_size()
                self.debug()
                kbd_in_raw, kbd_in_computed = self._kin.read()
                write_screen = False
                handled = False

                if kbd_in_computed == Codes.EOT:
                    self.quit()
                    break

                write_screen, handled = self._handle_alter(
                    kbd_in_raw, kbd_in_computed)

                if handled == False:
                    write_screen, handled = self._handle_arrows(
                        kbd_in_raw, kbd_in_computed)

                if handled == False:
                    self._current_col += 1
                    write_screen = True

                if write_screen == True:
                    self._sout.write(kbd_in_raw, kbd_in_computed)

                for output in self._outputs:
                    output.write(kbd_in_raw, kbd_in_computed)

        except Exception as ex:
            self.quit()
            ex_quit = ex

        self._sout.cleanup()

        return ex_quit


def main():
    e = Editor(InputUnixTerm(), OutputUnixTerm())
    e.add_output(OutputFile('/tmp/editor.py.txt'))
    ex_quit = e.run()
    if ex_quit is not None:
        raise(ex_quit)

if __name__ == '__main__':
    main()
