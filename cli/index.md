---
layout: page
title: veraPDF CLI Quick Start Guide
---

{{ page.title }}
================
The veraPDF command line interface is the best way of processing batches of
PDF/A files. It's designed for integrating with scripted workflows, or for
shell invocation from programs.

We assume you've already downloaded and installed the software, if not please
read the [installation guide](/install) first.

Using a terminal
----------------
The guide also assumes some familiarity with using the command line interface
on your operating system. If you're unsure the following should help get you
started.

### Windows
This guide shows how to start a Windows command line client: http://www.computerhope.com/issues/chusedos.htm. If you've installed veraPDF to
the default location then it should be available directly below the directory
the command shell starts in. The initial prompt on my machine reads `C:\Users\cfw>`, so to go to the veraPDF install directly simply issue the
command `cd verapdf`, the session output should look as follows:

    C:\Users\cfw>cd verapdf
    C:\Users\cfw\verapdf>

You're now ready to start, you can check which version of veraPDF is installed
by typing `verapdf.bat --version` from the installation directory. You should see something like:

    C:\Users\cfw\verapdf>verapdf.bat --version
    veraPDF 1.0.6-PDFBOX
    Built: Fri Jan 13 11:30:00 GMT 2017
    Developed and released by the veraPDF Consortium.
    Funded by the PREFORMA project.
    Released under the GNU General Public License v3
    and the Mozilla Public License v2 or later.

although the version information might be different.

#### Important note for Windows users
The instructions below assume you're running a Linux or Mac OS environment.
You'll still be able to follow them on a Windows machine but you'll have to
change the command slightly. Windows batch files have to end with a `.bat`
extension, this isn't necessary on other platforms. This means that you'll have to use `verpdf.bat` to run the Windows batch script instead of executing the `verapdf` command used on other platforms.

### Mac OS
This is a good guide to starting a terminal session on a Mac: http://www.macworld.co.uk/feature/mac-software/get-more-out-of-os-x-terminal-3608274/. If you've installed veraPDF in the default directory then you should be
able to type the command `cd verapdf` to move into the installation directory. The session output should look like this:

    dm-macmini:~ cfw$ cd verapdf
    dm-macmini:verapdf cfw$

You can now check which version of the software is installed by typing
`./verapdf --version`, the output will look something like this:

    dm-macmini:verapdf cfw$ ./verapdf --version
    veraPDF 1.0.6-PDFBOX
    Built: Fri Jan 13 11:30:00 GMT 2017
    Developed and released by the veraPDF Consortium.
    Funded by the PREFORMA project.
    Released under the GNU General Public License v3
    and the Mozilla Public License v2 or later.

but perhaps with different version information.

### Linux
We'll assume that Linux users are quite comfortable with the command line
terminal. The name of the client and how you start it will depend upon your
particular distribution. If you're using a Debian based distribution you can
often start a terminal using the `CTRL+ALT+T` shortcut. If you've installed veraPDF in the default directory then you should be
able to type the command `cd verapdf` to move into the installation directory. The session output should look like this:

    cfw@dm-wrkstn:~$ cd verapdf
    cfw@dm-wrkstn:~/verapdf$

You can now check which version of the software is installed by typing
`./verapdf --version`, the output will look something like this:

    cfw@dm-wrkstn:~/verapdf$ ./verapdf --version
    veraPDF 1.0.6-PDFBOX
    Built: Fri Jan 13 11:30:00 GMT 2017
    Developed and released by the veraPDF Consortium.
    Funded by the PREFORMA project.
    Released under the GNU General Public License v3
    and the Mozilla Public License v2 or later.

### Commands, aliases and paths
As installed you'll only be able to use the veraPDF CLI by typing `./verapdf` from the installation directory. If you want to use it from another location
you'll have to add the full path to the command, i.e. `/home/cfw/verapdf/verapdf` on Linux or `C:\Users\cfw\verapdf\verapdf.bat`
on Windows which can get a little awkward. Use the platform dependent tips
below to avoid this. The rest of the guide assumes you've done this to avoid
long commands.

#### Windows: adding the installation directory to the path
You can add the installation directory to the `PATH` environment variable on
Windows. The operating system will search all directories on the path for the
command issued. To add the default veraPDF installation directory to the path
issue the command: `set PATH=%PATH%;C:\Users\cfw\verapdf` BUT replace `cfw` with
the name of your user home directory. On my machine this looks as follows:

    C:\Users\cfw>set PATH=%PATH%;C:\Users\cfw\verapdf

    C:\Users\cfw>

#### Linux or Mac OS: set up an alias for the veraPDF command
On these platforms you can extend the path, but it's often as convenient to
define an alias for the command. To be able to use the `verapdf` command from
any location type the command `alias verapdf='~/verapdf/verapdf'`. This assumes
you've used the default installation directory, the `~` is shorthand for the
current users home directory.

Getting help
-----------
Once veraPDF has been installed you can get help on the full range of options by
typing `verapdf -h` or `verapdf --help` at the Mac or Linux command line. This
should be `verapdf.bat -h` or `verapdf.bat --help` on Windows (we won't keep
reminding you of the alternative Windows syntax). This should give the following
output, or something very similar:

    Usage: veraPDF [options] FILES
      Options:
        -x, --extract
           Extracts and reports PDF features.
           Default: false
        --fixmetadata
           Performs metadata fixes.
           Default: false
        -f, --flavour
           Chooses built-in Validation Profile flavour, e.g. '1b'. Alternatively,
           supply '0' or no argument for automatic flavour detection based on a file's
           metadata.
           Default: 0
           Possible Values: [0, 1a, 1b, 2a, 2b, 2u, 3a, 3b, 3u]
        --format
           Chooses output format.
           Default: mrr
           Possible Values: [xml, mrr, text]
        -h, --help
           Shows this message and exits.
           Default: false
        -l, --list
           Lists built-in Validation Profiles.
           Default: false
        --maxfailures
           Sets maximum amount of failed checks.
           Default: -1
        --maxfailuresdisplayed
           Sets maximum amount of failed checks displayed for each rule.
           Default: 100
        -o, --off
           Turns off PDF/A validation
           Default: false
        --policyfile
           Select a policy schematron or XSL file.
        --prefix
           Sets file name prefix for any fixed files.
           Default: veraFixMd_
        -p, --profile
           Loads a Validation Profile from given path and exits if loading fails.
           This overrides any choice or default implied by the -f / --flavour option.
        -r, --recurse
           Recurses through directories. Only files with .pdf extensions are
           processed.
           Default: false
        --savefolder
           Sets output directory for any fixed files.
           Default: <empty string>
        --success, --passed
           Logs successful validation checks.
           Default: false
        -v, --verbose
           Adds failed test information to text output.
           Default: false
        --version
           Displays veraPDF version information.
           Default: false
