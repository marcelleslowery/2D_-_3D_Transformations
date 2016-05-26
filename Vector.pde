//Vector class

class Vector {
  float[] v; 
  
  //new vector
  Vector(float x, float y, float z) {
    v = new float[4];
    v[0] = x;
    v[1] = y;
    v[2] = z;
    v[3] = 1;
  }
  
  //cross product function
  Vector cross(Vector B) {
    Vector C = new Vector(this.v[1]*B.v[2] - this.v[2]*B.v[1],
                          this.v[2]*B.v[0] - this.v[0]*B.v[2],
                          this.v[0]*B.v[1] - this.v[1]*B.v[0]);
    
    return C;
  }
  //makes a normal vertex
  void normalize() {
    float len = sqrt(this.v[0]*this.v[0] + this.v[1]*this.v[1] + this.v[2]*this.v[2]);
    for(int i=0; i< 3; i++) {
      this.v[i]/=len;
    }
  }
  
  // multiples a vertex and a matrix
  void vertMult(Matrix curr) {
    float x = (float)curr.m[0][0]*this.v[0] + (float)curr.m[0][1]*this.v[1] + (float)curr.m[0][2]*this.v[2] + (float)curr.m[0][3];
    float y = (float)curr.m[1][0]*this.v[0] + (float)curr.m[1][1]*this.v[1] + (float)curr.m[1][2]*this.v[2] + (float)curr.m[1][3];
    float z = (float)curr.m[2][0]*this.v[0] + (float)curr.m[2][1]*this.v[1] + (float)curr.m[2][2]*this.v[2] + (float)curr.m[2][3];
    
    this.v[0] = x;
    this.v[1] = y;
    this.v[2] = z;
  }
}