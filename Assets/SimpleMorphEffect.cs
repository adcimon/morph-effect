using UnityEngine;

public class SimpleMorphEffect : MonoBehaviour
{
    public enum MorphType { None = 0, Cube = 1, Sphere = 2 }

    public MorphType morphType = MorphType.None;

    public float size = 1;

    [Range(0, 1)]
    public float blendFactor = 0;

    public float offsetFactor = 4;

    private Material material;

    private void Awake()
    {
        material = gameObject.GetComponent<Renderer>().material;
    }

    private void OnValidate()
    {
        if( material == null )
        {
            return;
        }

        material.SetFloat("_Mode", (int)morphType);
        material.SetFloat("_Size", size);
        material.SetFloat("_BlendFactor", blendFactor);
        material.SetFloat("_OffsetFactor", offsetFactor);
    }
}