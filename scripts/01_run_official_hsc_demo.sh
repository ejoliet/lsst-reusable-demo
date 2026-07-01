#!/usr/bin/env bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
DEMO_REF="${DEMO_REF:-main}"
DEMO_DIR="pipelines_check-${DEMO_REF}"
mkdir -p /home/lsst/mnt/demo_data
cd /home/lsst/mnt/demo_data
if [ ! -d "$DEMO_DIR" ]; then
  curl -L "https://github.com/lsst/pipelines_check/archive/${DEMO_REF}.tar.gz" | tar xvzf -
fi
cd "$DEMO_DIR"
setup -r .
./bin/run_demo.sh
