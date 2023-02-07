"""
`load_original(path::AbstractString)` opens `path` and return the read data.
"""
function load_original(path::AbstractString)
    original = open(path, "r") do io
        read(io)
    end
    return original
end

"""
`return_compressed(path::AbstractString)` returned compressed data.

# Example
```julia
compressed = return_compressed("data/data.csv")
```
"""
function return_compressed(path::AbstractString)
    open(path, "r") do io
        data = read(io)
        transcode(GzipCompressor, data)
    end
end

"""
`return_compressed(data::Vector{UInt8})` returned compressed data.

# Example
```julia
data = load_original("data/data.csv")
compressed = return_compressed(data)
```
"""
function return_compressed(data::Vector{UInt8})
    transcode(GzipCompressor, data)
end


struct SourceData
    srcfile::String
    package_name::String
    dataset_name::String
    title::String
    zipfile::String
    rows::Int
    columns::Int
    description::String
    timestamps::TimeType
end

function SourceData(srcfile, package_name, dataset_name, title, zipfile, rows, columns, description)
    SourceData(srcfile, package_name, dataset_name, title, zipfile, rows, columns, description, today())
end

function SourceData(srcfile, package_name, dataset_name, title, zipfile, rows, columns)
    SourceData(srcfile, package_name, dataset_name, title, zipfile, rows, columns, "")
end

function SourceData(srcfile, package_name, dataset_name, title, zipfile)
    df = CSV.read(srcfile, DataFrame)
    (rows, columns) = (nrow(df), ncol(df))
    SourceData(srcfile, package_name, dataset_name, title, zipfile, rows, columns)
end

function SourceData(srcfile, package_name, dataset_name, zipfile)
    title = "Data [$dataset_name] of [$package_name]"
    SourceData(srcfile, package_name, dataset_name, title, zipfile)
end


function SourceData(srcfile, package_name, dataset_name)
    zipfile = dir_data(package_name, dataset_name*".gz")
    SourceData(srcfile, package_name, dataset_name, zipfile)
end

function SourceData(srcfile)
    (package_name, dataset_name) = get_package_dataset_name(srcpath)
    SourceData(srcfile, package_name, dataset_name)
end

function SWCDatasets.DataFrame(SD::SourceData)
    return DataFrame(:PackageName  => SD.package_name,
    :Dataset  => SD.dataset_name,
    :Title  => SD.title,
    :Rows  => SD.rows,
    :Columns  => SD.columns,
    :Description  => SD.description,
    :TimeStamp  => SD.timestamps,
    :RawData  => SD.srcfile,
    :ZippedData  => SD.zipfile)
end

"""
`compress_save(srcpath, target_path::AbstractString)` use `return_compressed` to generate compressed data and save it to `target_path`.
"""
function compress_save(srcpath, target_path::AbstractString)

end



"""
For `compress_save(srcpath)` where `srcpath` is the path to the source file, the `package_name` will be the folder that the file resides, the `dataset_name` will be the name of the data without extension, and the path to the compressed file will be `dir_data(package_name, dataset_name, targetfile)` where target file
"""
function compress_save(srcpath)
    compress_save(SourceData(srcpath))
    @info "File saved to $target_path"
end


function compress_save(SD::SourceData)

    compressed = return_compressed(SD.srcfile)
    target_path = SD.zipfile
    mkpath(dirname(target_path))
    open(target_path, "w") do io
        write(io, compressed)
        @info "Zipped file saved at $target_path"
    end
    CSV.write(dataset_table, SWCDatasets.DataFrame(SD); append=true)
    @info "$(basename(dataset_table)) updated successfully."

end


# TODO: rename functions
