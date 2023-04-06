@testset "TWAISWCF_test.jl" begin
    using TWAISWCF, DataFrames
    # lastrow = eachrow(SWCDatasets.__datasets) |> last

    for lastrow in eachrow(SWCDatasets.__datasets)
        pkgnm = lastrow.PackageName
        datnm = lastrow.Dataset
        df = SWCDatasets.dataset(pkgnm, datnm)
        PT = PrepareTableDefault(df) # data preprocessing
        @info "$pkgnm/$datnm goes through `PrepareTableDefault` without error."
    end

    @test true
end
