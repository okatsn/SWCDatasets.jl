module SWCDatasets

using SmallDatasetMaker # (required) See also `SmallDatasetMaker.datasets`.
function SWCDatasets.dataset(package_name, dataset_name)
    SmallDatasetMaker.dataset(SWCDatasets,package_name, dataset_name)
end # (optional)

SWCDatasets.datasets() = SmallDatasetMaker.datasets(SWCDatasets) # (optional)
# so that you can use `SWCDatasets.datasets()` to list all availabe `package/dataest`s in `SWCDatasets`

end
