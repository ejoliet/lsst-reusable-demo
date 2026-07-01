def test_import_custom_task():
    from your_survey.tasks.exposure_stats import ExposureStatsTask
    assert ExposureStatsTask._DefaultName == "exposureStats"
