

# These functions are applied only for package internal use.

"""
Path to the directory for the to-be-compressed data; only for package internal use.
"""
dir_to_be_converted(args...) = joinpath("data", "dir_to_be_converted", args...)


"""
Path to the directory for the raw data; only for package internal use.
"""
dir_raw(args...) = joinpath("data", "raw", args...)



"""
Path to the directory for the raw data; only for package internal use.
"""
dir_done(args...) = joinpath("data", "done", args...)
