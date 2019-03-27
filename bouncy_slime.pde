final int BLOCK_SIZE = 40;
final int CANDY_SIZE = 24;
Candy[] candy = new Candy[CANDY_SIZE];
void setup() {
  size(800, 600);//4:3
  frameRate(60);
  for(int i = 0;i < CANDY_SIZE;i++){
    float vx = random(-4,4);
    float vy = random(-4,4);
    println(vx);
    candy[i] = new Candy(400, 300, vx, vy, 12, color(255,0,0) );
  }
}
void draw() {
  background(0);
  fillRect(color(60, 180, 220) );
  for(int i = 0;i < CANDY_SIZE;i++){
    candy[i].move();
    candy[i].draw();
  }
}

void fillRect(color c){
  //stroke(r, g, b, a);
  fill(c);
  strokeWeight(2);
  for(int i = 0; i < width/BLOCK_SIZE; i++){
      for(int j = 0;j < height/BLOCK_SIZE; j++){
        rect(i * BLOCK_SIZE, j * BLOCK_SIZE, BLOCK_SIZE, BLOCK_SIZE, 8);
      }
  }
}

class Candy{
  float x, y, vx, vy;//position velocity
  float r;
  color c;

  Candy(float x, float y, float vx, float vy, float r, color c){
    this.x = x;
    this.y = y;
    this.vx = vx;
    this.vy = vy;
    this.r = r;
    this.c = c;
  }
  void move(){
    float nx = x + vx;
    float ny = y + vy;
    if(nx < 0 || nx > width){
      vx = -vx;//reverse
    }
    if(ny < 0 || ny > height){
      vy = -vy;//reverse
    }
    x += vx;
    y += vy;
      
  }
  void draw(){
    fill(c);
    ellipse(x, y, r, r);
  }
}