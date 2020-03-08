using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RoundWorld : MonoBehaviour
{
    public Shader EffectShader;

    // Start is called before the first frame update
    void Start()
    {
        GetComponent<Camera>().SetReplacementShader(EffectShader, "RenderType");
    }
}
