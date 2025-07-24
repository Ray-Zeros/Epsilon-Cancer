in vec3 vaPosition;
in vec2 vaUV0;
in ivec2 vaUV2;
in vec4 vaColor;

uniform mat4 modelViewMatrix;
uniform mat4 projectionMatrix;
uniform vec3 chunkOffset;

out vec2 lmCoord;
out vec2 texCoord;
out vec4 glColor;

void main() {
    
    gl_Position = projectionMatrix * modelViewMatrix * vec4(vaPosition + chunkOffset, 1.0);

    texCoord = vaUV0;
    glColor = vaColor;
    lmCoord = vaUV2 * (1.0/256.0) + (1.0/32.0);

}
