// CS 3451
// Dummy routines for matrix transformations.
// These are for you to write!
//Marcelles Lowery
import java.util.ArrayList;

  ArrayList<ArrayList<Matrix>> stack;
  ArrayList<Matrix> CTM;
  ArrayList<Vector> lines;
  float fov, l, r, b, t;
  boolean ortho, pers;

  void gtInitialize() {
    stack = new ArrayList<ArrayList<Matrix>>();
    CTM = new ArrayList<Matrix>();
    Matrix I = new Matrix();
    I.m[0][0] = 1; I.m[1][1] = 1; I.m[2][2] = 1; I.m[3][3] = 1;
    CTM.add(I);
    stack.add(CTM);
  }

  void gtPushMatrix() {
    ArrayList<Matrix> newCTM = new ArrayList<Matrix>();
    ArrayList<Matrix> oldCTM = stack.get(stack.size()-1);
    for(int k=0; k< oldCTM.size(); k++){
      Matrix newM = new Matrix();
      for(int i=0; i< 4; i++){
        for(int j=0; j< 4; j++){
          newM.m[i][j] = oldCTM.get(k).m[i][j];
        }
      }
      newCTM.add(newM);
    }
    CTM = newCTM;
    stack.add(CTM);
  }

  void gtPopMatrix() {
    if(stack.size() == 1) {
      System.out.println("Only one matrix in stack!");
    } else {
      stack.remove(stack.size()-1);
      CTM = stack.get(stack.size()-1);
    }
  }

  void gtOrtho(float left, float right, float bottom, float top) {
    l = left;
    r = right;
    b = bottom;
    t = top;
    
    ortho = true;
    pers = false;
  }

  void gtPerspective(float fov) {
    this.fov = fov;
    
    pers = true;
    ortho = false;
  }
  
  void gtBeginShape() {
    lines = new ArrayList<Vector>();
  }
  
  void gtEndShape() {
    int i = 0;
    while(i+1<lines.size()) { //at the end increase i by 2!!
      Vector begin = lines.get(i);
      Vector end = lines.get(i+1);
      
      draw_line(begin.v[0],begin.v[1],end.v[0],end.v[1]);
      i+=2;
    }
  }
  
  void gtVertex(float x, float y, float z) {
    Vector newLine = new Vector(x,y,z);
    for(int i=CTM.size()-1; i>=0; i--) {
      Matrix curr = CTM.get(i);
      newLine.vertMult(curr);
    }
      
    float x0 = newLine.v[0];
    float y0 = newLine.v[1];
    float z0 = newLine.v[2];
    
    if(ortho) {
      x0 = (x0 - l)*(width/(r-l));
      y0 = (y0 - b)*(height/(t-b));
    } else if(pers) {
      float rfov = radians(fov);
      float k = tan(rfov/2);
      float xPrime = x0/-z0;
      float yPrime = y0/-z0;
      
      x0 = (xPrime+k)*(width/(2*k)); 
      y0 = (yPrime+k)*(height/(2*k));
    }
    newLine.v[0] = x0;
    newLine.v[1] = y0;
    newLine.v[2] = z0;
    
    lines.add(newLine);
  }

/******************************************************************************
Transformations: These functions apply a transformation to the Current Transformation Matrix. Use the methods you wrote in the last project to do so.
******************************************************************************/

  void gtTranslate(float tx, float ty, float tz) {
    Matrix T = new Matrix();
    T.m[0][0] = 1.0;
    T.m[1][1] = 1.0;
    T.m[2][2] = 1.0;
    T.m[3][3] = 1.0;
    
    T.m[0][3] = tx;
    T.m[1][3] = ty;
    T.m[2][3] = tz;
    
    CTM.add(T);
  }

  void gtScale(float sx, float sy, float sz) {
    Matrix S = new Matrix();
    S.m[0][0] = sx;
    S.m[1][1] = sy;
    S.m[2][2] = sz;
    S.m[3][3] = 1.0;
    
    CTM.add(S);
  }

  void gtRotate(char axis, float theta) {
    Matrix R = new Matrix();
    float rtheta = radians((float)(theta));
    if(axis == 'x'){
      R.m[0][0] = 1.0;
      R.m[1][1] = cos(rtheta);
      R.m[1][2] = -sin(rtheta);
      R.m[2][1] = sin(rtheta);
      R.m[2][2] = cos(rtheta);
      R.m[3][3] = 1.0;
      //your code here
    } else if(axis == 'y'){
      R.m[0][0] = cos(rtheta);
      R.m[0][2] = sin(rtheta);
      R.m[1][1] = 1.0;
      R.m[2][0] = -sin(rtheta);
      R.m[2][2] = cos(rtheta);
      R.m[3][3] = 1.0;
      //your code here
    } else if(axis == 'z'){
      R.m[0][0] = cos(rtheta);
      R.m[0][1] = -sin(rtheta);
      R.m[1][0] = sin(rtheta);
      R.m[1][1] = cos(rtheta);
      R.m[2][2] = 1.0;
      R.m[3][3] = 1.0;
      //your code here
    } else{
      println("invalid axis!");
    }
    
    CTM.add(R);
  }

  void gtRotate(float theta, float axisX, float axisY, float axisZ) {
    Matrix R = new Matrix();
    
    Vector A = new Vector(axisX, axisY, axisZ);
    A.normalize();
    Vector N = new Vector(0,0,1);
    Vector B = A.cross(N);
    B.normalize();
    Vector C = A.cross(B);
    C.normalize();
    
    for(int i=0; i<3; i++) {
      R.m[0][i] = A.v[i];
      R.m[1][i] = B.v[i];
      R.m[2][i] = C.v[i];
    }
    R.m[3][3] = 1.0;
    
    Matrix R2 = new Matrix();
    float rtheta = radians((theta));
    R2.m[0][0] = 1.0;
    R2.m[1][1] = cos(rtheta);
    R2.m[1][2] = -sin(rtheta);
    R2.m[2][1] = sin(rtheta);
    R2.m[2][2] = cos(rtheta);
    R2.m[3][3] = 1.0;
    
    Matrix tempR = R2.mult(R.trans());
    Matrix Rprime = R.mult(tempR);
    CTM.add(Rprime);
  }