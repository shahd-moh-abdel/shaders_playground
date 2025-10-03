void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 resolution = iResolution.xy;

  vec2 uv = fragColor / resolution;

  fragColor = vec4(uv.x, uv.y, 0.0, 1.0);
}
