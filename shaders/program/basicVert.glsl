in vec3 vaPosition;
in vec2 vaUV0;
in ivec2 vaUV2;
in vec4 vaColor;
in vec3 vaNormal;
in vec4 at_tangent;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform mat3 normalMatrix;
uniform vec3 chunkOffset;

out vec2 lmCoord;
out vec2 texCoord;
out vec4 vColor;
out vec3 vNormal;
out vec4 tangent;


void main() {
    
    vec4 viewPos = modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);

    tangent = vec4(normalize(normalMatrix * at_tangent.xyz), at_tangent.w);
    vNormal = normalMatrix * vaNormal;
    if(dot(vNormal, viewPos.xyz) > 0.0) { vNormal = -vNormal; }
    
    texCoord = vaUV0;
    vColor = vaColor;
    lmCoord = vaUV2 * (1.0/256.0) + (1.0/32.0);

    gl_Position = projectionMatrix * viewPos;


}
