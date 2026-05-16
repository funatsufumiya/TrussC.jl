test_cases = [
    "vec_test.jl",
    "json_test.jl",
    "fbo_test.jl",
    "color_test.jl",
    "image_test.jl",
    "path_test.jl",
    "xml_test.jl",
]

for case in test_cases
  include(case)
end

nothing