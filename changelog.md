# Changelog

## v0.1.0

- Initiating the project.

## v0.2.3

- Update CIs
- Columns for the reference table `datasets.csv` is determined
- Not worked yet due to locating the data in `SWCDatasets`

### New features:
Transcode and save data
- `load_original` data and `return_compressed` data
- `SourceData` for the information of the source file
- `show` and `DataFrame` methods for `SD::SourceData`
- `compress_save`: Compress file, move it to `dir_raw`, and save.

Decompress and load data
- `datasets()` list the available packages and datasets
- use `dataset` to get the data as a DataFrame; `unzip_file` save the data in csv.

Update/merge data
- The process of update existing dataset is not determined
- There are some code in `src/mergesave.jl`, but not `include`d

### Tests
All functions mentioned above are tested.

## v0.2.4
- The problem of locating data in `SWCDatasets` in an alternative working directory fixed
- rename keyword argument `force` to `update_table` in `datasets`
- Remove some tests since now abs. paths are applied. See also README.md
- New method `SourceData(row::DataFrameRow)`; new `const DATASET_ABS_DIR`

## v0.2.7
- Add `Huanshan2018-2019`
- Add `Jiufenershan2018-2019`
- Add `Dacuken2014-2015`
- Add test for the latest dataset with `TWAISWCF`'s default preprocessing.