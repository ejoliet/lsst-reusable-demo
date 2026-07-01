# Docker tag fix

The previous scaffold used `lsstsqre/centos:7-stack-lsst_distrib-v29_2_1` because the Rubin docs show it as a quick-start example. If Docker reports `manifest unknown`, the docs are stale relative to Docker Hub availability.

Use `make image-check` before running the scaffold, and override `IMAGE` with a tag that exists.
