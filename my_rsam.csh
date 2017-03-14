#!/bin/csh
#my_rsam.csh

#run by crontab to make 10 min rsam files

set date = `date -u +%Y%m%d`

#WSRZ.10-HHZ.RT
rsam_sds.py WSRZ.10-HHZ.NZ ./sds $date ./workdir resp bp 2 5

#WIZ.10-HHZ.RT
rsam_sds.py WIZ.10-HHZ.NZ ./sds $date ./workdir resp bp 2 5

#DRZ.10-EHZ.CH
rsam_sds.py DRZ.10-EHZ.NZ ./sds $date ./workdir resp bp 1 4

#MAVZ.10-HHZ.CH
rsam_sds.py MAVZ.10-HHZ.NZ ./sds $date ./workdir resp bp 1 4

#RAR.10-BHZ.IU
#geonet has no response data for RAR
rsam_sds.py RAR.10-BHZ.IU ./sds $date ./workdir noresp bp 1.5 6

