//
//  ViewController.m
//  openglcircle
//
//  Created by gaozhimin on 12-9-14.
//  Copyright (c) 2012年 autonavi. All rights reserved.
//

#import "ViewController.h"

#define BUFFER_OFFSET(i) ((char *)NULL + (i))
#define TEX_COORD_MAX 1
GLuint texture[1];
// Uniform index.
enum
{
    UNIFORM_MODELVIEWPROJECTION_MATRIX,
    UNIFORM_NORMAL_MATRIX,
    UNIFORM_COLOR,
    UNIFORM_TEXTURE,
    NUM_UNIFORMS
};
GLint uniforms[NUM_UNIFORMS];

// Attribute index.
enum
{
    ATTRIB_VERTEX,
    ATTRIB_NORMAL,
    ATTRIB_COLOR,
    ATTRIB_TEXTURE,
    NUM_ATTRIBUTES
};

typedef struct {
    float Position[3];
    float nomal[3];
    float TexCoord[2]; // New
} Vertex;

const Vertex Vertices[] = {
    // Front
    {{1, -1, 0}, { 0, 0, 1}, {TEX_COORD_MAX, 0}},
    {{1, 1, 0}, {0, 0, 1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, 0}, { 0, 0, 1}, {0, TEX_COORD_MAX}},
    {{-1, -1, 0}, { 0, 0, 1}, {0, 0}},
    // Back
    {{1, 1, -2}, { 0, 0, -1}, {TEX_COORD_MAX, 0}},
    {{-1, -1, -2}, { 0, 0, -1}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, -1, -2}, { 0, 0, -1}, {0, TEX_COORD_MAX}},
    {{-1, 1, -2}, { 0, 0, -1}, {0, 0}},
    // Left
    {{-1, -1, 0}, {-1, 0, 0}, {TEX_COORD_MAX, 0}},
    {{-1, 1, 0}, {-1, 0, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {-1, 0, 0}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {-1, 0, 0}, {0, 0}},
    // Right
    {{1, -1, -2}, {1, 0, 0}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {1, 0, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{1, 1, 0}, {1, 0, 0}, {0, TEX_COORD_MAX}},
    {{1, -1, 0}, {1, 0, 0}, {0, 0}},
    // Top
    {{1, 1, 0}, {0, 1, 0}, {TEX_COORD_MAX, 0}},
    {{1, 1, -2}, {0, 1, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, 1, -2}, {0, 1, 0}, {0, TEX_COORD_MAX}},
    {{-1, 1, 0}, {0, 1, 0}, {0, 0}},
    // Bottom
    {{1, -1, -2}, {0, -1, 0}, {TEX_COORD_MAX, 0}},
    {{1, -1, 0}, {0, -1, 0}, {TEX_COORD_MAX, TEX_COORD_MAX}},
    {{-1, -1, 0}, {0, -1, 0}, {0, TEX_COORD_MAX}},
    {{-1, -1, -2}, {0, -1, 0}, {0, 0}}
};

const GLubyte Indices[] = {
    // Front
    0, 1, 2,
    2, 3, 0,
    // Back
    4, 5, 6,
    4, 5, 7,
    // Left
    8, 9, 10,
    10, 11, 8,
    // Right
    12, 13, 14,
    14, 15, 12,
    // Top
    16, 17, 18,
    18, 19, 16,
    // Bottom
    20, 21, 22,
    22, 23, 20
};

GLfloat gCubeVertexData[288] =
{
    // Data layout for each line below is:
    // positionX, positionY, positionZ,     normalX, normalY, normalZ,
    0.5f, -0.5f, -0.5f,        1.0f, 0.0f, 0.0f,    0.0f,0.0f,
    0.5f, 0.5f, -0.5f,         1.0f, 0.0f, 0.0f,    1.0f,0.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,    0.0f,1.0f,
    0.5f, -0.5f, 0.5f,         1.0f, 0.0f, 0.0f,    0.0f,1.0f,
    0.5f, 0.5f, -0.5f,          1.0f, 0.0f, 0.0f,   1.0f,0.0f,
    0.5f, 0.5f, 0.5f,         1.0f, 0.0f, 0.0f,     1.0f,1.0f,
    
    0.5f, 0.5f, -0.5f,         0.0f, 1.0f, 0.0f,    0.0f,0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,    1.0f,0.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,    0.0f,1.0f,
    0.5f, 0.5f, 0.5f,          0.0f, 1.0f, 0.0f,    0.0f,1.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 1.0f, 0.0f,    1.0f,0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 1.0f, 0.0f,    1.0f,1.0f,
    
    -0.5f, 0.5f, -0.5f,        -1.0f, 0.0f, 0.0f,   0.0f,0.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,   1.0f,0.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,   0.0f,1.0f,
    -0.5f, 0.5f, 0.5f,         -1.0f, 0.0f, 0.0f,   0.0f,1.0f,
    -0.5f, -0.5f, -0.5f,       -1.0f, 0.0f, 0.0f,   1.0f,0.0f,
    -0.5f, -0.5f, 0.5f,        -1.0f, 0.0f, 0.0f,   1.0f,1.0f,
    
    -0.5f, -0.5f, -0.5f,       0.0f, -1.0f, 0.0f,   0.0f,0.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,   1.0f,0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,   0.0f,1.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, -1.0f, 0.0f,   0.0f,1.0f,
    0.5f, -0.5f, -0.5f,        0.0f, -1.0f, 0.0f,   1.0f,0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, -1.0f, 0.0f,   1.0f,1.0f,
    
    0.5f, 0.5f, 0.5f,          0.0f, 0.0f, 1.0f,    0.0f,0.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,    1.0f,0.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,    0.0f,1.0f,
    0.5f, -0.5f, 0.5f,         0.0f, 0.0f, 1.0f,    0.0f,1.0f,
    -0.5f, 0.5f, 0.5f,         0.0f, 0.0f, 1.0f,    1.0f,0.0f,
    -0.5f, -0.5f, 0.5f,        0.0f, 0.0f, 1.0f,    1.0f,1.0f,
    
    0.5f, -0.5f, -0.5f,        0.0f, 0.0f, -1.0f,   0.0f,0.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,   1.0f,0.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,   0.0f,1.0f,
    0.5f, 0.5f, -0.5f,         0.0f, 0.0f, -1.0f,   0.0f,1.0f,
    -0.5f, -0.5f, -0.5f,       0.0f, 0.0f, -1.0f,   1.0f,0.0f,
    -0.5f, 0.5f, -0.5f,        0.0f, 0.0f, -1.0f,   1.0f,1.0f
};

@interface ViewController () {
    GLuint _program;
    
    GLKMatrix4 _modelViewProjectionMatrix;
    GLKMatrix3 _normalMatrix;
    GLKMatrix2 _texture;
    float _rotation;
    
    GLuint _vertexArray;
    GLuint _vertexBuffer;
    GLuint _indicesArray;
    GLuint _indicesBuffer;
    GLuint _verticesArray;
    GLuint _verticesBuffer;
}
@property (strong, nonatomic) EAGLContext *context;
@property (strong, nonatomic) GLKBaseEffect *effect;

- (void)setupGL;
- (void)tearDownGL;

- (BOOL)loadShaders;
- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file;
- (BOOL)linkProgram:(GLuint)prog;
- (BOOL)validateProgram:(GLuint)prog;
- (GLuint)compileShader:(NSString*)shaderName withType:(GLenum)shaderType ;
- (void)compileShaders;
@end

@implementation ViewController

- (void)dealloc
{
    [self tearDownGL];
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    
    [_context release];
    [_effect release];
    [super dealloc];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.context = [[[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2] autorelease];

    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    [self setupGL];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        [self tearDownGL];
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }

    // Dispose of any resources that can be recreated.
}

- (void)setupGL
{
    [EAGLContext setCurrentContext:self.context];
    
    [self loadShaders];
    
    self.effect = [[[GLKBaseEffect alloc] init] autorelease];
    self.effect.light0.enabled = GL_TRUE;
    self.effect.light0.diffuseColor = GLKVector4Make(0.0f, 0.0, 0.00f, 1.0f);
    
    
//    glEnable(GL_TEXTURE_2D);
    glEnable(GL_DEPTH_TEST);
//    glEnable(GL_BLEND);
    glBlendFunc(GL_ZERO, GL_ONE);
    
    glGenTextures(1, &texture[0]);
    
    glBindTexture(GL_TEXTURE_2D, texture[0]);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MIN_FILTER,GL_LINEAR);
    glTexParameteri(GL_TEXTURE_2D,GL_TEXTURE_MAG_FILTER,GL_LINEAR);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT);
