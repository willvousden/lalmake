#!/usr/bin/env bash

set -e

# Remember script directory.
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Source directory
if [[ ! -d $1 ]]; then
    echo "Invalid source directory!"
fi
SRCDIR=$(readlink -f $1)

# This is where LAL Suite will go.
if [[ -z $LSCSOFT_ROOTDIR ]]; then
    echo "LSCSOFT_ROOTDIR not specified!"
    exit 1
fi
ROOTDIR=$LSCSOFT_ROOTDIR

#BRANCHNAME=$(basename $(git symbolic-ref HEAD))
#echo "Installing lsc software from $BRANCHNAME branch."
#ROOTDIR=$LSCSOFT_ROOTDIR/$BRANCHNAME

echo "Building from $SRCDIR; installing to $ROOTDIR."
cd $SRCDIR

# Number of parallel processes in make.
NPROCS=4

# Default CFLAGS. Use clang if it's available.
CFLAGS="-march=native -g"
if [[ -x $(which clang) ]]; then
    CC=clang
fi

# Common flags to every configure process.
COMMON_CONFIG_FLAGS="--enable-swig-python --enable-mpi --disable-laldetchar"

# lscsoftrc location.
RCFILE=$ROOTDIR/etc/lscsoftrc

make_c() {
    make distclean || true
    ./00boot
    ./configure --prefix=$ROOTDIR $COMMON_CONFIG_FLAGS CC="$CC" CFLAGS="$CFLAGS"
    make -j $NPROCS
    make install

    # Generate lscsoftrc.
    . $SCRIPTDIR/generate-rc.sh $ROOTDIR $RCFILE
}

make_python() {
    if [[ ! -f $RCFILE ]]; then
        fail "Could not find $RCFILE."
    fi
    . $RCFILE

    cd $SRCDIR/pylal
    rm -rf build
    python setup.py install --prefix=$ROOTDIR
    . $RCFILE

    cd $SRCDIR/glue
    rm -rf build
    python setup.py install --prefix=$ROOTDIR
    . $RCFILE
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
