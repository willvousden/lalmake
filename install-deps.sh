#!/usr/bin/env bash

fail()
{
    local message=${1:-"Something went wrong!"}
    echo $message
    exit 1
}

capture_uninstall()
{
    # Takes the the name/path of the script to be generated as an argument.
    local target=$1:-"./uninstall.sh"}

    # Make sure directory exists (and file doesn't).
    if [[ ! -d $(dirname $target) ]]; then
        mkdir -p $(dirname $target)
    elif [[ -f $target ]]; then
        rm -f $target
    fi

    echo "#!/usr/bin/env sh" > $target

    local orig_rm=$(which rm)
    cat > rm <<EOF
    echo "rm \$*" 1>&3
    exit 0
EOF
    chmod +x rm

    orig_PATH=$PATH
    PATH=`pwd`:$PATH
    export PATH
    make uninstall 3>> $target
    PATH=$orig_PATH
    export PATH

    echo "rm -f $target" >> $target
    chmod +x $target
    $orig_rm -f rm
    return 0
}

install_dep()
{
    local src=$1
    local uninstall=$2
    local prefix=$3
    local flags=$4
    local orig_pwd=$(pwd)

    mkdir -p $prefix
    cd $src
    make distclean || true
    ./configure --prefix=$prefix $flags || fail
    make || fail
    make install || fail

    # Generate uninstall script.
    capture_uninstall $uninstall || fail
    echo "Uninstall script: $uninstall"

    cd $orig_pwd
}

libframe=$1
metaio=$2
lsc_user_env=$3
root=${4:-$LSCSOFT_ROOTDIR}

if [[ ! -d $libframe ]] || [[ ! -d $metaio ]] || [[ ! -d $lsc_user_env ]]; then
    fail "Source directories not given!"
fi

uninstall_dir=$root/uninstall
install_dep $libframe $uninstall_dir/libframe.sh $root/libframe "--disable-octave --disable-python --with-matlab=no"
install_dep $metaio $uninstall_dir/libmetaio.sh $root/libmetaio
install_dep $lsc_user_env $uninstall_dir/lscsoft-user-env.sh $root