//    glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT);
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"asd" ofType:@"png"];
    NSData *texData = [[NSData alloc] initWithContentsOfFile:path];
    UIImage *image = [[UIImage alloc] initWithData:texData];
    if (image == nil)
        NSLog(@"Do real error checking here");
    
    GLuint width = CGImageGetWidth(image.CGImage);
    GLuint height = CGImageGetHeight(image.CGImage);
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    void *imageData = malloc( height * width * 4 );
    CGContextRef context = CGBitmapContextCreate( imageData, width, height, 8, 4 * width,
                                                 colorSpace, kCGImageAlphaPremultipliedLast | kCGBitmapByteOrder32Big );
    CGColorSpaceRelease( colorSpace );
    CGContextClearRect( context, CGRectMake( 0, 0, width, height ) );
    CGContextTranslateCTM( context, 0, height - height );
    CGContextDrawImage( context, CGRectMake( 0, 0, width, height ), image.CGImage );
    
    glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, width, height, 0, GL_RGBA,
                 GL_UNSIGNED_BYTE, imageData);
    
    CGContextRelease(context);
    
    free(imageData);
    [image release];
    [texData release];
    
    

    
//    glGenVertexArraysOES(1, &_vertexArray);
//    glBindVertexArrayOES(_vertexArray);
//    
//    glGenBuffers(1, &_vertexBuffer);
//    glBindBuffer(GL_ARRAY_BUFFER, _vertexBuffer);
//    glBufferData(GL_ARRAY_BUFFER, sizeof(gCubeVertexData), gCubeVertexData, GL_STATIC_DRAW);
//    glEnableVertexAttribArray(GLKVertexAttribPosition);
//    glEnableVertexAttribArray(GLKVertexAttribNormal);
//    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
//    
//    
//    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(float)*8, (GLvoid*) (sizeof(float) * 0));
//    
//    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(float)*8, (GLvoid*) (sizeof(float) * 3));
//    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(float)*8, (GLvoid*) (sizeof(float) * 6));
    
    glGenVertexArraysOES(1, &_verticesArray);
    glBindVertexArrayOES(_verticesArray);
    
    glGenBuffers(1, &_verticesBuffer);
    glBindBuffer(GL_ARRAY_BUFFER, _verticesBuffer);
    glBufferData(GL_ARRAY_BUFFER, sizeof(Vertices), Vertices, GL_STATIC_DRAW);
    
    glGenVertexArraysOES(1, &_indicesArray);
    glBindVertexArrayOES(_indicesArray);
    
    glGenBuffers(1, &_indicesBuffer);
    glBindBuffer(GL_ELEMENT_ARRAY_BUFFER, _indicesBuffer);
    glBufferData(GL_ELEMENT_ARRAY_BUFFER, sizeof(Indices), Indices, GL_STATIC_DRAW);
    
    
    glEnableVertexAttribArray(GLKVertexAttribPosition);
    glEnableVertexAttribArray(GLKVertexAttribNormal);
    glEnableVertexAttribArray(GLKVertexAttribTexCoord0);
    
    
    glVertexAttribPointer(GLKVertexAttribPosition, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 0));
    glVertexAttribPointer(GLKVertexAttribNormal, 3, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 3));
    glVertexAttribPointer(GLKVertexAttribTexCoord0, 2, GL_FLOAT, GL_FALSE, sizeof(Vertex), (GLvoid*) (sizeof(float) * 6));
   
   
}

