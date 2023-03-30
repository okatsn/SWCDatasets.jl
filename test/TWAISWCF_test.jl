@testset "TWAISWCF_test.jl" begin
    using TWAISWCF, DataFrames
    lastrow = eachrow(SWCDatasets.datasets()) |> last
    df = SWCDatasets.dataset(lastrow.PackageName, lastrow.Dataset)
    PT = PrepareTableDefault(df) # data preprocessing
    @test true
end
