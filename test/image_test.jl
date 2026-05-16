using Test
using TrussC; tc = TrussC

@testset "Image Test" begin

    function color_eq(a, b, d=0.1)
        flag = (abs(tc.r(a) - tc.r(b)) < d) && (abs(tc.g(a) - tc.g(b)) < d) && (abs(tc.b(a) - tc.b(b)) < d) && (abs(tc.a(a) - tc.a(b)) < d)

        if !flag
            println(a, " !=", b)
        end

        return flag
    end

    img = Image()
    @test isAllocated(img) == false

    load(img, joinpath(@__DIR__, "10x10.png"))
    @test isAllocated(img) == true
    @test getWidth(img) == 10
    @test getHeight(img) == 10

    c1 = getColor(img, 0, 0)
    c2 = getColor(img, 0, 9)
    c3 = getColor(img, 9, 0)
    c4 = getColor(img, 9, 9)
    @test color_eq(c1, Color_red())
    @test color_eq(c2, Color_green())
    @test color_eq(c3, Color_blue())
    @test color_eq(c4, Color_yellow())


end