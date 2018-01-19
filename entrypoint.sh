#!/bin/bash

usage() {
    printf "Usage: %s [-h|--help] [-b <s3 bucket>|--bucket <s3 bucket>] macro\\n" "$0"
    exit 0
}

OPTIONS=b:h
LONGOPTIONS=bucket:help
PARSED=$(getopt --options=$OPTIONS --longoptions=$LONGOPTIONS --name "$0" -- "$@")
if [[ $? -ne 0 ]]; then
    exit 2
fi

eval set -- "$PARSED"

while true; do
    case "$1" in
        -b|--bucket)
            BUCKET="$2"
            shift 2
            ;;
        -h|--help)
            usage
            shift
            ;;
        --)
            shift
            break
            ;;
        *)
            echo "Unknown option"
            exit 3
            ;;
    esac
done

MACRO=${1:-macros/runexample.mac}

unset OSRELEASE
source $JLAB_ROOT/$JLAB_VERSION/ce/jlab.sh
cd $REMOLL && ./build/remoll $MACRO && \
if [[ $BUCKET ]]; then
    RANDOM=$(cat /dev/urandom | tr -cd 'a-f0-9' | head -c 16)
    TIMESTAMP=$(date +%Y%m%d_%H%M%S_${RANDOM})
    DEST=s3://$BUCKET/remollout/${TIMESTAMP}.root
    echo Copying remollout.root to ${DEST}
    aws s3 cp remollout.root s3://$BUCKET/remollout/${TIMESTAMP}.root
else
    echo No s3 bucket specified. Discarding output.
fi

