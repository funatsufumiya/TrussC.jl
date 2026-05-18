using Test
using TrussC; tc = TrussC

@testset "Vec2 Test" begin

  v1 = Vec2(1.0f0, 2.0f0)
  @test x(v1) == 1.0f0
  @test y(v1) == 2.0f0

  @test tc.length(v1) == 2.236068f0
  @test abs(tc.length(normalized(v1)) - 1.0f0) < 0.0001f0
  @test v1 + 1.0f0 == Vec2(2.0f0, 3.0f0)
  @test v1 * 2.0f0 == Vec2(2.0f0, 4.0f0)
  @test v1 / 2.0f0 == Vec2(0.5f0, 1.0f0)

  v2 = Vec2(1.0f0, 2.0f0)
  @test x(v2) == 1.0f0
  @test y(v2) == 2.0f0

  x!(v2, 2.0f0)
  y!(v2, 3.0f0)
  @test x(v2) == 2.0f0
  @test y(v2) == 3.0f0

end

@testset "Vec3 Test" begin

  v2 = Vec3(1.0f0, 2.0f0, 3.0f0)
  @test x(v2) == 1.0f0
  @test y(v2) == 2.0f0
  @test z(v2) == 3.0f0

  @test tc.distance(v2, v2) == 0.0f0
  @test tc.distance(v2, v2 + Vec3(1.0f0, 0f0, 0f0)) == 1.0f0

end

@testset "Vec4 Test" begin

  v3 = Vec4(1.0f0, 2.0f0, 3.0f0, 4.0f0)
  @test x(v3) == 1.0f0
  @test y(v3) == 2.0f0
  @test z(v3) == 3.0f0
  @test w(v3) == 4.0f0

end