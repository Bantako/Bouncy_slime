import java.util.*;
//import com.rits.*;

final int BLOCK_SIZE = 40;
final int CANDY_SIZE = 24;
Candy[] candy = new Candy[CANDY_SIZE];
BlockController blockController;
Slime slime;
void setup() {
  size(800, 600);//4:3
  frameRate(60);
  for(int i = 0;i < CANDY_SIZE;i++){
    float vx = random(-4,4);
    float vy = random(-4,4);
    //println(vx);
    candy[i] = new Candy(400, 300, vx, vy, 12, color(255,0,0) );
  }
  
  blockController = new BlockController(width/BLOCK_SIZE, height/BLOCK_SIZE, color(60, 180, 220), 4);
  slime = new Slime(new PVector(random(0,width), random(0,height)), 5, color(0,240,60), 16);
}
void draw() {

  background(0);
  /*
  for(int i = 0;i < CANDY_SIZE;i++){
    candy[i].move();
    candy[i].draw();
  }
  */
  println("drawing !!");
  blockController.update();
  slime.move();
  slime.draw();
}

class BlockController{
  Block[][] blockList;
  int wsize, hsize;
  int weight;
  color c;
  BlockController(int w, int h, color c, int weight){
    println(w,h);
    this.wsize = w;
    this.hsize = h;
    this.c = c;
    this.weight = weight;
    blockList = new Block[w][h];
    for(int i = 0;i < wsize;i++){
      for(int j = 0;j < hsize;j++){
        blockList[i][j] = new Block(new PVector(i * BLOCK_SIZE, j * BLOCK_SIZE), this.c, this.weight);  
      }
    }
  }
  void update(){
    for(int i = 0;i < wsize;i++){
      for(int j = 0;j < hsize;j++){
        blockList[i][j].draw();
      }
    }
  }
}
class Block{
  PVector pos;
  color c;
  boolean isBroken = false;
  int weight;
  Block(PVector p, color c, int weight){
    this.pos = p;
    this.c = c;
    this.weight = weight;
  }
  void draw(){
    //println(pos.x, pos.y);
    //println(c);
    fill(c);
    strokeWeight(weight);
    rect(this.pos.x, this.pos.y, BLOCK_SIZE, BLOCK_SIZE, 12);
  }
}
class Slime{
  PVector pos;//position
  PVector vel;//velocity
  float speed;//velocity size
  float r;//radius
  color c;//slime color
  float dx[] = {1, -1, 0, 0};
  float dy[] = {0, 0, 1, -1};
  int dir;
  Slime(PVector pos, float speed, color c, float r){
    this.pos = pos;
    this.speed = speed;
    this.r = r;
    this.c = c;
    dir = 0;
    //vel = new PVector(dx[dir], dy[dir]);
    
  }
  void move(){
    vel = new PVector(dx[dir], dy[dir]).mult(speed);
    PVector next = new PVector(this.pos.x, this.pos.y);
    next.add(vel);
    println("move", pos, next);
    if(!judge(next)){
      this.reverse();
    }
    vel = new PVector(dx[dir], dy[dir]).mult(speed);
    pos.add(vel);
  }
  void reverse(){
     //ArrayList<PVector> candidate = new ArrayList<PVector>();
     ArrayList<Integer> candidate = new ArrayList<Integer>();
     for(int i = 0;i < 4;i++){
       PVector next = this.pos;
       next.add(new PVector(dx[i], dy[i]).mult(speed));
       if(judge(next)){
         candidate.add(i);
       }       
     }
     dir = candidate.get((int)random(0,candidate.size()) );
  }
  boolean judge(PVector p){
    return !(p.x < 0 || p.x > width || p.y < 0 || p.y > height);
  }
  void draw(){
    //println("slime!");
    println(pos, r);
    fill(c);
    ellipse(pos.x, pos.y, r, r);
  }
}