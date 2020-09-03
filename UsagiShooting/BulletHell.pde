/* 弾幕クラス(基底) */
abstract class BulletHell{
  
  protected ArrayList<Bullet> bulletList;  //弾リスト
  
  //**コンストラクタ
  BulletHell(){
    bulletList = new ArrayList<Bullet>();
  }
  
  //**弾幕を描画
  abstract void draw(int status);
  
  //**描画処理
  void drawBulletHell(){
    if(bulletList.size() != 0){
      for(Bullet b :bulletList){
        b.updateLocation();
        b.draw();
      }
    }
  }
  
  //**自機への当たり判定
  boolean isHitToPlayer(Player player){
    for(Bullet b : bulletList){
      if(b.isHitToPlayer(player)){
        return true;
      }
    }
    return false;
  }
  
  //**画面外に出た弾を消去
  void deleteBullet(){
    for(int i=0; i<bulletList.size(); i++){
      if(bulletList.get(i).isOutOfScreen()){
        bulletList.remove(i);
      }
    }
  }
  
  //**弾幕を全消去
  void deleteAllBullet(){
    bulletList.clear();
  }

  /*getter,setter*/
  ArrayList<Bullet> getBulletList(){
    return bulletList;
  }
  
}

/*------------------------------------------------------------*/
/* 全方位弾幕クラス */
//本当は弾種類をコンストラクタ経由でカスタマイズできるようにして、全方位弾なら全部このクラス使えるようにしたい。。
//リフレクションが前うまく使えなかったのよね。。
class AllRoundBullletHell extends BulletHell{
  
  private int num;  //弾数
  PVector enemyLocation;  //敵機位置
  
  //**コンストラクタ
  AllRoundBullletHell(int num,PVector enemyLocation){
    super();
    this.num = num;
    this.enemyLocation = enemyLocation;
  }
  
  //**弾幕を描画
  void draw(int status){
      
    float angle;         //弾幕の角度
    float velocity = 3;  //弾幕の速度
    
    //1秒毎に弾インスタンスを生成する(敵機がアクティブの場合)
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%60 == 0){
      for(int i=0; i<num;i++){
        angle = 2*PI/num * (i+1);
        //小弾：始点位置は敵機の座標、向きは全方位
        bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                                        ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                                        ,null));         
      }
    }
     
    //描画
    drawBulletHell();
    
    //画面外に出た弾のインスタンス削除
    deleteBullet();

  }
  
}

/*------------------------------------------------------------*/
/* 自機狙い弾幕クラス */
class TargetingBulletHell extends BulletHell{
    PVector enemyLocation;  //敵機位置
    PVector playerLocation;  //自機位置

  //**コンストラクタ
  TargetingBulletHell(PVector enemyLocation,PVector playerLocation){
    super();
    this.enemyLocation = enemyLocation;
    this.playerLocation = playerLocation;
  }
   
  //**弾幕を描画
  void draw(int status){
    
    float angle;         //弾幕の角度
    float velocity = 6;  //弾幕の速度
    
    float enemyY;
    float enemyX;
    float playerY;
    float playerX;
    
    //一定間隔で弾インスタンスを生成する(敵機がアクティブの場合)
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%20 == 0){
      enemyY = enemyLocation.y;
      enemyX = enemyLocation.x;
      playerY = playerLocation.y;
      playerX = playerLocation.x;
      angle = atan2(playerY - enemyY,playerX - enemyX);  
      //小弾：始点位置は敵機の座標、向きは自機の位置
      bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                      ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                      ,null));
    }
    
    //描画
    drawBulletHell();
    
    //画面外に出た弾のインスタンス削除
    deleteBullet();

  }

}

/*------------------------------------------------------------*/
/* ランダム落下水滴弾幕クラス */
class WaterDropBulletHell extends BulletHell{
  PVector enemyLocation;  //敵機位置

  //**コンストラクタ
  WaterDropBulletHell(PVector enemyLocation){
    super();
    this.enemyLocation = enemyLocation;
  }
  
  //**弾幕を描画
  void draw(int status){
    
    float angle;         //弾幕の角度
    float velocity = 2.5;  //弾幕の速度
    
    //一定間隔で弾インスタンスを生成する(敵機がアクティブの場合)
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%3 == 0){
      angle = random(2*PI);
      //小弾：始点位置は敵機の座標、向きはランダム、重力あり
      bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                      ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                      ,new PVector(0.0,1.0)));
      
    }
    
    //描画
    drawBulletHell();
    
    //画面外に出た弾のインスタンス削除
    deleteBullet();
    
  }
 
}
