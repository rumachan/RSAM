#!/bin/bash

#########################################
# Build and run docker image            #
# 08/17 Y. Behr <y.behr@gns.cri.nz>     #
#########################################

RUNONLY=false
BUILDONLY=false

function usage(){
cat <<EOF
Usage: $0 [Options]

Build and run docker image. 

Options:
    -h              Show this message.
    -r              Only run image without rebuilding it.
    -b              Only rebuild image without running it.
    -t              Assign a tag to the docker image (default: latest).
EOF
}

TAG="latest"

# Processing command line options
while [ $# -gt 0 ]
do
    case "$1" in
        -r) RUNONLY=true;;
        -b) BUILDONLY=true;;
        -t) TAG=$2;shift;;
        -h) usage; exit 0;;
        -*) usage; exit 1;;
        *) break;;
esac
shift
done

if [ "${RUNONLY}" == "false" ]; then
    docker rmi yadabe/rsam:$TAG
    docker build --no-cache=true -t yadabe/rsam:$TAG .
fi

if [ "${BUILDONLY}" == "false" ] ;then
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam:$TAG my_rsam.sh
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam:$TAG my_rsam_plot.sh
#    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam:$TAG my_rsam_day.sh
#    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam:$TAG my_rsam_plot_day.sh
#    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam:$TAG ascii_daily.sh
fi


