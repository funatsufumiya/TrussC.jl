using Test
using TrussC;
osc = TrussC # WORKAROUND

@testset "Osc Message Test" begin

    m = OscMessage("/test")
    addFloat(m, 1.0f0)
    addInt(m, 2)
    addString(m, "hello")

    @test getAddress(m) == "/test"
    @test getTypeTags(m) == "fis"
    @test getArgAsFloat(m, 0) == 1.0f0
    @test getArgAsInt(m, 1) == 2
    @test getArgAsString(m, 2) == "hello"

end