- (void)tearDownGL
{
    [EAGLContext setCurrentContext:self.context];
    
    glDeleteBuffers(1, &_vertexBuffer);
    glDeleteVertexArraysOES(1, &_vertexArray);
    
    glDeleteBuffers(1, &_verticesArray);
    glDeleteVertexArraysOES(1, &_verticesBuffer);
    
    glDeleteVertexArraysOES(1, &_indicesArray);
    glDeleteBuffers(1, &_indicesBuffer);
    
    
    self.effect = nil;
    
    if (_program) {
        glDeleteProgram(_program);
        _program = 0;
    }
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    float aspect = fabsf(self.view.bounds.size.width / self.view.bounds.size.height);
    GLKMatrix4 projectionMatrix = GLKMatrix4MakePerspective(GLKMathDegreesToRadians(65.0f), aspect, 0.1f, 1000.0f);
    
    self.effect.transform.projectionMatrix = projectionMatrix;
    
    GLKMatrix4 baseModelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -10.0f);
    baseModelViewMatrix = GLKMatrix4Rotate(baseModelViewMatrix, _rotation, 0.0f, 1.0f, 0.0f);
    
    // Compute the model view matrix for the object rendered with GLKit
    GLKMatrix4 modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, -1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    self.effect.transform.modelviewMatrix = modelViewMatrix;
    
    // Compute the model view matrix for the object rendered with ES2
    modelViewMatrix = GLKMatrix4MakeTranslation(0.0f, 0.0f, 1.5f);
    modelViewMatrix = GLKMatrix4Rotate(modelViewMatrix, _rotation, 1.0f, 1.0f, 1.0f);
    modelViewMatrix = GLKMatrix4Multiply(baseModelViewMatrix, modelViewMatrix);
    
    _normalMatrix = GLKMatrix3InvertAndTranspose(GLKMatrix4GetMatrix3(modelViewMatrix), NULL);
    
    _modelViewProjectionMatrix = GLKMatrix4Multiply(projectionMatrix, modelViewMatrix);
    
    _rotation += self.timeSinceLastUpdate * 0.5f;
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    glClearColor(0.65f, 0.65f, 0.65f, 1.0f);
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    
    // Render the object with GLKit
    [self.effect prepareToDraw];
