import sys
import builtins
import traceback
from io import TextIOBase
from threading import Lock

from pandemonium._hazmat.conversion cimport (
    pandemonium_string_to_pyobj,
    pyobj_to_pandemonium_string,
    pandemonium_variant_to_pyobj,
)
from pandemonium._hazmat.gdnative_api_struct cimport (
    pandemonium_string,
    pandemonium_string_name,
    pandemonium_bool,
    pandemonium_array,
    pandemonium_pool_string_array,
    pandemonium_object,
    pandemonium_variant,
    pandemonium_variant_call_error,
    pandemonium_method_rpc_mode,
    pandemonium_pluginscript_script_data,
    pandemonium_pluginscript_instance_data,
    pandemonium_variant_call_error_error,
    pandemonium_variant_type
)


cpdef inline void pandemonium_print(str pystr):
    cdef pandemonium_string gdstr
    pyobj_to_pandemonium_string(pystr, &gdstr)
    with nogil:
        gdapi10.pandemonium_print(&gdstr)
        gdapi10.pandemonium_string_destroy(&gdstr)


class StdinCapture(TextIOBase):
    def __init__(self):
        self._enabled = False
        self._old_stdin = None

    def install(self):
        if self._enabled:
            raise RuntimeError("Already enabled !")

        self._old_stdin = sys.stdin
        sys.stdin = self
        self._enabled = True

    def remove(self):
        if not self._enabled:
            raise RuntimeError("Not enabled !")
        sys.stdin = self._old_stdin
        self._enabled = False


class StdoutStderrCapture(TextIOBase):
    def __init__(self):
        self._enabled = False
        self._old_stdout = None
        self._old_stderr = None

    def install(self):
        if self._enabled:
            raise RuntimeError("Already enabled !")

        self._old_stderr = sys.stderr
        sys.stderr = self
        self._old_stdout = sys.stdout
        sys.stdout = self
        self._enabled = True

        # Don't forget to flush the original streams if any (for instance Windows
        # GUI app without console have sys.__stdout__/__stderr__ set to None)
        if self._old_stdout is not None:
            self._old_stdout.flush()
        if self._old_stdout is not None:
            self._old_stdout.flush()

    def remove(self):
        if not self._enabled:
            raise RuntimeError("Not enabled !")
        # # Sanity check, we shouldn't be mixing
        # if sys.stderr is not self._stderr or sys.stdout is not self._stdout:
        #     raise RuntimeError("sys.stderr/stdout has been patched in our back !")
        sys.stderr = self._old_stderr
        sys.stdout = self._old_stdout
        self._enabled = False


class StdoutStderrCaptureToPandemonium(StdoutStderrCapture):

    def __init__(self):
        self.buffer = ""
        self.callbacks = {}
        self._enabled = False
        self._old_stdout = None
        self._old_stderr = None
        self._lock = Lock()

    def write(self, b):
        with self._lock:
            self.buffer += b
            if "\n" in self.buffer:
                to_print, self.buffer = self.buffer.rsplit("\n", 1)
                self._write(to_print)

    def flush(self):
        with self._lock:
            if self.buffer:
                self._write(self.buffer)
                self.buffer = ""

    def _write(self, buff):
        cdef pandemonium_string gdstr
        pyobj_to_pandemonium_string(buff, &gdstr)
        with nogil:
            gdapi10.pandemonium_print(&gdstr)
            gdapi10.pandemonium_string_destroy(&gdstr)


cdef _capture_io_streams = None


cdef install_io_streams_capture():
    global _capture_io_streams
    assert _capture_io_streams is None
    _capture_io_streams = StdoutStderrCaptureToPandemonium()
    _capture_io_streams.install()
