// https://shaderlabs.org/wiki/Shader_Tricks
mat3 tbnNormalTangent(vec3 normal, vec3 tangent) {
    // For DirectX normal mapping you want to switch the order of these 
    vec3 bitangent = cross(tangent, normal);
    return mat3(tangent, bitangent, normal);
}