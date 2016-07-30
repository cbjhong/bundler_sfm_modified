#!/bin/bash
#
# ToSiftList.sh
# Create a script for extracting sift features from a list of images

# Set this variable to your base install path (e.g., /home/foo/bundler)
# BIN_PATH=$(dirname $(which $0));
BIN_PATH=/Users/yingliang/Projects/MVS/bundler_sfm_modified/bin;

if [ $# -ne 1 ]
then
  echo "Usage: ToSiftList.sh <list_file>"
  exit;
fi

OS=`uname -o`

if [ $OS == "Cygwin" ]
then
    SIFT=$BIN_PATH/siftWin32.exe
else
    SIFT=$BIN_PATH/sift
fi

if ! [ -e $SIFT ] ; then
    echo "[ToSiftList] Error: SIFT not found.  Please install SIFT to $BIN_PATH" > /dev/stderr
    exit 1
fi

IMAGE_LIST=$1

# awk "{pgm = \$1; key = \$1; sub(\"jpg\$\", \"pgm\", pgm); sub(\"jpg\$\", \"key\", key); print \"mogrify -format pgm \" \$1 \"; $SIFT < \" pgm \" > \" key \"; gzip -f \" key \"; rm \" pgm}" $IMAGE_LIST 
# Changed the line above to make the shell scripts use vlfeat sift and convert to Lowe's format
awk "{pgm = \$1; key = \$1; sub(\"jpg\$\", \"pgm\", pgm); sub(\"jpg\$\", \"key\", key); print \"mogrify -format pgm \" \$1 \"; $SIFT \" pgm \" -o \" key \"; rm \" pgm; print \"/Users/yingliang/Projects/MVS/bundler_sfm_modified/ToLoweSift.sh \" key}" $IMAGE_LIST
