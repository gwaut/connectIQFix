# ConnectIQ Simulator does not work on Ubuntu 20.04.

When starting the connectIQ simulator the following error is shown:
```
error while loading shared libraries: libpng12.so.0: cannot open shared object file: No such file or directory
```
## Solution
Copy the fixit script in the directory of the connectIQ SDK. Make it executable if needed:
```bash
chmod +x fixit.sh
```
The script will download all missing dependencies and will install them in the 'extra-libs' dir in the root of the connectIQ SDK directory.

It will modify the existing connectiq script, so that it will use the newly installed (old) shared libraries.