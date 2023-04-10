using DataFrames
using CSV
using Revise, SmallDatasetMaker, SWCDatasets, OkFiles

# ## Load the tables
fpaths = filelistall(r"TowerNCU", SWCDatasets.dir_raw())
dfs = CSV.read.(fpaths, DataFrame)
basename.(fpaths)

# ## Table differences ignoring `soil_water_`
dft = difftables(dfs...; ignoring = Cols(r"soil_water_"))


# ## Remove extra soil water contents
select!.(dfs, [Not(Cols(r"soil_water_content_\D+"))]) # Delete e.g., soil_water_content_#2...
select!.(dfs, [Not(Cols(r"soil_water_content_\d+\_"))]) # Delete e.g., soil_water_content_2...
dft = difftables(dfs...)

# ## Concatenate tables
df_all = DataFrame()
for df in dfs
    append!(df_all, df; cols = :union)
end

# ## Dataoverview
using CairoMakie, SWCForecastBase
