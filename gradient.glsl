void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (fragCoord + fragCoord - iResolution.xy);
  uv = uv / iResolution.y;

  float time = iTime * 0.5;
  float timeCos = cos(time);
  float timeSin = sin(time);
  mat2 rotate = mat2(timeCos, -timeSin, timeSin, timeCos);
  uv *= rotate;

  //dist from center
  float dist = length(uv);

  float angle = atan(uv.y, uv.x);

  vec3 col = vec3(
		  0.5 + 0.5 * sin(dist * 3.0 - time),
		  0.5 + 0.5 * cos(angle * 2.0 + time),
		  0.5 + 0.5 * sin(dist * 5.0 + angle - time * 2.0)
		  );

  col *= 1.0 - dist * 0.3;
  
  
  fragColor = vec4(col, 1.0);
}

