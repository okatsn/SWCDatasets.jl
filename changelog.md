# Changelog

## v0.1.0

- Initiating the project.

## v0.2.0

- Update CIs
- Columns for the reference table `datasets.csv` is determined

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