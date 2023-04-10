dir_raw(args...) = SmallDatasetMaker.abspath(SWCDatasets, "data", "raw", args...) # just for the convenience in dataset making

dir_docs(args...) = joinpath(dirname(dirname(pathof(SWCDatasets))), "docs", args...)
