// CS 3451
//4x4 matrix class
class Matrix {
  //paste your matrix class here
  double m[][];
  
  //Matrix constructor
  //initializes a 4x4 matrix of zeros
  Matrix(){
    m = new double[4][4];
    for(int i=0; i< 4; i++){
      for(int j=0; j< 4; j++){
        m[i][j] = 0;
      }
    }
  }
  
  //returns matrix C such that C = A*B
  Matrix mult(Matrix B){
    Matrix C = new Matrix();
    for(int k=0; k< 4; k++) {
      for(int i=0; i< 4; i++) {
        for(int j=0; j< 4; j++) {
          C.m[i][k] += this.m[i][j] * B.m[j][k];
        }
      }
    }
    return C;
  }
  
  //returns a transposed matrix
  Matrix trans() {
    Matrix temp = new Matrix();
    for(int i=0; i< 4; i++){
      for(int j=0; j< 4; j++){
        temp.m[j][i] = this.m[i][j];
      }
    }
    return temp;
  }
  
  //returns a String representation of the matrix
  String print(){
    String s = "";
    for(int i=0; i< 4; i++){
      s += "[";
      for(int j=0; j< 4; j++){
        if(j<3) {
          s += (int)m[i][j] + ", ";
        } else {
          s += (int)m[i][j] + "]" + "\n";
        }
      }
    }
    //your code here
    return s;
  }
  
  //returns true if matrix is the same as B, false otherwise
  boolean equals(Matrix B){
    boolean eq = true;
    for(int i=0; i< 4; i++){
      for(int j=0; j< 4; j++){
        if(abs((float)m[i][j] - (float)B.m[i][j])>0.00001)
          eq = false;
      }
    }
    return eq;
  }
  
  //Utility function to make filling the matrix easier
  //Input: "ix" is the index in the matrix to begin filling (example, 5 would begin at row 1, col 1)
  //Input: "vals" is the array of values to place into the matrix
  //Note: fill the matrix until tne end of the matrix or the end of the vals list
  void fill(int ix, double[] vals){
    for(int i=ix; i<min(vals.length+ix, 16); i++){     
      m[i/4][i%4] = vals[i-ix];
    }
  }
}