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
`compress_save(srcpath, pathconvert::Function)` where `pathconvert` is a function that converts `srcpath` to `target_path`. Noted that file extension ".gz" will be automatically added for `target_path`.
"""
function compress_save(srcpath, pathconvert::Function)
    package_name = srcpath |> dirname |> basename
    dataset_name = srcpath |> basename |> str -> split(str, "."; limit=2) |> first
    target_path =  pathconvert(package_name, dataset_name)*".gz"
    compress_save(srcpath, target_path)
end

# TODO: rename functions


# function pathconvert(srcpath)
#     filename = basename(srcpath)
#     srcdir = dirname(srcpath)
#     target_path = joinpath(srcdir)
# end


# function compress_save(srcpath)
#     compress_save(srcpath, pathconvert)
# end
