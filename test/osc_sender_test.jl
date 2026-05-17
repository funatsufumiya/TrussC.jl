using Test
using TrussC;
osc = TrussC # WORKAROUND

@testset "Osc Sender Test" begin

    s = OscSender()

    @test isConnected(s) == false
    @test length(getConnectedAddresses(s)) == 0

end