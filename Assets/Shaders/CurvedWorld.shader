Shader "Custom/CurvedWorld"
{
  Properties
  {
    _MainTex ("Texture", 2D) = "white" { }
  }
	
  SubShader
  {
    Tags { "RenderType" = "Opaque" }
    LOD 200
    Pass
    {
      CGPROGRAM
      
      #pragma vertex vert
      #pragma fragment frag
			#pragma target 3.0
      #include "UnityCG.cginc"
      
      // vertex input: position, color
      struct appdata
      {
        float4 vertex: POSITION;
        fixed4 uv: TEXCOORD0;
      };
      
      
      struct v2f
      {
        float4 pos: SV_POSITION;
        float2 uv: TEXCOORD0;
      };
      
      uniform float _Curvature;
      float4 _MainTex_ST;
      
      v2f vert(appdata v)
      {
        v2f o;
        o.pos = v.vertex;
        o.uv = TRANSFORM_TEX(v.uv, _MainTex);
        float4 pos = mul(unity_ObjectToWorld, o.pos);
        pos.xyz -= _WorldSpaceCameraPos.xyz;
        pos = float4(0, (pos.z * pos.z) * - .05, 0, 0);
        o.pos += mul(unity_WorldToObject, pos);
        o.pos = UnityObjectToClipPos(o.pos);
        return o;
      }
      
      sampler2D _MainTex;
      
      fixed4 frag(v2f i): SV_Target
      {
        return tex2D(_MainTex, i.uv);
      }
      ENDCG
      
    }
  }
}