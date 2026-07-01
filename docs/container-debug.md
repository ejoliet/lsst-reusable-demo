# Container activation debug notes

## Symptom

```text
/opt/lsst/software/stack/conda/envs/lsst-scipipe-10.0.0/etc/conda/activate.d/activate-binutils_linux-aarch64.sh: line 68: ADDR2LINE: unbound variable
```

## Cause

The project scripts used:

```bash
set -euo pipefail
```

before activating the LSST stack. `set -u` (`nounset`) makes Bash fail when a sourced script references an unset variable. The LSST Docker image activates a conda environment, and at least one activation hook references `ADDR2LINE` before that variable exists. That hook is not safe under `nounset`.

The `linux-aarch64` path indicates Docker selected an ARM64 image, which is expected on Apple Silicon Macs. The architecture is not necessarily the bug; the activation script plus `set -u` is the immediate failure.

## Fix

Activate LSST with `nounset` disabled:

```bash
set -eo pipefail
source /home/lsst/mnt/scripts/lsst_env.sh
```

`lsst_env.sh` does:

```bash
set +u
source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
export PYTHONPATH=/home/lsst/mnt/python:${PYTHONPATH:-}
set -u
```

## If it still fails

Run an interactive container:

```bash
make shell
```

Then inside the container:

```bash
set +u
source /opt/lsst/software/stack/loadLSST.bash
setup lsst_distrib
eups list lsst_distrib | grep setup || true
```

If this succeeds, the image is usable and the failure is in project shell strictness.
If this fails, the image itself is broken for your platform/tag; try another `lsstsqre/centos` tag or force amd64:

```bash
make PLATFORM=linux/amd64 image-check
make PLATFORM=linux/amd64 demo
```
