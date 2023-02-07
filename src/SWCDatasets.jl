module SWCDatasets

# Write your package code here.

global __datasets = nothing



using CSV,DataFrames
include("datasets.jl")

include("datadir.jl")

using CodecZlib,Dates
include("compress.jl")

include("decompress.jl")
end
