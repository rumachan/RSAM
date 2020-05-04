#!/bin/bash

#make ascii daily files MAVZ
rsamfile2ascii.py ./workdir/MAVZ.NZ/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2018.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2018.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2019.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2019.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
rsamfile2ascii.py ./workdir/MAVZ.NZ/2020.MAVZ.10-HHZ.NZ.bp_1.00-4.00.rsam ./workdir/my_rsam/2020.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc
                  
cat ./workdir/my_rsam/2013.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2014.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2015.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2016.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2017.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2018.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc  ./workdir/my_rsam/2019.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc ./workdir/my_rsam/2020.MAVZ.10-HHZ.NZ.bp_1.00-4.00.asc > ./workdir/my_rsam/MAVZ.asc

sed -i '/TIME/d' ./workdir/my_rsam/MAVZ.asc
