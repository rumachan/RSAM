#!/bin/csh
#my_rsam_plot_day.csh

set last_year = `date -u -d '1 year ago' +%Y`
set this_year = `date -u +%Y`

#DRZ.10-EHZ.NZ
set first_year = 2008
/home/sherburn/scripts/rsam_plot_day.py DRZ.10-EHZ.NZ /home/sherburn/data1/rsam_data $first_year $this_year /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot_day.png /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#MAVZ.10-HHZ.NZ
set first_year = 2013
/home/sherburn/scripts/rsam_plot_day.py MAVZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $first_year $this_year /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot_day.png /home/sherburn/geonet/my_rsam/rsam_plot2_day.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_day.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#WIZ.10-HHZ.NZ
set first_year = 2007
/home/sherburn/scripts/rsam_plot_day.py WIZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $first_year $this_year /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot_day.png /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis

#WSRZ.10-HHZ.NZ
set first_year = 2013
/home/sherburn/scripts/rsam_plot_day.py WSRZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $first_year $this_year /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot_day.png /home/sherburn/geonet/my_rsam/rsam_plot2_day.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_day.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis

#RAR.10-BHZ.IU
set first_year = 2015
/home/sherburn/scripts/rsam_plot_day.py RAR.10-BHZ.IU /home/sherburn/data1/rsam_data $first_year $this_year /home/sherburn/geonet/my_rsam bp 1.5 6
\mv /home/sherburn/geonet/my_rsam/rsam_plot_day.png /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_1.50-6.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_day.bp_1.50-6.00.png volcano@volcano:/var/www/html/volcanoes/rarotonga
