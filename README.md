# RSAM
Calculate filtered RSAM values

## Docker

First get the source code:

```
git clone  --depth=1  https://github.com/rumachan/RSAM.git
```
Then build the docker image:

```
cd RSAM
docker build -t rsam .
```
The resulting docker image has three mount points that have to be mounted
so the scripts can run:

* `/home/volcano/workdir`: stores output files that need to be persistent between runs
* `/home/volcano/sds`: contains the (read-only) GeoNet sds archive
* `/home/volcano/output`: stores output files for the website

Let's assume the following setup:

|Contents                  |Host directory                | Container directory |
|--------------------------|------------------------------|---------------------|
|Persistent work directory |/home/volcano/rsam_work/      |/home/volcano/workdir|
|GeoNet SDS archive        |/geonet/seismic/sds           |/home/volcano/sds    |
|Output for web server     |/var/www/html/geonet_wiki_data|/home/volcano/output |

Then you can create a container and run, for example, the `my_rsam.csh` script for the first time as follows:

```
docker run --name my_rsam -it -v /geonet/seismic/sds:/home/volcano/sds \
-v /var/www/html/geonet_wiki_data:/home/volcano/output \
-v /home/volcano/rsam_work:/home/volcano/workdir  rsam my_rsam.csh
```
Afterwards you will only have to start the container to rerun `my_rsam.csh`:
```
docker start my_rsam
```
In the same way you can create containers for the other scripts.


**Note**: If the SDS archive is mounted using NFS, the NFS mount has to happen before the start of the docker daemon (at least with older versions of docker). In case of a remount of the NFS drive the docker daemon therefore has to be restarted:

```
sudo service docker restart
```
