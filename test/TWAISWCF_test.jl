@testset "TWAISWCF_test.jl" begin
    using TWAISWCF, SWCDatasets
    lastrow = eachrow(SWCDatasets.__datasets) |> last
    # CHECKPOINT: test if lastrow can be loaded and PT
    # CHECKPOINT: move raw data to test and test if last dataset is identical than the raw one

end
