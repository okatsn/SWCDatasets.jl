
using SWCDatasets
using CairoMakie, SWCForecastBase, Dates
using Documenter

DocMeta.setdocmeta!(SWCDatasets, :DocTestSetup, :(using SWCDatasets); recursive=true)

makedocs(;
    modules=[SWCDatasets],
    authors="okatsn <okatsn@gmail.com> and contributors",
    repo="https://github.com/okatsn/SWCDatasets.jl/blob/{commit}{path}#{line}",
    sitename="SWCDatasets.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://okatsn.github.io/SWCDatasets.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Dataset" => [
            "TowerNCU" => "TowerNCU/making_TowerNCU.md"
        ]
    ],
)

deploydocs(;
    repo="github.com/okatsn/SWCDatasets.jl",
    devbranch="main",
)
