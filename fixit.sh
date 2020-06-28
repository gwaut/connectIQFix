#!/bin/bash

SIMILATORLOCATION="$(dirname $0)/bin/connectiq"

function checkSDKDdir() {
   if [[  ! -e ${SIMILATORLOCATION} ]]; then
        echo "Copy the fixit script to the root directory of the ConnectIQ SDK" >&2
        exit 1
   fi  
}

function installDependency() {
    local packageUrl=$1
    local filenamePackage=$(basename ${packageUrl})

    if [[ ! -e ${filenamePackage} ]]; then
        wget ${packageUrl}
        if [[ $? -ne 0 ]]; then
           echo "Unable to download ${filenamePackage}. Check url and try again!" >&2
           exit 1
        fi
    fi

    dpkg -x ${filenamePackage} 'extra-libs'
    if [[ $? -ne 0 ]]; then
       echo "Unable to extract ${filenamePackage}" >&2
       exit 1
    fi
}

function modifyConnectIQFile() {
   sed  -i.${$} 's@"$MB_HOME"/simulator@LD_LIBRARY_PATH=$LD_LIBRARY_PATH:"../extra-libs/lib/x86_64-linux-gnu:../extra-libs/usr/lib/x86_64-linux-gnu" "$MB_HOME"/simulator@' ${SIMILATORLOCATION}
}

checkSDKDdir

installDependency http://security.ubuntu.com/ubuntu/pool/main/libp/libpng/libpng12-0_1.2.54-1ubuntu1.1_amd64.deb
installDependency http://archive.ubuntu.com/ubuntu/pool/universe/w/webkitgtk/libwebkitgtk-1.0-0_2.4.11-3ubuntu3_amd64.deb
installDependency http://archive.ubuntu.com/ubuntu/pool/universe/w/webkitgtk/libjavascriptcoregtk-1.0-0_2.4.11-3ubuntu3_amd64.deb
installDependency http://nl.archive.ubuntu.com/ubuntu/pool/main/e/enchant/libenchant1c2a_1.6.0-11.1_amd64.deb
installDependency http://archive.ubuntu.com/ubuntu/pool/main/i/icu/libicu60_60.2-3ubuntu3_amd64.deb

modifyConnectIQFile