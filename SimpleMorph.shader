Shader "Custom/Simple Morph"
{
	Properties
	{
		_MainTex("Texture", 2D) = "white" { }
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
			HLSLPROGRAM
			#pragma vertex Vertex
			#pragma fragment Fragment
			#include "UnityCG.cginc"

			sampler2D _MainTex;
			float4 _Color;
			float _Mode;
			float _Size;
			float _BlendFactor;
			float _OffsetFactor;

			struct Attributes
			{
				float4 positionOS : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct Varyings
			{
				float4 positionCS : SV_POSITION;
				float2 uv : TEXCOORD0;
			};

			Varyings Vertex( Attributes input )
			{
				Varyings output;

				switch( _Mode )
				{
					// Cube.
					case 1:
					{
						float4 position = input.positionOS;
						position.xyz *= _OffsetFactor / length(position.xyz);
						position.xyz = clamp(position.xyz, -_Size, _Size);
						output.positionCS = UnityObjectToClipPos(lerp(input.positionOS, position, _BlendFactor));
						break;
					}
					// Sphere.
					case 2:
					{
						float4 position = input.positionOS;
						position.xyz *= _OffsetFactor / length(position.xyz);
						output.positionCS = UnityObjectToClipPos(lerp(input.positionOS, position, _BlendFactor));
						break;
					}
					default:
					{
						output.positionCS = UnityObjectToClipPos(input.positionOS);
						break;
					}
				}

				output.uv = input.uv;

				return output;
			}

			fixed4 Fragment( Varyings input ) : SV_TARGET
			{
				return tex2D(_MainTex, input.uv) * _Color;
			}
			ENDHLSL
		}
	}
}