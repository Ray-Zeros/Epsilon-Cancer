in vec2 texCoord;
in vec2 lmCoord;
in vec4 glColor;

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform sampler2D normals;

/* DRAWBUFFERS:0 */
layout(location = 0) out vec4 outColor0;


void main() {

    #ifdef DEBUG_WHITE_WORLD
    vec4 albedo = vec4(1.0);

    #else
    vec4 albedo = glColor;
    
    #endif

    albedo *= texture(gtexture, texCoord);
    vec4 lmColor = texture(lightmap, lmCoord);
    if (albedo.a <0.1) {
        discard;
    }
    
    outColor0 = albedo * lmColor;

}
