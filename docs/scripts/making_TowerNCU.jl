# # Making of the dataset `TowerNCU_combined`
using DataFrames
using CSV
using Revise, SmallDatasetMaker, SWCDatasets, OkFiles

# ## Load the tables
fpaths = filelistall(r"TowerNCU_Li", SWCDatasets.dir_raw())
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
using CairoMakie, SWCForecastBase, Dates
ismln(x) = islnan(x) || ismissing(x)
DR = DataRatio(df_all, Month(1), islnan)
f = Figure(;resolution=(1000,850))
ax = Axis(f[1, 1]; xticklabelrotation = 0.3π)
hmap = heatmap!(ax, DR; colormap = "diverging_rainbow_bgymr_45_85_c67_n256")
Colorbar(f[1, 2], hmap, label = "missing data rate")
f

# ## Save the dataset
# ```
# dir_temp = SWCDatasets.dir_raw("NCUWiseLab", "TowerNCU_combined.csv")
# CSV.write(dir_temp, df_all)
# SD = SourceData(dir_temp)
# compress_save!(SWCDatasets, SD)
# ```

# ## (Literate)
using Literate #hide
scriptfile = "making_TowerNCU.jl" #hide
outputfoldername = "TowerNCU" #hide
# Literate.markdown(SWCDatasets.dir_docs("scripts", scriptfile), SWCDatasets.dir_docs("src", outputfoldername); config = Dict("execute" => true), documenter=false)
