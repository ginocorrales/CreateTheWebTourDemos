/*
 * Copyright (c) 2012 Adobe Systems Incorporated. All rights reserved.
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

precision mediump float;

// Built-in attributes

attribute vec4 a_position;
attribute vec2 a_texCoord;
attribute vec3 a_triangleCoord;

// Uniforms

uniform mat4 u_projectionMatrix;
uniform vec2 u_textureSize;

// Uniforms passed in from CSS

uniform mat4 matrix;
uniform float t;
uniform float amount;

// Random function based on the tile coordinate. This will return the same value
// for all the vertices in the same tile (i.e., two triangles).

float random(vec2 scale)
{
    // Use the fragment position for a different seed per-pixel.
    return fract(sin(dot(vec2(a_triangleCoord.x, a_triangleCoord.y), scale)) * 4000.0);
}

// Main

void main()
{
    float r = random(vec2(10.0, 80.0));

    vec4 pos = a_position;

    float dz = -amount * t * r;
    vec3 tc = a_triangleCoord;

    if (mod(tc.x + tc.y, 2.0) == 0.0) {
        dz = amount * t * r;
    }

    pos.z += dz;

    gl_Position = u_projectionMatrix * matrix * pos;
}
