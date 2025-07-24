vec3 srgbToLinear(vec3 color) {
    return pow(color, vec3(2.2));
}