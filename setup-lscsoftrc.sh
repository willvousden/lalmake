#!/bin/bash

set -e

if [[ -z $LSCSOFT_ROOTDIR ]]; then
    echo "LSCSOFT_ROOTDIR not specified!"
    exit 1
fi

#SRCDIR=${1:-LSCSOFT_SRCDIR}
#BRANCHNAME=$(basename $(git --git-dir=$SRCDIR/.git --work-tree=$SRCDIR symbolic-ref HEAD))
#echo "Setting up lscsoftrc for $BRANCHNAME branch."
#ROOTDIR=$LSCSOFT_ROOTDIR/$BRANCHNAME
ROOTDIR=$LSCSOFT_ROOTDIR

echo "Generating $ROOTDIR/etc/lscsoftrc"
mkdir -p $ROOTDIR/etc
echo -n > $ROOTDIR/etc/lscsoftrc

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
export LSCSOFT_LOCATION=$ROOTDIR
# setup LAL for development:  
export LAL_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LAL_LOCATION/etc/lal-user-env.sh" ]; then
    source \$LAL_LOCATION/etc/lal-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALFrame for development:  
export LALFRAME_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALFRAME_LOCATION/etc/lalframe-user-env.sh" ]; then
    source \$LALFRAME_LOCATION/etc/lalframe-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALMetaIO for development:  
export LALMETAIO_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALMETAIO_LOCATION/etc/lalmetaio-user-env.sh" ]; then
    source \$LALMETAIO_LOCATION/etc/lalmetaio-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALSimulation for development:  
export LALSIMULATION_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALSIMULATION_LOCATION/etc/lalsimulation-user-env.sh" ]; then
    source \$LALSIMULATION_LOCATION/etc/lalsimulation-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALBurst for development:  
export LALBURST_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALBURST_LOCATION/etc/lalburst-user-env.sh" ]; then
    source \$LALBURST_LOCATION/etc/lalburst-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALInspiral for development:  
export LALINSPIRAL_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALINSPIRAL_LOCATION/etc/lalinspiral-user-env.sh" ]; then
    source \$LALINSPIRAL_LOCATION/etc/lalinspiral-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALSTOCHASTIC for development:  
export LALSTOCHASTIC_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALSTOCHASTIC_LOCATION/etc/lalstochastic-user-env.sh" ]; then
    source \$LALSTOCHASTIC_LOCATION/etc/lalstochastic-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALPULSAR for development:  
export LALPULSAR_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALPULSAR_LOCATION/etc/lalpulsar-user-env.sh" ]; then
    source \$LALPULSAR_LOCATION/etc/lalpulsar-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALInference for development:  
export LALINFERENCE_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALINFERENCE_LOCATION/etc/lalinference-user-env.sh" ]; then
    source \$LALINFERENCE_LOCATION/etc/lalinference-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup LALApps for development:  
export LALAPPS_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$LALAPPS_LOCATION/etc/lalapps-user-env.sh" ]; then
    source \$LALAPPS_LOCATION/etc/lalapps-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup PyLAL for development:  
export PYLAL_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$PYLAL_LOCATION/etc/pylal-user-env.sh" ]; then
    source \$PYLAL_LOCATION/etc/pylal-user-env.sh
fi
EOF

cat <<EOF >> $ROOTDIR/etc/lscsoftrc
# setup GLUE for development:  
export GLUE_LOCATION=\$LSCSOFT_LOCATION
if [ -f "\$GLUE_LOCATION/etc/glue-user-env.sh" ]; then
    source \$GLUE_LOCATION/etc/glue-user-env.sh
fi
EOF
