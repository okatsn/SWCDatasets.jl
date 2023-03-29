@testset "TWAISWCF_test.jl" begin
    using TWAISWCF
    lastrow = eachrow(SWCDatasets.__datasets) |> last
    df = SWCDatasets.dataset(lastrow.PackageName, lastrow.Dataset)
    PT = PrepareTableDefault(df) # data preprocessing
    traintest!(PT;
            train_before = DateTime(2022, 03, 21),
            test_after = DateTime(2022, 3, 22)) # train and test
    save(PT)

    # CHECKPOINT: test if lastrow can be loaded and PT
    # CHECKPOINT: move raw data to test and test if last dataset is identical than the raw one

end
