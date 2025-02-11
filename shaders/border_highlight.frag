#version 300 es
precision mediump float;

// u_resPointer: (res.x, res.y, pointer.x, pointer.y)
uniform vec4 u_resPointer;
// u_borderParams: (highlightWidth, borderRadius, threshold)
uniform vec3 u_borderParams;
// u_highlightColor: The highlight color.
uniform vec4 u_highlightColor;

out vec4 fragColor;

// Standard SDF for a rounded rectangle (with p in centered coordinates)
float sdRoundedRect(vec2 p, vec2 b, float r) {
  vec2 d = abs(p) - b;
  return length(max(d, vec2(0.0))) + min(max(d.x, d.y), 0.0) - r;
}

void main() {
  vec2 res = u_resPointer.xy;
  vec2 pointer = u_resPointer.zw;

  float highlightWidth = u_borderParams.x;
  float borderRadius   = u_borderParams.y;
  float threshold      = u_borderParams.z;

  // Work in coordinates centered on the container.
  vec2 uv = gl_FragCoord.xy;
  vec2 center = res * 0.5;
  vec2 p = uv - center;

  // The container is a rectangle from (0,0) to (res).
  // Its centered half extents are 'center'. To leave room for the rounded corners,
  // subtract the border radius.
  vec2 b = center - vec2(borderRadius);

  // SDF: negative inside the shape; zero at the ideal border.
  float d = sdRoundedRect(p, b, borderRadius);

  // Define the border region as those fragments whose SDF lies between -highlightWidth and 0.
  // Using step() gives a crisp band. (If desired, you can replace these with smoothstep() calls for antialiasing.)
  float borderAlpha = step(d, 0.0) - step(d, -highlightWidth);

  // Compute a pointer falloff based on radial distance.
  float pointerEffect = clamp(1.0 - (distance(uv, pointer) / threshold), 0.0, 1.0);

  float intensity = borderAlpha * pointerEffect;

  fragColor = u_highlightColor * intensity;
}
