#!/usr/bin/env bash

set -e

if [[ -z $1 ]]; then
    echo "Install location not specified!"
    exit 1
fi

if [[ -z $2 ]]; then
    echo "Target file not specified!"
    exit 1
fi

#SRCDIR=${1:-LSCSOFT_SRCDIR}
#BRANCHNAME=$(basename $(git --git-dir=$SRCDIR/.git --work-tree=$SRCDIR symbolic-ref HEAD))
#echo "Setting up lscsoftrc for $BRANCHNAME branch."
#ROOTDIR=$LSCSOFT_ROOTDIR/$BRANCHNAME
ROOTDIR=$1
FILE=$2

echo "Generating $FILE"
mkdir -p $(dirname $FILE)
echo -n > $FILE

cat <<EOF >> $FILE
export LSCSOFT_LOCATION=$ROOTDIR

# Set up individual modules for development...

EOF

cat <<EOF >> $FILE
if [[ -z \$LAL_LOCATION ]]; then
    export LAL_LOCATION=\$LSCSOFT_LOCATION
    . \$LAL_LOCATION/etc/lal-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALFRAME_LOCATION ]]; then
    export LALFRAME_LOCATION=\$LSCSOFT_LOCATION
    . \$LALFRAME_LOCATION/etc/lalframe-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALMETAIO_LOCATION ]]; then
    export LALMETAIO_LOCATION=\$LSCSOFT_LOCATION
    . \$LALMETAIO_LOCATION/etc/lalmetaio-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALSIMULATION_LOCATION ]]; then
    export LALSIMULATION_LOCATION=\$LSCSOFT_LOCATION
    . \$LALSIMULATION_LOCATION/etc/lalsimulation-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALBURST_LOCATION ]]; then
    export LALBURST_LOCATION=\$LSCSOFT_LOCATION
    . \$LALBURST_LOCATION/etc/lalburst-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALINSPIRAL_LOCATION ]]; then
    export LALINSPIRAL_LOCATION=\$LSCSOFT_LOCATION
    . \$LALINSPIRAL_LOCATION/etc/lalinspiral-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALSTOCHASTIC_LOCATION ]]; then
    export LALSTOCHASTIC_LOCATION=\$LSCSOFT_LOCATION
    . \$LALSTOCHASTIC_LOCATION/etc/lalstochastic-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALPULSAR_LOCATION ]]; then
    export LALPULSAR_LOCATION=\$LSCSOFT_LOCATION
    . \$LALPULSAR_LOCATION/etc/lalpulsar-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALINFERENCE_LOCATION ]]; then
    export LALINFERENCE_LOCATION=\$LSCSOFT_LOCATION
    . \$LALINFERENCE_LOCATION/etc/lalinference-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$LALAPPS_LOCATION ]]; then
    export LALAPPS_LOCATION=\$LSCSOFT_LOCATION
    . \$LALAPPS_LOCATION/etc/lalapps-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$PYLAL_LOCATION ]]; then
    export PYLAL_LOCATION=\$LSCSOFT_LOCATION
    . \$PYLAL_LOCATION/etc/pylal-user-env.sh &> /dev/null || true
fi

EOF

cat <<EOF >> $FILE
if [[ -z \$GLUE_LOCATION ]]; then
    export GLUE_LOCATION=\$LSCSOFT_LOCATION
    . \$GLUE_LOCATION/etc/glue-user-env.sh &> /dev/null || true
fi

EOF
