

# These functions are applied only for package internal use.

"""
Path to the directory for the to-be-compressed data; only for package internal use.
"""
dir_to_be_converted(args...) = joinpath("data", "to_be_converted", args...) # TODO: delete me and all related code


"""
Path to the directory for the backup of the raw data; only for package internal use.
"""
dir_raw(args...) = joinpath("data", "raw", args...)

"""
Path to the directory for the data.
"""
dir_data(args...) = joinpath("data", args...)




"""
`pathconvert(f::Function, package_name, dataset_name)` returns `target_path` **without** extension (e.g., ".csv" or ".csv.gz").

`f` is a `f(args...) = joinpath(..., args)` function.

"""
function pathconvert(f::Function, package_name, dataset_name)
    target_path = f(package_name, dataset_name)
end # TODO: consider delete me and related lines

"""
`pathconvert(package_name, dataset_name)` is equivalent to `pathconvert(dir_data, package_name, dataset_name)`
"""
function pathconvert(package_name, dataset_name)
    pathconvert(dir_data, package_name, dataset_name)
end

"""
TODO: Please test me.
"""
function get_package_dataset_name(srcpath)
    package_name = srcpath |> dirname |> basename
    dataset_name = srcpath |> basename |> str -> split(str, "."; limit=2) |> first
    return (package_name, dataset_name)
end
