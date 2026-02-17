varying mediump vec4 var_position;

varying mediump vec2 var_texcoord0;


uniform lowp sampler2D tex0;
uniform lowp sampler2D tex1;

void main()
{
   
/*
    vec4 color0 = texture2D(tex0, var_texcoord0.xy);
    vec4 color1 = texture2D(tex1, var_texcoord0.xy);
    lowp float distance = texture2D(tex1, var_texcoord0).x;

    lowp float sdf_edge = 0.0;
    lowp float sdf_outline = 0.3;
    lowp float sdf_smoothing = 0.005;

    lowp float alpha = smoothstep(sdf_edge - sdf_smoothing, sdf_edge + sdf_smoothing, distance);
    lowp float outline_alpha = smoothstep(sdf_outline - sdf_smoothing, sdf_outline + sdf_smoothing, distance);
    lowp vec4 color =color0;

    gl_FragColor = color * outline_alpha;  
    */
    
    /*
    vec4 color = texture2D(tex0,var_texcoord0.xy);
    vec4 mask  = texture2D(tex1,var_texcoord0.xy);
    vec4  colorOut =vec4(color.rgb,color.a * mask.r);//alpha value can be in any channel ,depends on texture format.
    gl_FragColor =colorOut;
    */
    
    /*  
    vec4 base_pixel = texture2D(tex0, var_texcoord0.xy);
    vec4 mask_pixel = texture2D(tex1, var_texcoord0.xy);
    float factor = 1.0 - mask_pixel.x;
    vec4 blended_pixel = vec4(base_pixel.r, base_pixel.g, base_pixel.b, base_pixel.a - factor);
    gl_FragColor = blended_pixel;
    */

    // get the current pixel color
    vec4 texel = texture2D(tex0, var_texcoord0.xy);
   // get alpha based on the color of the mask image
    float alpha = texture2D(tex1, var_texcoord0.xy).r;
    // apply the alpha to the current pixel
    gl_FragColor = texel * alpha;

}

