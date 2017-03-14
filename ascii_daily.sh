#!/bin/bash

#make ascii daily files DRZ
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2008.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2008.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2009.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2009.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2010.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2010.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2011.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2011.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2012.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2012.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2013.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2013.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2014.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2014.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2015.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2015.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2016.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2016.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc
#rsamfile2ascii.py /home/sherburn/data1/rsam_data/DRZ.NZ/2017.DRZ.10-EHZ.NZ.bp_1.00-4.00.rsam /home/sherburn/geonet/my_rsam/2017.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc

#cat /home/sherburn/geonet/my_rsam/2008.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2009.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2010.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2011.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2012.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2013.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2014.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2015.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2016.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc /home/sherburn/geonet/my_rsam/2017.DRZ.10-EHZ.NZ.bp_1.00-4.00.asc > /home/sherburn/geonet/my_rsam/DRZ.asc

#sed -i '/TIME/d' /home/sherburn/geonet/my_rsam/DRZ.asc

#make ascii daily files MAVZ
rsamfile2ascii.py ./workdir/MAVZ.NZ/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
                  
cat ./workdir/my_rsam/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc > ./workdir/my_rsam/MAVZ.asc

sed -i '/TIME/d' ./workdir/my_rsam/MAVZ.asc
