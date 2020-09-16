/*画像*/
class Image{
  PImage playerImg;
  PImage bossImg;
  
  Image(){
    playerImg = loadImage("graphic/player.png");
    bossImg = loadImage("graphic/boss.png");
  }
  
  //**自機グラ描画
  void drawPlayerImage(PVector location){
    float x = location.x - Const.PLAYER_GRAPHIC_WIDTH/2;
    float y = location.y - Const.PLAYER_GRAPHIC_HEIGHT*2/3;
    image(playerImg,x,y);
  }
  
  //**ボスグラ描画
  void drawBossImage(PVector location){
    float x = location.x - Const.BOSS_GRAPHIC_WIDTH/2;
    float y = location.y - Const.BOSS_GRAPHIC_HEIGHT*2/3;
    image(bossImg,x,y);
  }
  
}
