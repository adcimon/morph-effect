# Vertex Shader: Simple Morph.

Vertex shader that morphs geometry into primitive shapes.

![Example](example.gif "Dungeons & fat Dragons")

This shader has been made with Unity 2017.3.0. To use it just add a material with the shader to a mesh renderer and attach the provided C# script to the gameobject.

To morph into a cube the vertices are expanded and clamped to fit the cube dimensions.
```
...

float4 position = v.position;
position.xyz *= _OffsetFactor / length(position.xyz);
position.xyz = clamp(position.xyz, -_Size, _Size);
f.position = UnityObjectToClipPos(lerp(v.position, position, _BlendFactor));

...
```

To morph into a sphere the vertices are expanded but not clamped.
```
...

float4 position = v.position;
position.xyz *= _OffsetFactor / length(position.xyz);
f.position = UnityObjectToClipPos(lerp(v.position, position, _BlendFactor));

...
```
