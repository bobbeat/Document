//
//  Shader.vsh
//  openglcircle
//
//  Created by gaozhimin on 12-9-14.
//  Copyright (c) 2012年 autonavi. All rights reserved.
//

attribute vec4 position;
attribute vec3 normal;

varying lowp vec4 colorVarying;

uniform mat4 modelViewProjectionMatrix;
uniform mat3 normalMatrix;
//
attribute vec2 TexCoordIn; // New
varying vec2 TexCoordOut; // New

void main()
{
    vec3 eyeNormal = normalize(normalMatrix * normal);
    vec3 lightPosition = vec3(0.0, 0.0, 1.0);
    vec4 diffuseColor = vec4(1.0, 1.0, 1.0, 1.0);
    
    float nDotVP = max(0.0, dot(eyeNormal, normalize(lightPosition)));
                 
    colorVarying = diffuseColor * nDotVP;
    
    gl_Position = modelViewProjectionMatrix * position;
    
    TexCoordOut = TexCoordIn; // New
}
