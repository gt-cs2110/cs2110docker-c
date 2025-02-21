# cs2110docker-c

This Docker image is used by students enrolled in CS 2110 at the Georgia Institute of Technology. It contains a Ubuntu 22.04 image that contains the necessary tools for running programs in the course. In particular, it includes:

- Python and `lc3-ensemble-test` (for LC3 autograders)
- GCC, GDB, Valgrind (for C programming)
- mGBA (for GBA programming)

To start a container, run the `./cs2110docker.sh` script on MacOS/Linux or `./cs2110docker.bat` file on Windows.

Find the Docker Image on Docker Hub at <https://hub.docker.com/r/gtcs2110/cs2110docker-c>.

Derived from the previous CS 2110 Docker image: <https://github.com/gt-cs2110/cs2110docker>.

## Regarding GBA

Adding mGBA to the image increases the size by about 800 MB. However, some semesters don't have GBA as part of the course, so for every version of the image, we will have two tags: one including GBA and one without it. In [cs2110docker.sh](cs2110docker.sh#L3) and [cs2110docker.bat](cs2110docker.bat#L4), before releasing scripts to students, make sure `release="stable"` is changed to `release="stable-gba"` to pull the image with mGBA, and vice versa to pull the image without it (no quotes in batch file).

## Building the Image

To build the image without GBA, run:

```sh
docker build --push --platform linux/arm64/v8,linux/amd64 --tag gtcs2110/cs2110docker-c:<insert version here> .
```

To build the image with GBA, run:

```sh
docker build --push --platform linux/arm64/v8,linux/amd64 --tag gtcs2110/cs2110docker-c:<insert version here>-gba -f gba.Dockerfile .
```
