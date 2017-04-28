#!/bin/bash

# Initialization.
declare -i DISK_SPACE
declare -i DISK_SPACE_MIN="5000000"
declare -i EPISODE
NETCAST_URL=
NETCAST_LQ_URL=
NETCAST_TRANSCRIPT_URL=

# Output title.
echo "Security Now Downloader v0.7 (GRC)"

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
    #EPISODE=$(ls -1 ./Audio/*.mp3 | tail -n 1 | grep -io "^sn-..." | grep -o "...$")
    EPISODE=$(ls -1 ./Audio/*.mp3 | tail -n 1 | grep -io "[0-9][0-9][0-9]")
    EPISODE+=1
    echo "Episode input missing, guesstimating: ${EPISODE}"
fi

# Check length.
case "${#EPISODE}" in
    1) EPISODE="00${EPISODE}" ;;
    2) EPISODE="0${EPISODE}" ;;
esac

# Set episode filename and download.
#EPISODE_NAME="http://dts.podtrac.com/redirect.mp4/twit.mediafly.com/video/sn/sn0${EPISODE}/sn0${EPISODE}_h264b_864x480_500.mp4"
NETCAST_URL="http://media.grc.com/sn/sn-${EPISODE}.mp3"
NETCAST_LQ_URL="http://media.grc.com/sn/sn-${EPISODE}-lq.mp3"
NETCAST_TRANSCRIPT_URL="http://www.grc.com/sn/sn-${EPISODE}.pdf"
echo "Downloading episode ${EPISODE}..."
#wget "$EPISODE_NAME"
echo "...audio ${NETCAST_URL}"
wget -P ./Audio/ "$NETCAST_URL"
echo "...audio (LQ) ${NETCAST_LQ_URL}"
wget -P ./Audio/ "$NETCAST_LQ_URL"
echo "...transcript ${NETCAST_TRANSCRIPT_URL}"
wget -P ./Transcripts/ "$NETCAST_TRANSCRIPT_URL"
echo "...done."

exit 0
