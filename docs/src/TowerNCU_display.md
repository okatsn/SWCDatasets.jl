# Overview
## TowerNCU

```@example abc
using SWCDatasets, DataFrames
df = SWCDatasets.dataset("NCUWiseLab", "TowerNCU_combined")
describe(df)
```

```@example abc
using CairoMakie, SWCForecastBase, Dates
ismln(x) = islnan(x) || ismissing(x)
DR = DataRatio(df, Month(1), islnan)
f = Figure(;resolution=(1000,850))
ax = Axis(f[1, 1]; xticklabelrotation = 0.3π)
hmap = heatmap!(ax, DR; colormap = "diverging_rainbow_bgymr_45_85_c67_n256")
Colorbar(f[1, 2], hmap, label = "missing data rate")
f
```
