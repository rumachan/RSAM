#!/bin/csh
#my_rsam_plot.csh

set date = `date -u +%Y%m%d`
set monthdate = `date -u -d '1 month ago' +%Y%m%d`
set weekdate = `date -u -d '1 week ago' +%Y%m%d`

mkdir -p ./workdir/my_rsam
#WIZ.10-HHZ.NZ
#last month
rsam_plot.py WIZ.10-HHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 1500 bp 2 5
\mv ./workdir/my_rsam/rsam_plot.png ./output/WIZ.rsam_plot_month.bp_2.00-5.00.png

#WIZ.10-HHZ.NZ
#last week
rsam_plot.py WIZ.10-HHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 1500 bp 2 5
\mv ./workdir/my_rsam/rsam_plot.png ./output/WIZ.rsam_plot_week.bp_2.00-5.00.png

#WSRZ.10-HHZ.NZ
#last month
rsam_plot.py WSRZ.10-HHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 2780 bp 2 5
\mv ./workdir/my_rsam/rsam_plot.png ./output/WSRZ.rsam_plot2_month.bp_2.00-5.00.png

#WSRZ.10-HHZ.NZ
#last week
rsam_plot.py WSRZ.10-HHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 2780 bp 2 5
\mv ./workdir/my_rsam/rsam_plot.png ./output/WSRZ.rsam_plot2_week.bp_2.00-5.00.png

#DRZ.10-EHZ.NZ
#last month
rsam_plot.py DRZ.10-EHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 0 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/DRZ.rsam_plot_month.bp_1.00-4.00.png

#DRZ.10-EHZ.NZ
#last week
rsam_plot.py DRZ.10-EHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 0 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/DRZ.rsam_plot_week.bp_1.00-4.00.png

#MAVZ.10-HHZ.NZ
#last month
rsam_plot.py MAVZ.10-HHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 330 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/MAVZ.rsam_plot2_month.bp_1.00-4.00.png

#MAVZ.10-HHZ.NZ
#last week
rsam_plot.py MAVZ.10-HHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 330 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/MAVZ.rsam_plot2_week.bp_1.00-4.00.png

#TRVZ.10-HHZ.NZ
#last month
rsam_plot.py TRVZ.10-HHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 130 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/TRVZ.rsam_plot2_month.bp_1.00-4.00.png

#TRVZ.10-HHZ.NZ
#last week
rsam_plot.py TRVZ.10-HHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 130 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/TRVZ.rsam_plot2_week.bp_1.00-4.00.png

#WHVZ.10-HHZ.NZ
#last month
rsam_plot.py WHVZ.10-HHZ.NZ ./workdir $monthdate $date ./workdir/my_rsam 140 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/WHVZ.rsam_plot2_month.bp_1.00-4.00.png

#WHVZ.10-HHZ.NZ
#last week
rsam_plot.py WHVZ.10-HHZ.NZ ./workdir $weekdate $date ./workdir/my_rsam 140 bp 1 4
\mv ./workdir/my_rsam/rsam_plot.png ./output/WHVZ.rsam_plot2_week.bp_1.00-4.00.png

#RAR.10-BHZ.IU
#last month
rsam_plot.py RAR.10-BHZ.IU ./workdir $monthdate $date ./workdir/my_rsam 0 bp 1.5 6
\mv ./workdir/my_rsam/rsam_plot.png ./output/RAR.rsam_plot_month.bp_1.50-6.00.png

#RAR.10-BHZ.IU
#last week
rsam_plot.py RAR.10-BHZ.IU ./workdir $weekdate $date ./workdir/my_rsam 0 bp 1.5 6
\mv ./workdir/my_rsam/rsam_plot.png ./output/RAR.rsam_plot_week.bp_1.50-6.00.png
