#!/bin/csh
#my_rsam.csh

#run by crontab to make 10 min rsam files

set date = `date -u +%Y%m%d`

#WSRZ.10-HHZ.RT
/home/sherburn/scripts/rsam_sds.py WSRZ.10-HHZ.NZ /geonet/seismic/sds $date /home/sherburn/data1/rsam_data resp bp 2 5

#WIZ.10-HHZ.RT
/home/sherburn/scripts/rsam_sds.py WIZ.10-HHZ.NZ /geonet/seismic/sds $date /home/sherburn/data1/rsam_data resp bp 2 5

#DRZ.10-EHZ.CH
/home/sherburn/scripts/rsam_sds.py DRZ.10-EHZ.NZ /geonet/seismic/sds $date /home/sherburn/data1/rsam_data resp bp 1 4

#MAVZ.10-HHZ.CH
/home/sherburn/scripts/rsam_sds.py MAVZ.10-HHZ.NZ /geonet/seismic/sds $date /home/sherburn/data1/rsam_data resp bp 1 4

#RAR.10-BHZ.IU
#geonet has no response data for RAR
/home/sherburn/scripts/rsam_sds.py RAR.10-BHZ.IU /geonet/seismic/sds $date /home/sherburn/data1/rsam_data noresp bp 1.5 6

#FDSN script
set date = `date -u +%Y-%m-%d`
set rsamdir = '/home/sherburn/data1/rsam_data'
#echo $rsamdir

#WSRZ.10-HHZ.RT
#/home/sherburn/scripts/rsam_fdsn.py -s WSRZ.10-HHZ.NZ -d $date -o $rsamdir -r -f bp -1 2 -2 5

#WIZ.10-HHZ.RT
#/home/sherburn/scripts/rsam_fdsn.py -s WIZ.10-HHZ.NZ-d  $date -o $rsamdir -r -f bp -1 2 -2 5

#DRZ.10-EHZ.CH
#/home/sherburn/scripts/rsam_fdsn.py -s DRZ.10-EHZ.NZ -d $date -o $rsamdir -r -f bp -1 1 -2 4

#MAVZ.10-HHZ.CH
#/home/sherburn/scripts/rsam_fdsn.py -s MAVZ.10-HHZ.NZ -d $date -o $rsamdir -r -f bp -1 1 -2 4

#RAR.10-BHZ.IU
#geonet has no response data for RAR
#/home/sherburn/scripts/rsam_fdsn.py -s RAR.10-BHZ.IU -d $date -o $rsamdir -f bp -1 1.5 -2 6
