using Test
using TrussC;
osc = TrussC # WORKAROUND

@testset "Osc Receiver Test" begin

    r = OscReceiver()

    @test isListening(r) == false
    @test hasNewMessage(r) == false

end