#include "/lib/tools/colors.glsl"
#include "/lib/tools/util.glsl"

in vec2 texCoord;
in vec2 lmCoord;
in vec4 vColor;
in vec3 vNormal;
in vec4 tangent;

uniform sampler2D lightmap;
uniform sampler2D gtexture;
uniform sampler2D normals;
uniform mat4 gbufferModelViewInverse;
uniform vec3 shadowLightPosition;

/* RENDERTARGETS:0 */
layout(location = 0) out vec4 outColor0;

#ifdef DEBUG_NORMALS_WORLD
    vec3 worldvNormal = mat3(gbufferModelViewInverse) * vNormal;
    outColor0 = vec4(worldvNormal, albedo.a);
    return;

#else
    vec3 worldvNormal = mat3(gbufferModelViewInverse) * vNormal;

#endif

vec3 worldTNormal(){

    vec3 worldTangent = mat3(gbufferModelViewInverse) * tangent.xyz;

    vec4 normalData = texture(normals, texCoord)*2.0 - 1.0;

    vec3 normal = vec3(normalData.xy, sqrt(1.0 - dot(normalData.xy, normalData.xy)));

    mat3 TBN = tbnNormalTangent(worldvNormal,worldTangent);

    vec3 worldTNormal = TBN * normal;

    return worldTNormal;

}

void main() {

    #ifdef DEBUG_WHITE_WORLD
    vec4 albedo = vec4(1.0);

    #else
    vec4 albedo = vec4(srgbToLinear(vColor.rgb), vColor.a);
    
    #endif

    vec3 shadowLightDirection = normalize(mat3(gbufferModelViewInverse) * shadowLightPosition);

    float worldLightBrightness = clamp(dot(shadowLightDirection,worldTNormal()),0.2,1.0);

    vec4 outputColorData = texture(gtexture, texCoord);
    
    albedo *= vec4(srgbToLinear(outputColorData.rgb),outputColorData.a);

    // vec4 lmColor = texture(lightmap, lmCoord);
    vec3 lightColor = srgbToLinear(texture(lightmap, lmCoord).rgb);

    if (albedo.a <0.1) {
        discard;
    }
    
    


    // outColor0 = albedo * lmColor * worldLightBrightness;
    outColor0 = vec4(pow(albedo.rgb * lightColor * worldLightBrightness, vec3(1.0/2.2)), albedo.a);

}
