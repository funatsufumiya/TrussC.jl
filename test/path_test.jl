using Test
using TrussC; tc = TrussC

@testset "Path Test" begin
    p = Path("dummy")
    @test tc.string(p) == "dummy"
    @test exists(p) == false
    @test is_regular_file(p) == false

    p2 = p / "child"
    @test tc.string(p2) == "dummy/child" || tc.string(p2) == "dummy\\child"

    p3 = Path("a") / "b" / "c"
    @test tc.string(p3) == "a/b/c" || tc.string(p3) == "a\\b\\c"

    p4 = Path(joinpath(@__DIR__, "10x10.png"))
    @test exists(p4) == true
    @test is_regular_file(p4) == true
end