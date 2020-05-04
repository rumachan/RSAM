#!/bin/bash

#run by crontab to make a daily file from 10 min files
function usage(){
cat <<EOF
Usage: $0 [Options]  

Options:
    -h              Show this message.
    -d              Pass a different date using the format yyyymmdd
    -w              Pass a different working directory path.
EOF
}


yesterday=`date -u -d 'yesterday' +%Y%m%d`
WORKDIR=./workdir

# Processing command line options
while [ $# -gt 0 ]
    do
        case "$1" in 
	    -d) yesterday="$2";shift;;
	    -h) usage; exit 0;;
	    -w) WORKDIR="$2";shift;;
	    -*) usage; exit 1;;
             *) break;;
	esac
	shift	
    done

echo processing date: $yesterday


#MAVZ.10-HHZ.NZ
rsam_day.py MAVZ.10-HHZ.NZ ${WORKDIR} $yesterday ${WORKDIR} bp 1 4

#WIZ.10-HHZ.NZ
rsam_day.py WIZ.10-HHZ.NZ ${WORKDIR} $yesterday ${WORKDIR} bp 2 5

#WSRZ.10-HHZ.NZ
rsam_day.py WSRZ.10-HHZ.NZ ${WORKDIR} $yesterday ${WORKDIR} bp 2 5

#RAR.10-BHZ.IU
rsam_day.py RAR.10-BHZ.IU ${WORKDIR} $yesterday ${WORKDIR} bp 1.5 6
