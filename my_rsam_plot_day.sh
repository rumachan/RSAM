#!/bin/bash
#my_rsam_plot_day.sh

last_year=`date -u -d '1 year ago' +%Y`
this_year=`date -u +%Y`

#MAVZ.10-HHZ.NZ
first_year=2013
rsam_plot_day.py MAVZ.10-HHZ.NZ /workdir $first_year $this_year /workdir/my_rsam bp 1 4
\mv /workdir/my_rsam/rsam_plot_day.png /output/MAVZ.rsam_plot2_day.bp_1.00-4.00.png

#WIZ.10-HHZ.NZ
first_year=2007
rsam_plot_day.py WIZ.10-HHZ.NZ /workdir $first_year $this_year /workdir/my_rsam bp 2 5
\mv /workdir/my_rsam/rsam_plot_day.png /output/WIZ.rsam_plot_day.bp_2.00-5.00.png

#WSRZ.10-HHZ.NZ
first_year=2013
rsam_plot_day.py WSRZ.10-HHZ.NZ /workdir $first_year $this_year /workdir/my_rsam bp 2 5
\mv /workdir/my_rsam/rsam_plot_day.png /output/WSRZ.rsam_plot2_day.bp_2.00-5.00.png

#RAR.10-BHZ.IU
first_year=2015
rsam_plot_day.py RAR.10-BHZ.IU /workdir $first_year $this_year /workdir/my_rsam bp 1.5 6
\mv /workdir/my_rsam/rsam_plot_day.png /output/RAR.rsam_plot_day.bp_1.50-6.00.png
