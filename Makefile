# The Rubin docs currently show lsstsqre/centos:7-stack-lsst_distrib-v29_2_1,
# but Docker Hub may not have that manifest. Keep IMAGE configurable and verify first.
IMAGE ?= lsstsqre/centos:7-stack-lsst_distrib-w_latest
MOUNT ?= /home/lsst/mnt
DEMO_REF ?= main
DOCKER_RUN = docker run --rm -it -e DEMO_REF=$(DEMO_REF) -v "$$(pwd)":$(MOUNT) $(IMAGE)

image-check:
	bash scripts/00_find_lsst_image.sh $(IMAGE)

shell:
	$(DOCKER_RUN) bash

env-check:
	$(DOCKER_RUN) bash $(MOUNT)/scripts/00_env_check.sh

demo:
	$(DOCKER_RUN) bash $(MOUNT)/scripts/01_run_official_hsc_demo.sh

inspect:
	$(DOCKER_RUN) bash $(MOUNT)/scripts/02_inspect_butler.sh

stats:
	$(DOCKER_RUN) bash $(MOUNT)/scripts/03_run_custom_stats_task.sh

inspect-stats:
	$(DOCKER_RUN) bash $(MOUNT)/scripts/04_inspect_stats_output.sh

activation-debug:
	$(DOCKER_RUN) bash -lc 'set +u; source /opt/lsst/software/stack/loadLSST.bash; setup lsst_distrib; eups list lsst_distrib | grep setup || true'
