@testset "Compress and Decompress" begin
    using CodecZlib,CSV,DataFrames,RDatasets
    iris = RDatasets.dataset("datasets", "iris")

    srcfile = SWCDatasets.dir_to_be_converted("iris.csv")
    CSV.write(srcfile, iris)

    original = SWCDatasets.load_original(srcfile)

    # Test different methods for `return_compressed`
    compressed1 = SWCDatasets.return_compressed(original)
    compressed2 = SWCDatasets.return_compressed(srcfile)

    @test isequal(compressed1, compressed2)

    decompressed1 = transcode(CodecZlib.GzipDecompressor, compressed1)
    @test isequal(decompressed1, original)

    # Test compress_save
    target_path = SWCDatasets.compress_save(srcfile)

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

    # TODO: test if they are removed
end
# TODO: test _save_file error
# TODO: test _unzip
