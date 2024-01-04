# cs2110docker-c

This Docker image is used by students enrolled in CS 2110 at the Georgia Institute of Technology. It contains an Ubuntu 22.04 image that contains the necessary tools for any C programming done in the class (gcc/gdb, valgrind, mgba).

To start a container, run the cs2110docker.sh script on MacOS/Linux or cs2110docker.bat file on Windows.

Find the Docker Image on Docker Hub at https://hub.docker.com/r/gtcs2110/cs2110docker-c

Derived from the previous CS 2110 Docker image: https://github.com/gt-cs2110/cs2110docker

## Regarding GBA

Adding mGBA to the image increases the size by about 800 MB. However some semesters don't have GBA as part of the course, so for every version of the image, we will have two tags: one including GBA and one without it. In [cs2110docker.sh](cs2110docker.sh#L3) and [cs2110docker.bat](cs2110docker.bat#L4), before releasing scripts to students, make sure `release="stable"` is changed to `release="stable-gba"` to pull the image with mGBA, and vice versa to pull the image without it (no quotes in batch file). 

Another thing to note is that this image does not contain an emulator. It provides just the dependencies the student needs to build a GBA file, from their source code, which a student can then run on an emulator on their host machine.

## Building the Image

Use multi-architecture builds to get an image for both amd64 and arm64: https://www.docker.com/blog/multi-arch-build-and-images-the-simple-way

Run the following from the root directory of the repo to build the image and push to Dockerhub.

To exclude mGBA: `docker buildx build --push --platform linux/arm64/v8,linux/amd64 --tag gtcs2110/cs2110docker-c:<insert version here> .`

To include mGBA: `docker buildx build --build-arg GBA="yes" --push --platform linux/arm64/v8,linux/amd64 --tag gtcs2110/cs2110docker-c:<insert version here>-gba .`

TODO: Create a pipeline to automatically 