"use strict";

const m = require("gl-matrix")

exports.js_fromScaling = (v) => {
    let out = m.mat3.create()
    m.mat3.fromScaling(out, v)
    return out
}

exports.js_fromTranslation = (v) => {
    let out = m.mat3.create()
    m.mat3.fromTranslation(out, v)
    return out
}

exports.js_normalFromMat4 = (m4) => {
    let out = m.mat3.create()
    m.mat3.normalFromMat4(out, m4)
    return out
}
