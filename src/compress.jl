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
    dstfile::String
    rows::Int
    columns::Int
    description::String
    timestamps::TimeType
end

function SourceData(srcfile, package_name, dataset_name, title, dstfile, rows, columns, description)
    SourceData(srcfile, package_name, dataset_name, title, dstfile, rows, columns, description, today())
end

function SourceData(srcfile, package_name, dataset_name, title, dstfile, rows, columns)
    SourceData(srcfile, package_name, dataset_name, title, dstfile, rows, columns, "")
end

function SourceData(srcfile, package_name, dataset_name, title, dstfile)
    df = CSV.read(srcfile, DataFrame)
    (rows, columns) = (nrow(df), ncol(df))
    SourceData(srcfile, package_name, dataset_name, title, dstfile, rows, columns)
end

function SourceData(srcfile, package_name, dataset_name, dstfile)
    title = "Data [$dataset_name] of [$package_name]"
    SourceData(srcfile, package_name, dataset_name, title, dstfile)
end


function SourceData(srcfile, package_name, dataset_name)
    dstfile = dir_data(package_name, dataset_name*".gz")
    SourceData(srcfile, package_name, dataset_name, dstfile)
end

function SourceData(srcfile)
    (package_name, dataset_name) = get_package_dataset_name(srcpath)
    SourceData(srcfile, package_name, dataset_name)
end



"""
`compress_save(srcpath, target_path::AbstractString)` use `return_compressed` to generate compressed data and save it to `target_path`.
"""
function compress_save(srcpath, target_path::AbstractString)
    compressed = return_compressed(srcpath)
    mkpath(dirname(target_path))
    open(target_path, "w") do io
        write(io, compressed)
    end
end



"""
For `compress_save(srcpath)` where `srcpath` is the path to the source file, the `package_name` will be the folder that the file resides, the `dataset_name` will be the name of the data without extension, and the path to the compressed file will be `dir_data(package_name, dataset_name, targetfile)` where target file
"""
function compress_save(srcpath)
    compress_save(SourceData(srcpath))
    @info "File saved to $target_path"
end


function compress_save(SD::SourceData)
    compress_save(SD.srcfile, SD.dstfile)
end


# TODO: rename functions
