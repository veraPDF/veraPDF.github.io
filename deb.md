Notes on first pass Debian packaging
====================================

Configuring build shell environment
-----------------------------
Initialise environment variables `$DEBFULLNAME` and `$DEBEMAIL` for Debian
packaging tools:

    $ cat >>~/.bashrc <<EOF
    DEBFULLNAME="Carl Wilson"
    DEBEMAIL="carl@openpreservation.org"
    export DEBFULLNAME DEBEMAIL
    EOF
    $ source ~/.bashrc
    sudo apt-get install apt-file
    sudo apt-get install git git-doc git-extras git-flow git-man git-sh
    cd /vagrant
    git clone https://github.com/veraPDF/veraPDF-library.git
    mh_make

verapdf-library
---------------
