#!/usr/bin/env bash
# Source this file from project scripts to activate the LSST stack safely.
# Some LSST/conda activation hooks are not safe under `set -u` because they
# reference variables such as ADDR2LINE before defining them. Keep nounset off
# while activating the stack, then callers may re-enable it.

set +u
source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
export PYTHONPATH=/home/lsst/mnt/python:${PYTHONPATH:-}
set -u
