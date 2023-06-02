IO model
========

Python is supposed to interact with outside world (i.e. everything
outside the interpretor) through numerous ways:

- ``open`` and ``input`` builtin functions.
- ``os`` module (e.g. ``os.open`` function)
- ``stdout``, ``stderr`` and ``stdin`` files descriptors
- ``__import__`` & co
- ``ctypes`` & micropython's ``ffi`` libraries
- ...

However those functions are no longer relevant when python is embedded
into Pandemonium. They can even be dangerous when opening a Pandemonium application to
modding given a 3rd party python code has suddently full access to the computer !

Hence, those functions needs to be adapted to Pandemonium:
- ``ctype``, ``ffi`` and ``open`` disabled
- ``stdout``, ``stderr`` and ``stdin`` redirected to Pandemonium editor's console
