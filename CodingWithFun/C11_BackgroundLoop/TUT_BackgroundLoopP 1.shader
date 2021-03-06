﻿// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'
//SlideshowEffects2D-->sakuraplus-->https://sakuraplus.github.io/make-terrain-with-google-elevation/index.html
Shader "TUT/BackgroundLoop_P1" {
	Properties {
		_MainTex ("Main Texture", 2D) = "black" {}
		_Rotation("Rotation",  Range(0,360)) = 0.0				

		[Space(10)]
		_Progress("Progress", Range(0,1))=0
	}
	SubShader {
		Tags {"Queue"="Transparent" }
		CGINCLUDE

		#include "UnityCG.cginc"

		sampler2D _MainTex;  
		uniform half4 _MainTex_ST;

		float _Progress;
		float _Rotation;

		struct v2f {
			float4 pos : SV_POSITION;
			half2 uvTA: TEXCOORD0;

		};
		  
		v2f vert(appdata_img v) {
			v2f o;
			o.pos = mul(UNITY_MATRIX_MVP, v.vertex);
			float Rot = _Rotation * (3.1415926f/180.0f);
			float s = sin(Rot);
			float c = cos(Rot);

			o.uvTA=v.texcoord+fixed2(s,c)*_Progress ;
			return o;
		}



		fixed4 frag(v2f i) : SV_Target {
			return tex2D(_MainTex, i.uvTA).rgba ;
		}
		    
		ENDCG


		Pass {

			//ZWrite Off
			Blend SrcAlpha OneMinusSrcAlpha
			CGPROGRAM
			  
			#pragma vertex vert  
			#pragma fragment frag

			ENDCG  
		}


	} 
	FallBack "Diffuse"
}