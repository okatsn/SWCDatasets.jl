"""
`datasets()` returns the table of this dataset, and define the global variable `SWCDatasets.__datasets` as this table.
"""
function datasets()
    if SWCDatasets.__datasets === nothing
        global __datasets = DataFrame(CSV.File(dataset_table()))
    end
    return SWCDatasets.__datasets::DataFrame
end

# TODO: write test
"""
`target_row` returns the latest information in `datasets()`.
Given `package_name, dataset_name`, `target_row(package_name, dataset_name)`, `target_row` returns the last `row` that matches `row.PackageName == package_name && row.Dataset == dataset_name"`.

"""
function target_row(package_name, dataset_name)
    indextable = SWCDatasets.datasets()
    row = filter([:PackageName, :Dataset] => (p, d) -> p == package_name && d == dataset_name , indextable) |> eachrow |> last
end
