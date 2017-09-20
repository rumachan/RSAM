#!/bin/bash

#run by crontab to make 10 min rsam files

function usage(){
cat <<EOF
Usage: $0 [Options]  

Options:
    -h              Show this message.
    -d              Pass a different date using the format yyyymmdd
EOF
}

date=`date -u +%Y%m%d`

# Processing command line options
while [ $# -gt 0 ]
    do
        case "$1" in 
	    -d) date="$2";shift;;
	    -h) usage; exit 0;;
	    -*) usage; exit 1;;
             *) break;;
	esac
	shift	
    done

echo processing date: $date

#WSRZ.10-HHZ.RT
rsam_sds.py WSRZ.10-HHZ.NZ ./sds $date ./workdir resp bp 2 5

#WIZ.10-HHZ.RT
rsam_sds.py WIZ.10-HHZ.NZ ./sds $date ./workdir resp bp 2 5

#DRZ.10-EHZ.CH
rsam_sds.py DRZ.10-EHZ.NZ ./sds $date ./workdir resp bp 1 4

#MAVZ.10-HHZ.CH
rsam_sds.py MAVZ.10-HHZ.NZ ./sds $date ./workdir resp bp 1 4

#TRVZ.10-HHZ.CH
rsam_sds.py TRVZ.10-HHZ.NZ ./sds $date ./workdir resp bp 1 4

#WHVZ.10-HHZ.CH
rsam_sds.py WHVZ.10-HHZ.NZ ./sds $date ./workdir resp bp 1 4

#RAR.10-BHZ.IU
#geonet has no response data for RAR
rsam_sds.py RAR.10-BHZ.IU ./sds $date ./workdir noresp bp 1.5 6

