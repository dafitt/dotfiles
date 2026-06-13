-- https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations

hl.curve("ease", { type = "bezier", points = { { 0.25, 0.1 }, { 0.25, 1 } } })
hl.curve("easeIn", { type = "bezier", points = { { 0.42, 0 }, { 1, 1 } } })
hl.curve("easeInOut", { type = "bezier", points = { { 0.58, 0.28 }, { 0.52, 0.95 } } })
hl.curve("easeInOutBack", { type = "bezier", points = { { 0.68, -0.55 }, { 0.265, 1.55 } } })
hl.curve("easeInOutQuart", { type = "bezier", points = { { 0.77, 0 }, { 0.175, 1 } } })
hl.curve("easeOut", { type = "bezier", points = { { 0, 0 }, { 0.58, 1 } } })
hl.curve("easeOutBack", { type = "bezier", points = { { 0.175, 0.885 }, { 0.32, 1.275 } } })
hl.curve("easeOutCirc", { type = "bezier", points = { { 0.075, 0.82 }, { 0.165, 1 } } })
hl.curve("easeOutCubic", { type = "bezier", points = { { 0.215, 0.61 }, { 0.355, 1 } } })
hl.curve("easeOutExpo", { type = "bezier", points = { { 0.19, 1 }, { 0.22, 1 } } })
hl.curve("easeOutQuad", { type = "bezier", points = { { 0.25, 0.46 }, { 0.45, 0.94 } } })
hl.curve("easeOutQuart", { type = "bezier", points = { { 0.165, 0.84 }, { 0.44, 1 } } })
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeOutSine", { type = "bezier", points = { { 0.39, 0.575 }, { 0.565, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })

hl.animation({
    leaf = "global",
    enabled = true,
    speed = 5,
    bezier = "easeOutExpo",
})
hl.animation({
    leaf = "windows",
    enabled = true,
    speed = 5,
    bezier = "easeOutExpo",
    style = "popin",
})
hl.animation({
    leaf = "layers",
    enabled = true,
    speed = 5,
    bezier = "easeOutExpo",
    style = "slide",
})
hl.animation({
    leaf = "workspaces",
    enabled = true,
    speed = 7.5,
    bezier = "easeOutExpo",
    style = "slidefadevert 5%",
})
