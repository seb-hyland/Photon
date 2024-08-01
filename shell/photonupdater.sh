#!/bin/bash

echo "
     ________________________
    |                        |
    |   Currently updating   |
    |        Photon...       |
    |________________________|
    "

# Pull new docker image and then start Photon
docker pull sebastianhyland/photon:latest 2>&1
/bin/bash photonstarter.sh &
exit 0
