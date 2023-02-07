using CodecZlib,CSV,DataFrames,RDatasets

dataset_table() = joinpath(dirname(@__FILE__), "..", "data" , "doc", "datasets_for_test.csv")

DataFrame(
    :PackageName => String[],
    :Dataset => String[],
    :Title => String[],
    :Rows => String[],
    :Columns => String[],
    :Description => String[],
    :TimeStamp => String[],
    :RawData => String[],
    :ZippedData => String[],
) |> df -> CSV.write(dataset_table(), df)

@testset "Source-Target paths" begin

    iris = RDatasets.dataset("datasets", "iris")

    srcdir = SWCDatasets.dir_data("temp")
    targetdir = SWCDatasets.dir_data()
    rawdir = SWCDatasets.dir_data("raw")

    mkpath.([srcdir, targetdir, rawdir])
    srcfile = joinpath(srcdir, "iris.csv")
    CSV.write(srcfile, iris)

    package_name = "MJ"
    dataset_name = "IRIS"
    SD = SWCDatasets.SourceData(srcfile, package_name, dataset_name)
    show(SD)

    SWCDatasets.compress_save(SD) # KEYNOTE: test the main method

    df_decomp2 = SWCDatasets.dataset(SD.zipfile)
    df_decomp1 = SWCDatasets.unzip_file(SD.zipfile)

    @test isequal(df_decomp1, df_decomp2)

    @test isfile(SWCDatasets.dir_data(package_name, dataset_name*".gz")) || "Target file not exists or named correctly"
    @test isfile(joinpath(targetdir, basename(srcfile))) || "Target file not exists or named correctly"
    @test !isfile(SD.srcfile) || "srcfile should be moved to dir_raw()"
    @test isfile(SWCDatasets.dir_raw(basename(SD.srcfile))) || "srcfile should be moved to dir_raw()"
    rm("data"; recursive = true)
end

@testset "Compress and Decompress" begin
    iris = RDatasets.dataset("datasets", "iris")

    srcdir = SWCDatasets.dir_data("RDatasets")
    mkpath(srcdir)
    srcfile = joinpath(srcdir, "iris.csv")
    CSV.write(srcfile, iris)

    original = SWCDatasets.load_original(srcfile)

    # Test different methods for `return_compressed`
    compressed1 = SWCDatasets.return_compressed(original)
    compressed2 = SWCDatasets.return_compressed(srcfile)

    @test isequal(compressed1, compressed2)

    decompressed1 = transcode(CodecZlib.GzipDecompressor, compressed1)
    @test isequal(decompressed1, original)

    # Test compress_save
    target_path = SWCDatasets.compress_save(srcfile) # KEYNOTE: test the alternative method

    df_decomp2 = SWCDatasets.dataset(target_path)
    df_decomp1 = SWCDatasets.unzip_file(target_path)
    df_decomp0 = CSV.read(srcfile, DataFrame)


    @test isequal(df_decomp1, df_decomp0)
    @test isequal(df_decomp2, df_decomp0)


    package_name1, dataset_name1 = SWCDatasets.get_package_dataset_name(srcfile)
    package_name2, dataset_name2 = SWCDatasets.get_package_dataset_name(target_path)
    @test isequal(package_name1,package_name2)
    @test isequal(dataset_name1,dataset_name2)

    @info "`srcfile`: $srcfile"
    @info "`target_path`: $target_path"
    @info "Test if the two files exists:"
    @test isfile(srcfile)
    @test isfile(target_path)

    rm("data"; recursive = true)
end
