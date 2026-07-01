#!/usr/bin/env bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
DEMO_REF="${DEMO_REF:-main}"
REPO="/home/lsst/mnt/demo_data/pipelines_check-${DEMO_REF}/DATA_REPO"
python /home/lsst/mnt/python/your_survey/inspect_repo.py --repo "$REPO" --dataset-type "..." --collection demo_collection --limit 50
