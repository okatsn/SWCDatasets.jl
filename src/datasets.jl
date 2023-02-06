"""
`datasets()` returns the table of this dataset, and define the global variable `SWCDatasets.__datasets` as this table.
"""
function datasets()
    if SWCDatasets.__datasets === nothing
        path = joinpath(dirname(@__FILE__), "..", "data" , "doc", "datasets.csv")
        global __datasets = DataFrame(CSV.File(path))
    end
    return SWCDatasets.__datasets::DataFrame
end
