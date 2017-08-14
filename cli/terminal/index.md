---
layout: page
title: Using the terminal
---

The guide also assumes some familiarity with using the command line interface
on your operating system. If you're unsure the following should help get you
started.

Windows
-------
This guide shows how to start a Windows command line client: http://www.computerhope.com/issues/chusedos.htm. If you've installed veraPDF to
the default location then it should be available directly below the directory
the command shell starts in. The initial prompt on my machine reads `C:\Users\cfw>`, so to go to the veraPDF install directly simply issue the
command <kbd>cd verapdf</kbd>, the session output should look as follows:

```
C:\Users\cfw>cd verapdf
C:\Users\cfw\verapdf>
```

You're now ready to start, you can check which version of veraPDF is installed
by typing <kbd>verapdf.bat --version</kbd> from the installation directory. You should see something like:

```
C:\Users\cfw\verapdf>verapdf.bat --version
veraPDF {{ site.verapdf_version_number }}-PDFBOX
Built: Fri Jan 13 11:30:00 GMT 2017
Developed and released by the veraPDF Consortium.
Funded by the PREFORMA project.
Released under the GNU General Public License v3
and the Mozilla Public License v2 or later.
```

although the version information might be different.

### Important note for Windows users
The instructions below assume you're running a Linux or Mac OS environment.
You'll still be able to follow them on a Windows machine but you'll have to
change the command slightly. Windows batch files have to end with a `.bat`
extension, this isn't necessary on other platforms. This means that you'll have to use `verpdf.bat` to run the Windows batch script instead of executing the `verapdf` command used on other platforms.

Mac OS
------
This is a good guide to starting a terminal session on a Mac: http://www.macworld.co.uk/feature/mac-software/get-more-out-of-os-x-terminal-3608274/. If you've installed veraPDF in the default directory then you should be
able to type the command <kbd>cd verapdf</kbd> to move into the installation directory. The session output should look like this:

```bash
dm-macmini:~ cfw$ cd verapdf
dm-macmini:verapdf cfw$
```

You can now check which version of the software is installed by typing
<kbd>./verapdf --version</kbd>, the output will look something like this:

```bash
dm-macmini:verapdf cfw$ ./verapdf --version
veraPDF {{ site.verapdf_version_number }}-PDFBOX
Built: Fri Jan 13 11:30:00 GMT 2017
Developed and released by the veraPDF Consortium.
Funded by the PREFORMA project.
Released under the GNU General Public License v3
and the Mozilla Public License v2 or later.
```

but perhaps with different version information.

Linux
-----
We'll assume that Linux users are quite comfortable with the command line
terminal. The name of the client and how you start it will depend upon your
particular distribution. If you're using a Debian based distribution you can
often start a terminal using the <kbd>CTRL+ALT+t</kbd> shortcut. If you've installed veraPDF in the default directory then you should be
able to type the command <kbd>cd verapdf</kbd> to move into the installation directory. The session output should look like this:

```bash
cfw@dm-wrkstn:~$ cd verapdf
cfw@dm-wrkstn:~/verapdf$
```

You can now check which version of the software is installed by typing
<kbd>./verapdf --version</kbd>, the output will look something like this:

```bash
cfw@dm-wrkstn:~/verapdf$ ./verapdf --version
veraPDF {{ site.verapdf_version_number }}-PDFBOX
Built: Fri Jan 13 11:30:00 GMT 2017
Developed and released by the veraPDF Consortium.
Funded by the PREFORMA project.
Released under the GNU General Public License v3
and the Mozilla Public License v2 or later.
```

Commands, aliases and paths
---------------------------
As installed you'll only be able to use the veraPDF CLI by typing
<kbd>./verapdf</kbd> from the installation directory. If you want to use it from another location you'll have to add the full path to the command, i.e. `/home/cfw/verapdf/verapdf` on Linux or `C:\Users\cfw\verapdf\verapdf.bat`
on Windows which can get a little awkward. Use the platform dependent tips
below to avoid this. This guide assumes you've done this to avoid typing
long commands.

### Windows: adding the installation directory to the path
You can add the installation directory to the `PATH` environment variable on
Windows. The operating system will search all directories on the path for the
command issued. To add the default veraPDF installation directory to the path
issue the command: <kbd>set PATH=%PATH%;C:\Users\cfw\verapdf</kbd> BUT replace
`cfw` with the name of your user home directory. On my machine this looks as
follows:

```
C:\Users\cfw>set PATH=%PATH%;C:\Users\cfw\verapdf

C:\Users\cfw>
```

### Linux or Mac OS: set up an alias for the veraPDF command
On these platforms you can extend the path, but it's often as convenient to
define an alias for the command. To be able to use the `verapdf` command from
any location type the command <kbd>alias verapdf='~/verapdf/verapdf'</kbd>.
This assumesyou've used the default installation directory, the `~` is
shorthand for the current users home directory.
