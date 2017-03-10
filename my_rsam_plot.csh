#!/bin/csh
#my_rsam_plot.csh

set date = `date -u +%Y%m%d`
set monthdate = `date -u -d '1 month ago' +%Y%m%d`
set weekdate = `date -u -d '1 week ago' +%Y%m%d`

#WIZ.10-HHZ.NZ
#last month
/home/sherburn/scripts/rsam_plot.py WIZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $monthdate $date /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis

#WIZ.10-HHZ.NZ
#last week
/home/sherburn/scripts/rsam_plot.py WIZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $weekdate $date /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis


#WSRZ.10-HHZ.NZ
#last month
/home/sherburn/scripts/rsam_plot.py WSRZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $monthdate $date /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot2_month.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_month.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis

#WSRZ.10-HHZ.NZ
#last week
/home/sherburn/scripts/rsam_plot.py WSRZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $weekdate $date /home/sherburn/geonet/my_rsam bp 2 5
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot2_week.bp_2.00-5.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_week.bp_2.00-5.00.png volcano@volcano:/var/www/html/volcanoes/whiteis


#DRZ.10-EHZ.NZ
#last month
/home/sherburn/scripts/rsam_plot.py DRZ.10-EHZ.NZ /home/sherburn/data1/rsam_data $monthdate $date /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#DRZ.10-EHZ.NZ
#last week
/home/sherburn/scripts/rsam_plot.py DRZ.10-EHZ.NZ /home/sherburn/data1/rsam_data $weekdate $date /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#MAVZ.10-HHZ.NZ
#last month
/home/sherburn/scripts/rsam_plot.py MAVZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $monthdate $date /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot2_month.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_month.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#MAVZ.10-HHZ.NZ
#last week
/home/sherburn/scripts/rsam_plot.py MAVZ.10-HHZ.NZ /home/sherburn/data1/rsam_data $weekdate $date /home/sherburn/geonet/my_rsam bp 1 4
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot2_week.bp_1.00-4.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot2_week.bp_1.00-4.00.png volcano@volcano:/var/www/html/volcanoes/ruapehu

#RAR.10-BHZ.IU
#last month
/home/sherburn/scripts/rsam_plot.py RAR.10-BHZ.IU /home/sherburn/data1/rsam_data $monthdate $date /home/sherburn/geonet/my_rsam bp 1.5 6
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_1.50-6.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_month.bp_1.50-6.00.png volcano@volcano:/var/www/html/volcanoes/rarotonga

#RAR.10-BHZ.IU
#last week
/home/sherburn/scripts/rsam_plot.py RAR.10-BHZ.IU /home/sherburn/data1/rsam_data $weekdate $date /home/sherburn/geonet/my_rsam bp 1.5 6
\mv /home/sherburn/geonet/my_rsam/rsam_plot.png /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_1.50-6.00.png
scp /home/sherburn/geonet/my_rsam/rsam_plot_week.bp_1.50-6.00.png volcano@volcano:/var/www/html/volcanoes/rarotonga
