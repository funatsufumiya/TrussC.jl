using Test
using Pipe: @pipe
using TrussC; tc = TrussC

@testset "Xml Test" begin

  xml = Xml()
  addDeclaration(xml)

  root = addRoot(xml, "project")
  @pipe root |> append_attribute(_, "name") |> set(_, "TrussC")

  @test name(root) == "project"
  @test value(attribute(root, "name")) == "TrussC"

  s = toString(xml)
  s = strip(s, ['\n', ' ', '\t'])

  @test startswith(s, "<?xml")
  @test endswith(s, ">")

end