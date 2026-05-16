using Test
using TrussC; tc = TrussC

@testset "Image Test" begin

    img = Image()
    @test isAllocated(img) == false

    load(img, joinpath(@__DIR__, "10x10.png"))
    @test isAllocated(img) == true
    @test getWidth(img) == 10
    @test getHeight(img) == 10

end