#!/usr/bin/env bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
DEMO_REF="${DEMO_REF:-main}"
REPO="/home/lsst/mnt/demo_data/pipelines_check-${DEMO_REF}/DATA_REPO"
python /home/lsst/mnt/python/your_survey/inspect_repo.py --repo "$REPO" --dataset-type simpleExposureStats --collection your_survey/stats --limit 20
python - <<'PY'
import os
from lsst.daf.butler import Butler
repo = f"/home/lsst/mnt/demo_data/pipelines_check-{os.environ.get('DEMO_REF', 'main')}/DATA_REPO"
butler = Butler(repo, collections='your_survey/stats')
for ref in butler.registry.queryDatasets('simpleExposureStats', collections='your_survey/stats'):
    print('\nResult', dict(ref.dataId))
    print(butler.get(ref))
PY
