"""
`dataset(package_name::AbstractString, dataset_name::AbstractString)` returns a `DataFrame` object unzipped from `pathconvert(package_name, dataset_name)*".csv"*".gz"`.
This function mimics the `dataset` function in `RDatasets.jl`.

"""
function dataset(package_name::AbstractString, dataset_name::AbstractString)
    target_path = pathconvert(package_name, dataset_name)*".gz"
    if !isfile(target_path)
        error("Unable to locate dataset file $path")
    end

    df_decomp2 = open(target_path, "r") do io
        uncompressed = IOBuffer(read(GzipDecompressorStream(io)))
        DataFrame(CSV.File(uncompressed))
    end
    return df_decomp2
end

"""
The same as `dataset`, but also save the unzip file.
"""
function unzip_file(package_name::AbstractString, dataset_name::AbstractString)
    target_path = pathconvert(package_name, dataset_name)*".gz"
    if !isfile(target_path)
        error("Unable to locate dataset file $path")
    end
    file_decomp = pathconvert(dir_to_be_converted, package_name, dataset_name)*".csv"
    mkpath(dirname(file_decomp))

    open(file_decomp, "w") do io
        write(io, decompressed1)
    end

    @info "File unzipped to $(file_decomp)."
    df_decomp1 = CSV.read(file_decomp, DataFrame)
    return df_decomp1
end
