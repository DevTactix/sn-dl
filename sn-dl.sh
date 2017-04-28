#!/bin/bash

# Initialization.
declare -i DISK_SPACE
declare -i DISK_SPACE_MIN="200000"
declare -i EPISODE
EPISODE_NAME=

# Output title.
echo "Security Now Downloader v0.8"

# Check disk space.
DISK_SPACE=$(df -T /data/disk1/ | grep disk1 | awk '{print $5}')
if [ "$DISK_SPACE" -le "$DISK_SPACE_MIN" ]; then
echo "Minimum amount of diskspace not available! Exiting."
exit 1
fi

# Check argument and set episode.
if test "$1"; then
EPISODE="$1"
echo "Episode input: ${EPISODE}"
else
EPISODE=$(ls -1 *.mp4 | tail -n 1 | grep -io "^sn0..." | grep -o "...$")
EPISODE+=1
echo "Episode input missing, guesstimating: ${EPISODE}"
fi

# Set episode filename and download.
#EPISODE_NAME="http://dts.podtrac.com/redirect.mp4/twit.mediafly.com/video/sn/sn0${EPISODE}/sn0${EPISODE}_h264b_864x480_500.mp4"
EPISODE_NAME="http://twit.cachefly.net/video/sn/sn0${EPISODE}/sn0${EPISODE}_h264b_864x480_500.mp4"
echo "Downloading episode ${EPISODE}..."

wget "$EPISODE_NAME"
echo "...done."

exit 0
