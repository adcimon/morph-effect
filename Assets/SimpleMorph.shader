Shader "Custom/Simple Morph"
{
	Properties
	{
		_Texture("Texture", 2D) = "white" { }
		_Color("Main Color", Color) = (1, 1, 1, 1)
		[Enum(None, 0, Cube, 1, Sphere, 2)] _Mode("Mode", float) = 0
		_Size("Size", float) = 1
		_BlendFactor("Blend Factor", float) = 0
		_OffsetFactor("Offset Factor", float) = 4
	}

	SubShader
	{
		Pass
		{
			CGPROGRAM
			#pragma vertex Vertex
			#pragma fragment Fragment
			#include "UnityCG.cginc"

			sampler2D _Texture;
			float4 _Color;
			float _Mode;
			float _Size;
			float _BlendFactor;
			float _OffsetFactor;

			struct VertexInput
			{
				float4 position : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct FragmentInput
			{
				float4 position : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			FragmentInput Vertex( VertexInput v )
			{
				FragmentInput f;

				switch( _Mode )
				{
					// Cube.
					case 1:
					{
						float4 position = v.position;
						position.xyz *= _OffsetFactor / length(position.xyz);
						position.xyz = clamp(position.xyz, -_Size, _Size);
						f.position = UnityObjectToClipPos(lerp(v.position, position, _BlendFactor));
						break;
					}
					// Sphere.
					case 2:
					{
						float4 position = v.position;
						position.xyz *= _OffsetFactor / length(position.xyz);
						f.position = UnityObjectToClipPos(lerp(v.position, position, _BlendFactor));
						break;
					}
					default:
					{
						f.position = UnityObjectToClipPos(v.position);
						break;
					}
				}

				f.uv = v.uv;

				return f;
			}

			float4 Fragment( FragmentInput f ) : COLOR
			{
				return tex2D(_Texture, f.uv) * _Color;
			}
			ENDCG
		}
	}
}