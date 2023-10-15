class Hoop{
  PVector pos;
  
  PImage hoop_texture;
  PShape hoop;
  
  Hoop(float x, float y, float z){
    pos = new PVector(x, y, z);
    hoop_texture = loadImage("hoop_texture.png");
    hoop = createShape(BOX, 150);
    textureWrap(REPEAT);
    hoop.setTexture(hoop_texture);      
  }
  
  void display() {
     pushMatrix();
     translate(pos.x, pos.y, pos.z);
     shape(hoop);
     popMatrix();
 }
  
  
}
