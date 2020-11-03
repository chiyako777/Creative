/*タイトル画面描画*/
class Title{
  
  PVector[] location;
  float[] size;
  color[] col;
  
  Title(){
    location = new PVector[6];
    for(int i=0;i<6;i++){
      location[i] = new PVector(0,0);
    }
    size = new float[6];
    col = new color[6];
  }
  
  //**タイトル画面を再生
  void drawTitle(){
    /*背景描画*/
    
    noStroke();
    /*円状に星を描く*/
    for(int i=0; i<6; i++){
      fill(col[i]);
      pushMatrix();
      //描画位置をランダム生成
      translate(location[i].x,location[i].y);
      //星を描画
      int num = 12;
      for(int j = 0; j < num; j++){
        float ox = 180 * cos(radians(j * 360/num));
        float oy = 180 * sin(radians(j * 360/num));        
        drawStar(ox,oy,floor(size[i]),5);  //<>//
      }
      popMatrix();
    }
    
    /*メッセージ描画*/
    fill(255);
    textSize(30);
    text("pless any key...",50,370);
  }
  
  //**初期化(背景描画用)
  void init(){
    for(int i=0; i<6; i++){
      location[i].x = random(600);
      location[i].y = random(100,750);
      size[i] = random(30,120);
    }
    
    col[0] = color(124,252,0,50);
    col[1] = color(255,228,225,50);
    col[2] = color(0,172,154,50);
    col[3] = color(255,220,0,50);
    col[4] = color(255,255,255,50);
    col[5] = color(234,85,80,50);
    
    //println(""); //<>//
  }
  

/*----------------------------------------------------------------------------------------------------*/
/*描画関数（いずれ共通化する）*/
/*----------------------------------------------------------------------------------------------------*/

  /*星を描く*/
  /*ox,oy:中心座標、r:中心点とトゲの頂点までの距離、vertexNum:頂点(星のトゲ)数*/
  void drawStar(float ox,float oy,int r,int vertexNum){
  
    pushMatrix();
    translate(ox,oy);
    rotate(radians(-90));  //角度をずらして一番上の部分を初期位置とする
    
    beginShape();
    //星を構成する点を1°ずつ定義していって、線分でつなぐ
    for(int theta = 0; theta < 360; theta++){
      PVector pos = calcPos(r,theta,vertexNum);
      float x = pos.x;
      float y = pos.y;
      vertex(x,y);
    }
    endShape(CLOSE);
    
    popMatrix();
  }
  
  /* 各頂点座標を計算 */
  /* r:中心点と頂点間の距離、theta:0～359、num:頂点数*/
  PVector calcPos(int r,int theta,int num){
    float x = r * cos(radians(theta)) * func(theta,num);
    float y = r * sin(radians(theta)) * func(theta,num);
    //println("theta = " + theta + " : x = " + x + " : y = " + y);
    return new PVector(x,y);
  }
  
  /*theta:0～359、num:頂点数*/
  float func(int theta, int num){
    float a = 360/num;
    float A = cos(radians(a));
    float b = acos(cos(radians(num * theta)));    //acos:逆関数　これを使ってnum*tが360を超えている場合は360の範囲内に収めることができる
    float B = cos(radians(a) - b / num);
    
    return A/B;
  }
  

}
