using Test
using TrussC; tc = TrussC

@testset "Color Test" begin

    red = Color_red()
    @test r(red) == 1.0f0
    @test g(red) == 0.0f0
    @test b(red) == 0.0f0
    @test a(red) == 1.0f0

    blue = Color_blue()
    @test r(blue) == 0.0f0
    @test g(blue) == 0.0f0
    @test b(blue) == 1.0f0
    @test a(blue) == 1.0f0

    c = Color(1.0f0, 2.0f0, 3.0f0, 0.0f0)
    @test r(c) == 1.0f0
    @test g(c) == 2.0f0
    @test b(c) == 3.0f0
    @test a(c) == 0.0f0

end