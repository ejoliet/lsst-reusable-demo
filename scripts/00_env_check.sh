#!/usr/bin/env bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
eups list lsst_distrib | grep setup || true
python - <<'PY'
from lsst.daf.butler import Butler
from lsst.pipe.base import PipelineTask
from your_survey.tasks.exposure_stats import ExposureStatsTask
print('Butler import OK')
print('PipelineTask import OK')
print('Custom task import OK:', ExposureStatsTask)
PY
