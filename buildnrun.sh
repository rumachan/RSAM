#!/bin/bash

#########################################
# Build and run docker image            #
# 08/17 Y. Behr <y.behr@gns.cri.nz>     #
#########################################

CONTAINERONLY=false
IMAGEONLY=false

function usage(){
cat <<EOF
Usage: $0 [Options]

Build and run docker image. 

Options:
    -h              Show this message.
    -r              Only run image without rebuilding it.
    -b              Only rebuild image without running it.
EOF
}

# Processing command line options
while [ $# -gt 0 ]
do
    case "$1" in
        -r) CONTAINERONLY=true;;
        -i) IMAGEONLY=true;;
        -h) usage; exit 0;;
        -*) usage; exit 1;;
        *) break;;
esac
shift
done

if [ "${CONTAINERONLY}" == "false" ]; then
    docker rmi yadabe/rsam
    docker build --no-cache=true -t yadabe/rsam .
fi

if [ "${IMAGEONLY}" == "false" ] ;then
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam my_rsam.sh
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam my_rsam_plot.csh
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam my_rsam_day.sh
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam my_rsam_plot_day.csh
    docker run --rm -v html:/output -v rsam:/workdir yadabe/rsam ascii_daily.sh


fi


