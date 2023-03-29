@testset "datasets.jl" begin
    using DataFrames
    df = SWCDatasets.datasets()
    @test isa(df, DataFrame)
    @test isa(SWCDatasets.__datasets, DataFrame)
end
