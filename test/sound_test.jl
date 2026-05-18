using Test
using TrussC;

@testset "Sound Test" begin

    p = Sound()

    @test isLoaded(p) == false

end