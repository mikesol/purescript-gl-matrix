"use strict";

const m = require("gl-matrix")

exports.js_rotationTo = (a, b) => {
    let out = m.quat.create()
    m.quat.rotationTo(out, a, b)
    return out
}

exports.js_setAxes = (view, right, up) => {
    let out = m.quat.create()
    m.quat.setAxes(out, view, right, up)
    return out
}
