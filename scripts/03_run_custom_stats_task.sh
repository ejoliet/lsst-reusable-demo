#!/usr/bin/env bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
DEMO_REF="${DEMO_REF:-main}"
REPO="/home/lsst/mnt/demo_data/pipelines_check-${DEMO_REF}/DATA_REPO"
pipetask run -b "$REPO" -i demo_collection -o your_survey/stats -p /home/lsst/mnt/pipelines/exposure_stats.yaml --register-dataset-types
