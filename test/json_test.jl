using Test
using TrussC; tc = TrussC

@testset "Json Test" begin

  j = Json()
  j2 = Json()
  j2["d"] = "lemon"
  j["a"] = "hello"
  j["b"] = 1.0f0
  j["c"] = j2

  @test get_string(j["a"]) == "hello"
  @test get_float(j["b"]) == 1.0f0
  @test get_string(j["c"]["d"]) == "lemon"

end