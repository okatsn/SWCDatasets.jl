module SWCDatasets

using DrWatson
include("projectdir.jl")

using SmallDatasetMaker # (required) See also `SmallDatasetMaker.datasets`.
function SWCDatasets.dataset(package_name, dataset_name)
    SmallDatasetMaker.dataset(SWCDatasets,package_name, dataset_name)
end # (optional)

SWCDatasets.datasets() = SmallDatasetMaker.datasets(FSDatasets) # (optional)
# so that you can use `FSDatasets.datasets()` to list all availabe `package/dataest`s in `FSDatasets`

end
