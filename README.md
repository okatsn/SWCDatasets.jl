# SWCDatasets

[![Stable](https://img.shields.io/badge/docs-stable-blue.svg)](https://okatsn.github.io/SWCDatasets.jl/stable/)
[![Dev](https://img.shields.io/badge/docs-dev-blue.svg)](https://okatsn.github.io/SWCDatasets.jl/dev/)
[![Build Status](https://github.com/okatsn/SWCDatasets.jl/actions/workflows/CI.yml/badge.svg?branch=main)](https://github.com/okatsn/SWCDatasets.jl/actions/workflows/CI.yml?query=branch%3Amain)
[![Coverage](https://codecov.io/gh/okatsn/SWCDatasets.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/okatsn/SWCDatasets.jl)


## Introduction

This is a julia package created using `okatsn`'s preference, and this package is expected to be registered to [okatsn/OkRegistry](https://github.com/okatsn/OkRegistry) for CIs to work properly.

- `/data/raw/` is git-ignored.

## Workflow
### Transcode and save data
- `load_original` data and `return_compressed` data
- `SourceData` for the information of the source file
- `show` and `DataFrame` methods for `SD::SourceData`
- `compress_save`: Compress file, move it to `dir_raw`, and save.

### Decompress and load data
- `datasets()` list the available packages and datasets
- use `dataset` to get the data as a DataFrame; `unzip_file` save the data in csv.

### Update/merge data
- not determined yet
- The process of update existing dataset is not determined
- There are some code in `src/mergesave.jl`, but not `include`d

This package is create on 2023-02-06.
