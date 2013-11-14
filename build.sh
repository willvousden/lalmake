#!/bin/bash

set -e

# Source directory
if [[ ! -d $1 ]]; then
    echo "Invalid source directory!"
fi
SRCDIR=$(readlink -f $1)
cd $SRCDIR

#BRANCHNAME=$(basename $(git symbolic-ref HEAD))
#echo "Installing lsc software from $BRANCHNAME branch."

# This is where LAL Suite will go.
if [[ -z $LSCSOFT_ROOTDIR ]]; then
    echo "LSCSOFT_ROOTDIR not specified!"
    exit 1
fi
#ROOTDIR=$LSCSOFT_ROOTDIR/$BRANCHNAME
ROOTDIR=$LSCSOFT_ROOTDIR

echo "Building from $SRCDIR; installing to $ROOTDIR."

# Number of parallel processes in make.
NPROCS=4

# Default CFLAGS
CC=clang
CFLAGS="-march=native -g"

# Common flags to every configure process
COMMON_CONFIG_FLAGS="--enable-swig-python --enable-mpi --disable-laldetchar"

make_c() {
    make distclean || true
    ./00boot
    ./configure --prefix=$ROOTDIR $COMMON_CONFIG_FLAGS CC="$CC" CFLAGS="$CFLAGS"
    make -j $NPROCS
    make install
}

make_python() {
    . $ROOTDIR/etc/lscsoftrc

    cd $SRCDIR/pylal
    rm -rf build
    python setup.py install --prefix=$ROOTDIR
    . $ROOTDIR/etc/lscsoftrc

    cd $SRCDIR/glue
    rm -rf build
    python setup.py install --prefix=$ROOTDIR
    . $ROOTDIR/etc/lscsoftrc
}

shift
if [ $# -lt 1 ]; then
    make_c
    make_python
else
    while [ $# -ge 1 ]; do
        case $1 in
            c)
                make_c;;
            python)
                make_python;;
            *)
                echo "Unrecognized argument \"$1\".  Usage:"
                echo "build.sh [c] [python]"
                exit 1
        esac
        shift
    done
fi
