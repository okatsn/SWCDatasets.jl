
"""
The path to the index table for datasets in `SWCDatasets`.
"""
dataset_table() = joinpath(dirname(@__FILE__), "..", "data" , "doc", "datasets.csv")



"""
`datasets()` returns the table of this dataset, and define the global variable `SWCDatasets.__datasets` as this table.

Set `; force = true` to force update `SWCDatasets.__datasets` with the `dataset_table()`; this keyword argument is intended to make some tests can work since in test `dataset_table()` is mutating. # todo: find a better way to deal with it.
"""
function datasets(;force = false)
    if SWCDatasets.__datasets === nothing || force
        global __datasets = DataFrame(CSV.File(dataset_table()))
    end
    return SWCDatasets.__datasets::DataFrame
end

"""
`target_row` returns the latest information in `datasets()`.
Given `package_name, dataset_name`, `target_row(package_name, dataset_name)`, `target_row` returns the last `row` that matches `row.PackageName == package_name && row.Dataset == dataset_name"`.

"""
function target_row(package_name, dataset_name; kwargs...)
    indextable = SWCDatasets.datasets(; kwargs...)
    row = filter([:PackageName, :Dataset] => (p, d) -> p == package_name && d == dataset_name , indextable) |> eachrow |> last
end
