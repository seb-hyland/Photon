#!/bin/bash

nohup bash -c '
if ping -c 1 -W 2 8.8.8.8 > /dev/null 2>&1; then
    wget -q -O newversion https://gitlab.com/seb-hyland/photon/-/raw/master/version
    if cmp --silent  -- newversion version; then
	    rm newversion
	    /bin/bash photonstarter.sh &
	    exit 0
    else
	    cp newversion version
	    rm newversion
    fi
else
    /bin/bash photonstarter.sh &
    exit 0
fi

wget -q -O photonupdater.sh https://gitlab.com/seb-hyland/photon/-/raw/master/photonupdater.sh
/bin/bash photonupdater.sh &
exit 0
' &
