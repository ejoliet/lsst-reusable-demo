from __future__ import annotations
import math
from typing import Any
import numpy as np
import lsst.pex.config as pexConfig
import lsst.pipe.base as pipeBase
from lsst.pipe.base import PipelineTask, PipelineTaskConfig, PipelineTaskConnections
from lsst.pipe.base.connectionTypes import Input, Output

class ExposureStatsConnections(PipelineTaskConnections, dimensions=("instrument", "visit", "detector")):
    calexp = Input(
        name="calexp",
        doc="Calibrated exposure from Rubin/LSST processing.",
        storageClass="ExposureF",
        dimensions=("instrument", "visit", "detector"),
    )
    summary = Output(
        name="simpleExposureStats",
        doc="Small QA summary for a calibrated exposure.",
        storageClass="StructuredDataDict",
        dimensions=("instrument", "visit", "detector"),
    )

class ExposureStatsConfig(PipelineTaskConfig, pipelineConnections=ExposureStatsConnections):
    thresholdSigma = pexConfig.Field(dtype=float, default=5.0, doc="Toy bright-pixel threshold in sigma.")

class ExposureStatsTask(PipelineTask):
    ConfigClass = ExposureStatsConfig
    _DefaultName = "exposureStats"
    def run(self, calexp: Any) -> pipeBase.Struct:
        image = calexp.image.array.astype("float64", copy=False)
        vals = image[np.isfinite(image)]
        if vals.size == 0:
            out = dict(n_pixels=int(image.size), n_finite=0, mean=math.nan, median=math.nan, std=math.nan, robust_sigma=math.nan, toy_bright_pixel_count=0)
            return pipeBase.Struct(summary=out)
        med = float(np.median(vals))
        mad = float(np.median(np.abs(vals - med)))
        robust = float(1.4826 * mad if mad > 0 else np.std(vals))
        threshold = med + float(self.config.thresholdSigma) * robust
        out = dict(
            n_pixels=int(image.size),
            n_finite=int(vals.size),
            mean=float(np.mean(vals)),
            median=med,
            std=float(np.std(vals)),
            robust_sigma=robust,
            toy_bright_pixel_count=int(np.count_nonzero(vals > threshold)),
            threshold_sigma=float(self.config.thresholdSigma),
        )
        return pipeBase.Struct(summary=out)
