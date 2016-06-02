//
//  Shader.fsh
//  openglcircle
//
//  Created by gaozhimin on 12-9-14.
//  Copyright (c) 2012年 autonavi. All rights reserved.
//

varying lowp vec4 colorVarying;

varying lowp vec2 TexCoordOut; // New
uniform sampler2D Texture; // New


void main()
{
    gl_FragColor = colorVarying * texture2D(Texture, TexCoordOut); // New
//    gl_FragColor = colorVarying;
}
