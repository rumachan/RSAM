# RSAM
Calculate filtered RSAM values

## Docker

To install and run the scripts in a docker image proceed as follows.

First get the source code:

```
git clone  --depth=1  https://github.com/rumachan/RSAM.git
```

To build and run the docker image you can use the `buildnrun.sh` script:

```
cd RSAM
./buildnrun.sh -h
Usage: ./buildnrun.sh [Options]

Build and run docker image.

Options:
    -h              Show this message.
    -r              Only run image without rebuilding it.
    -b              Only rebuild image without running it.
    -t              Assign a tag to the docker image (default: latest).
```

By default `buildnrun.sh` runs both the build and run stage.

Using the `buildnrun.sh` script also requires two docker volumes to be present: `html` and `rsam`.
To generate them run:

```
docker volume create html
docker volume create rsam
```

The volume `rsam` stores the past RSAM values and final plots are stored in `html`.

