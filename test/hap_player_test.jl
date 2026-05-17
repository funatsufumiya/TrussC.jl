using Test
using TrussC;
hap = TrussC # WORKAROUND

@testset "HapPlayer Test" begin

    p = HapPlayer()

    @test isPlaying(p) == false

end