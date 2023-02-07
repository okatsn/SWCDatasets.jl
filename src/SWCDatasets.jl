module SWCDatasets

# Write your package code here.

global __datasets = nothing
const dataset_table = joinpath(dirname(@__FILE__), "..", "data" , "doc", "datasets.csv")


using CSV,DataFrames
include("datasets.jl")

include("datadir.jl")

using CodecZlib,Dates
import PrettyTables
include("compress.jl")



include("decompress.jl")
end