//    glDrawArrays(GL_TRIANGLES, 0, 36);
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
    
    glUseProgram(_program);
    
    glUniformMatrix4fv(uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX], 1, 0, _modelViewProjectionMatrix.m);
    glUniformMatrix3fv(uniforms[UNIFORM_NORMAL_MATRIX], 1, 0, _normalMatrix.m);
    
    glDrawElements(GL_TRIANGLES, sizeof(Indices)/sizeof(Indices[0]), GL_UNSIGNED_BYTE, 0);
//    glDrawArrays(GL_TRIANGLES, 0, 36);
}

#pragma mark -  OpenGL ES 2 shader compilation


- (BOOL)loadShaders
{
    GLuint vertShader, fragShader;
    NSString *vertShaderPathname, *fragShaderPathname;
    
    // Create shader program.
    _program = glCreateProgram();
    
    // Create and compile vertex shader.
    vertShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"vsh"];
    if (![self compileShader:&vertShader type:GL_VERTEX_SHADER file:vertShaderPathname]) {
        NSLog(@"Failed to compile vertex shader");
        return NO;
    }
    
    // Create and compile fragment shader.
    fragShaderPathname = [[NSBundle mainBundle] pathForResource:@"Shader" ofType:@"fsh"];
    if (![self compileShader:&fragShader type:GL_FRAGMENT_SHADER file:fragShaderPathname]) {
        NSLog(@"Failed to compile fragment shader");
        return NO;
    }
    
    // Attach vertex shader to program.
    glAttachShader(_program, vertShader);
    
    // Attach fragment shader to program.
    glAttachShader(_program, fragShader);
    
    // Bind attribute locations.
    // This needs to be done prior to linking.
    glBindAttribLocation(_program, GLKVertexAttribPosition, "position");
    glBindAttribLocation(_program, GLKVertexAttribNormal, "normal");
    glBindAttribLocation(_program, GLKVertexAttribTexCoord0, "TexCoordIn");
    
   
//    glBindAttribLocation(_program, NUM_ATTRIBUTES, "TexCoordIn");
   
    // Link program.
    if (![self linkProgram:_program]) {
        NSLog(@"Failed to link program: %d", _program);
        
        if (vertShader) {
            glDeleteShader(vertShader);
            vertShader = 0;
        }
        if (fragShader) {
            glDeleteShader(fragShader);
            fragShader = 0;
        }
        if (_program) {
            glDeleteProgram(_program);
            _program = 0;
        }
        
        return NO;
    }
    
    // Get uniform locations.
    uniforms[UNIFORM_MODELVIEWPROJECTION_MATRIX] = glGetUniformLocation(_program, "modelViewProjectionMatrix");
    uniforms[UNIFORM_NORMAL_MATRIX] = glGetUniformLocation(_program, "normalMatrix");
    
    // Release vertex and fragment shaders.
    if (vertShader) {
        glDetachShader(_program, vertShader);
        glDeleteShader(vertShader);
    }
    if (fragShader) {
        glDetachShader(_program, fragShader);
        glDeleteShader(fragShader);
    }
    
    return YES;
}

- (BOOL)compileShader:(GLuint *)shader type:(GLenum)type file:(NSString *)file
{
    GLint status;
    const GLchar *source;
    
    source = (GLchar *)[[NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:nil] UTF8String];
    if (!source) {
        NSLog(@"Failed to load vertex shader");
        return NO;
    }
    
    *shader = glCreateShader(type);
    glShaderSource(*shader, 1, &source, NULL);
    glCompileShader(*shader);
    
#if defined(DEBUG)
    GLint logLength;
    glGetShaderiv(*shader, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetShaderInfoLog(*shader, logLength, &logLength, log);
        NSLog(@"Shader compile log:\n%s", log);
        free(log);
    }
#endif
    
    glGetShaderiv(*shader, GL_COMPILE_STATUS, &status);
    if (status == 0) {
        glDeleteShader(*shader);
        return NO;
    }
    
    return YES;
}

- (BOOL)linkProgram:(GLuint)prog
{
    GLint status;
    glLinkProgram(prog);
    
#if defined(DEBUG)
    GLint logLength;
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program link log:\n%s", log);
        free(log);
    }
#endif
    
    glGetProgramiv(prog, GL_LINK_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

- (BOOL)validateProgram:(GLuint)prog
{
    GLint logLength, status;
    
    glValidateProgram(prog);
    glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLength);
    if (logLength > 0) {
        GLchar *log = (GLchar *)malloc(logLength);
        glGetProgramInfoLog(prog, logLength, &logLength, log);
        NSLog(@"Program validate log:\n%s", log);
        free(log);
    }
    
    glGetProgramiv(prog, GL_VALIDATE_STATUS, &status);
    if (status == 0) {
        return NO;
    }
    
    return YES;
}

@end
