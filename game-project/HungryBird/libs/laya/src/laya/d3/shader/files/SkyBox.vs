attribute vec4 a_Position;
uniform mat4 u_MvpMatrix;
uniform float u_Rotation;
varying vec3 v_Texcoord;


vec4 rotateAroundYInDegrees (vec4 vertex, float degrees)
{
	float angle = degrees * 3.141593 / 180.0;
	float sina=sin(angle);
	float cosa=cos(angle);
	mat2 m = mat2(cosa, -sina, sina, cosa);
	return vec4(m*vertex.xz, vertex.yw).xzyw;
}
		
void main()
{
	vec4 position=rotateAroundYInDegrees(a_Position,u_Rotation);
	gl_Position = (u_MvpMatrix*position).xyww;
	v_Texcoord=vec3(-a_Position.x,a_Position.yz);//转换坐标系
}
