using Test
using TrussC;
osc = TrussC # WORKAROUND

@testset "Osc Bundle Test" begin

    m = OscMessage("/test")
    addFloat(m, 1.0f0)

    b0 = OscBundle()

    b = OscBundle()
    addMessage(b, m)
    addBundle(b, b0)

    @test getElementCount(b) == 2
    @test isMessage(b, 0) == true
    @test getAddress(getMessageAt(b, 0)) == getAddress(m)
    @test isBundle(b, 1) == true
    @test getElementCount(getBundleAt(b, 0)) == getElementCount(b0)

end