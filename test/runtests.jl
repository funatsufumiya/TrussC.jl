test_cases = [
    "vec_test.jl",
    "json_test.jl",
    "fbo_test.jl",
    "color_test.jl",
    "image_test.jl",
    "path_test.jl",
    "xml_test.jl",
    "sound_test.jl",

    "hap_player_test.jl",

    "osc_bundle_test.jl",
    "osc_message_test.jl",
    "osc_receiver_test.jl",
    "osc_sender_test.jl",
]

for case in test_cases
  include(case)
end

nothing