float hash(vec2 p)
{
  return fract(sin(dot(p, vec2(12.9, 4.1))) * 43758.5);
}

float noise(vec2 p)
{
  vec2 i = floor(p);
  vec2 f = fract(p);

  f = f * f * (3.0 - 2.0 * f);

  float a = hash(i);
  float b = hash(i + vec2(1.0, 0.0));
  float c = hash(i + vec2(0.0, 1.0));
  float d = hash(i + vec2(1.0, 1.0));

  return mix(mix(a, b, f.x), mix(c, d, f.x), f.y);
}

float fbm(vec2 p)
{
  float value = 0.0;
  float amplitude = 0.5;
  float frequency = 1.0;

  for(int i = 0; i < 3; i++)
    {
      value += amplitude * noise(p * frequency);
      amplitude *= 0.5;
      frequency *= 2.0;
    }

  return value;
}

void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
  vec2 uv = (fragCoord + fragCoord - iResolution.xy);
  uv = uv / iResolution.y;

  float time = iTime * 0.3;
  float timeCos = cos(time);
  float timeSin = sin(time);
  mat2 rotate = mat2(timeCos, -timeSin, timeSin, timeCos);
  uv *= rotate;

  //dist from center
  float dist = length(uv);
  float angle = atan(uv.y, uv.x);

  vec2 noiseCoord = uv * 2.0 + time * 0.5;
  float n = fbm(noiseCoord);

  float pattern = dist * 3.0 + n * 2.0 - time;
  
  vec3 col = vec3(
		  0.5 + 0.5 * sin(pattern),
		  0.5 + 0.5 * cos(angle * 2.0 + n * 2.0 + time),
		  0.5 + 0.5 * sin(pattern * 1.3 + n)
		  );

  col *= 1.0 - dist * 0.3;
  
  
  fragColor = vec4(col, 1.0);
}

