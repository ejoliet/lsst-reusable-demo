# LSST/Rubin Reuse Showcase - fixed Docker tag handling

This scaffold demonstrates a small Rubin/LSST reuse flow:

1. verify a usable LSST Docker image tag,
2. run the official HSC `pipelines_check` demo,
3. inspect the generated Butler repo,
4. run a custom `PipelineTask` against the produced `calexp`,
5. read the custom output through Butler.

## Why the image is configurable

The Rubin docs show this example:

```bash
docker run -ti lsstsqre/centos:7-stack-lsst_distrib-v29_2_1
```

But Docker Hub may not currently expose that exact tag. This project therefore uses:

```bash
make image-check
make IMAGE=lsstsqre/centos:<known-good-tag> DEMO_REF=<matching-pipelines_check-ref> demo
```

For weekly/latest images, prefer:

```bash
make IMAGE=lsstsqre/centos:7-stack-lsst_distrib-w_latest DEMO_REF=main image-check
make IMAGE=lsstsqre/centos:7-stack-lsst_distrib-w_latest DEMO_REF=main demo
```

If `w_latest` is also unavailable, list tags:

```bash
curl -fsSL 'https://hub.docker.com/v2/repositories/lsstsqre/centos/tags?page_size=100' \
  | jq -r '.results[].name' \
  | grep 'stack-lsst_distrib'
```

## Commands

```bash
make image-check
make demo
make inspect
make stats
make inspect-stats
```

## Debug note: `ADDR2LINE: unbound variable`

If `make demo` fails during LSST activation with:

```text
activate-binutils_linux-aarch64.sh: line 68: ADDR2LINE: unbound variable
```

that is caused by Bash `set -u` running before the LSST conda activation hooks. The scripts now source `scripts/lsst_env.sh`, which disables `nounset` only during LSST activation and re-enables it afterwards.

Try:

```bash
make activation-debug
make demo
```

On Apple Silicon, Docker may select the ARM64 image. If activation still fails after this patch, try forcing amd64:

```bash
make PLATFORM=linux/amd64 activation-debug
make PLATFORM=linux/amd64 demo
```
