using Test
using TrussC; tc = TrussC

@testset "Fbo Test" begin

    fbo = Fbo()
    @test isAllocated(fbo) == false

    allocate(fbo, 10, 10)
    @test isAllocated(fbo) == true
    @test getWidth(fbo) == 10
    @test getHeight(fbo) == 10

end