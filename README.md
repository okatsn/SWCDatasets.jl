# SWCDatasets

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://okatsn.github.io/SWCDatasets.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://okatsn.github.io/SWCDatasets.jl/dev/)
[![Build Status](https://github.com/okatsn/SWCDatasets.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/okatsn/SWCDatasets.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/okatsn/SWCDatasets.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/okatsn/SWCDatasets.jl)


## Introduction

This is a julia package created using `okatsn`'s preference, and this package is expected to be registered to [okatsn/OkRegistry](https://github.com/okatsn/OkRegistry) for CIs to work properly.

- `/data/raw/` is git-ignored.

## Add/Update data
- Put csv files under `dir_to_be_converted()`
- [ ] Run `auto_update("path", "to", "subdir")`; this will 
    - compress all the files under `dir_to_be_converted()`
    - move the raw csv files to `dir_raw("path", "to", "subdir")`



## More reading
Pkg's Artifact that manage an external dataset as a package
- https://pkgdocs.julialang.org/v1/artifacts/

This package is create on 2023-02-06.
