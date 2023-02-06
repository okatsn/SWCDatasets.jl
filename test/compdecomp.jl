@testset "Compress and Decompress" begin
    using CodecZlib,CSV,DataFrames
    srcfile = SWCDatasets.dir_to_be_converted("CombinedARI.csv")
    original = SWCDatasets.load_original(srcfile)

    # Test different methods for `return_compressed`
    compressed1 = SWCDatasets.return_compressed(original)
    compressed2 = SWCDatasets.return_compressed(srcfile)

    @test isequal(compressed1, compressed2)

    decompressed1 = transcode(CodecZlib.GzipDecompressor, compressed1)
    @test isequal(decompressed1, original)

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
end


# TODO: Test pathconvert
