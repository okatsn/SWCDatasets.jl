@testset "Test all dataset for :year,:month,:day,:hour" begin
    using DataFrames


    for lastrow in eachrow(SWCDatasets.__datasets)
        pkgnm = lastrow.PackageName
        datnm = lastrow.Dataset
        df = SWCDatasets.dataset(pkgnm, datnm)

        d = pairs(eachcol(df))
        @test all(haskey.([d], (:year,:month,:day,:hour)))
    end
end
