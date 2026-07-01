#!/usr/bin/env bash
set -euo pipefail
IMAGE="${1:-lsstsqre/centos:7-stack-lsst_distrib-w_latest}"
echo "Checking Docker image manifest: $IMAGE"
if docker manifest inspect "$IMAGE" >/dev/null 2>&1; then
  echo "OK: Docker can resolve $IMAGE"
  exit 0
fi
cat >&2 <<MSG
ERROR: Docker cannot resolve $IMAGE

The documented tag may be stale or missing from Docker Hub.
Browse tags:
  https://hub.docker.com/r/lsstsqre/centos/tags

Or query tags:
  curl -fsSL 'https://hub.docker.com/v2/repositories/lsstsqre/centos/tags?page_size=100' \
    | jq -r '.results[].name' \
    | grep 'stack-lsst_distrib'

Then run:
  make IMAGE=lsstsqre/centos:<known-good-tag> DEMO_REF=main demo
MSG
exit 1
