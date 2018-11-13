# ISC Locator in a Docker
[![Build Status](https://travis-ci.org/International-Seismological-Centre/docker-isclocator.svg?branch=master)](https://travis-ci.org/International-Seismological-Centre/docker-isclocator)
[![GitHub Open Issues](https://img.shields.io/github/issues/International-Seismological-Centre/docker-isclocator.svg)](https://github.com/International-Seismological-Centre/docker-isclocator/issues)
[![GitHub Stars](https://img.shields.io/github/stars/International-Seismological-Centre/docker-isclocator.svg)](https://github.com/International-Seismological-Centre/docker-isclocator)
[![GitHub Forks](https://img.shields.io/github/forks/International-Seismological-Centre/docker-isclocator.svg)](https://github.com/International-Seismological-Centre/docker-isclocator)  
[![Stars on Docker Hub](https://img.shields.io/docker/stars/iscdev/iscloc.svg)](https://hub.docker.com/r/iscdev/iscloc)
[![Pulls on Docker Hub](https://img.shields.io/docker/pulls/iscdev/iscloc.svg)](https://hub.docker.com/r/iscdev/iscloc)  
[![Docker Layers](https://badge.imagelayers.io/iscdev/iscloc:latest.svg)](https://hub.docker.com/r/iscdev/iscloc)

[![Deploy to Docker Cloud](https://files.cloud.docker.com/images/deploy-to-dockercloud.svg)](https://cloud.docker.com/stack/deploy/?repo=https://github.com/International-Seismological-Centre/docker-isclocator/tree/master)

This project was created to allow users on all platforms to be able to use ISC Locator without a need of compiling it. ISC Locator can be found and downloaded on our [offcial website](http://www.isc.ac.uk/iscbulletin/iscloc/).

[This container](https://hub.docker.com/r/iscdev/iscloc/) is built that **two** extra parameters provided to docker run will be passed directly to iscloc command. For example, if you run:

	docker run [run options] iscdev/iscloc /data/in_file.dat /data/out_file.log

you pass `/data/in_file.dat` and `/data/out_file.log` to iscloc program.

---
**For more information how to install and configure Docker [click here](https://docs.docker.com/engine/installation/)**

---
### Required parameters
Thic container need three parameters to be spcified in order to work correctly and save output to file. Two of which were mentioned above and one extra parameter for shared folder with host os and docker image.

- 1. Mount volume with files to process using `iscloc`. Files need to be mounted from host OS to running docker container using `-v` (volume) option.
- 2. Input file path (inside running container)
- 3. Output file path (inside running container which coresponds to mounted volume on host OS)

### Usage
We will mount `$PWD` into `/data/` folder inside docker container.  
`$PWD` = working directory ([more information](http://www.cyberciti.biz/faq/pwd-linux-unix-command-examples/))

    docker run \
      --rm \
      -v $PWD:/data \
      iscdev/iscloc /data/isf_test_input.dat /data/my_output_file.out

options explenation:

|option|notes|
|:----:|:----|
|`--rm`|# Removes container after task is finished. (Files will be saved)|
|`-v $PWD:/data`| Mounting directory from host OS to `/data` inside of the running container |
|`/data/isf_test_input.dat`| Input file that should be located in `~/folder_containing_files`|
|`/data/my_output_file.out`| Output file which will be saved in `~/folder_containing_files/my_output_file.out`|

### RSTT Version
ISC Locator is compiled with rstt support and can be defined by user to use that mode.
Using ebvironmental variable `RSTT_SUPPORT` on `docker run` iscloc will use that mode.

Example:  

    docker run \
      --rm \
      -v $PWD:/data \ \
      -e RSTT_SUPPORT=true \
      iscdev/iscloc /data/isf_test_input.dat /data/my_output_file.out

### Example
In this example we will run both normal and rstt version of isclocator.  
Test file is located in my home directory `/home/przemek/host_os_directory/isf_test_input1.dat`  

##### Normal iscloc

    docker run \
      --rm \
      -v $PWD:/data \
      iscdev/iscloc /data/isf_test_input1.dat /data/my_output.out

Video:  
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/yoEHXE5xXXc/0.jpg)](https://www.youtube.com/watch?v=yoEHXE5xXXc)

##### RSTT iscloc

    docker run \
      --rm \
      -v $PWD:/data \
      -e RSTT_SUPPORT=true \
      iscdev/iscloc /data/isf_test_input1.dat /data/my_output_rstt.out

Video:  
[![IMAGE ALT TEXT HERE](https://img.youtube.com/vi/srnfHw6A8Zk/0.jpg)](https://www.youtube.com/watch?v=srnfHw6A8Zk)

## Author

Author: [Przemyslaw Ozgo](https://github.com/pozgo) (<linux@ozgo.info>)
