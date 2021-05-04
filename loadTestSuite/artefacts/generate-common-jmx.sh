#!/bin/bash

CURRENTDIR=$(pwd)
artefactDir="$CURRENTDIR/.artefacts/"

if [ ! -d "$artefactDir/.jmx-common-scripts" ]; then
curl -sfL https://github.com/dmxunlimit/tools/raw/master/loadTestSuite/artefacts/jmx-common-scripts.tar -o $artefactDir/jmx-common-scripts.tar
tar -xf $artefactDir/jmx-common-scripts.tar -C $artefactDir/
mkdir -p $CURRENTDIR/jmx_scripts
cp -rf $artefactDir/jmx-common-scripts/* $CURRENTDIR/jmx_scripts
else
cp -rf $artefactDir/jmx-common-scripts/* $CURRENTDIR/jmx_scripts
fi

if [ -d "$CURRENTDIR/jmx_scripts" ]; then


hostname='localhost'
port=9443
adminuser='admin'
adminpass='admin'

NoUser=1000
NoApps=200
startCounter=1

concurrency=50
timeToRunInMinutes=30
rampUpPeriod=10

timeToRun=$(( $timeToRunInMinutes * 60 ))

cred=$(echo -n $adminuser:$adminpass | base64)

##
sed -i '' -e 's/hostname_val/'$hostname'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/port_val/'$port'/g' $CURRENTDIR/jmx_scripts/*


##
sed -i '' -e 's/userCount_val/'$NoUser'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/sp_apps_val/'$NoApps'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/startCounter_val/'$startCounter'/g' $CURRENTDIR/jmx_scripts/*


###
sed -i '' -e 's/timeToRun_val/'$timeToRun'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/concurrency_val/'$concurrency'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/rampUpPeriod_val/'$rampUpPeriod'/g' $CURRENTDIR/jmx_scripts/*


##
sed -i '' -e 's/base64AdminCred_val/'$cred'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/admin_user_val/'$adminuser'/g' $CURRENTDIR/jmx_scripts/*

sed -i '' -e 's/admin_password_val/'$adminpass'/g' $CURRENTDIR/jmx_scripts/*

echo "Common JMX scripts has generated in jmx_scripts !"
else
echo "Unable to get the base jmx scripts !"
fi

