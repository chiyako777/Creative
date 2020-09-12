
/*------------------------------------------------------------*/
/* 全方位弾幕クラス */
class AllRoundBullletHell extends BulletHell{
  
  private int num;  //弾数
  private String bulletType;  //弾種
  PVector enemyLocation;  //敵機位置
  
    
  //**コンストラクタ
  AllRoundBullletHell(int num,String bulletType,PVector enemyLocation){
    super();
    this.num = num;
    this.bulletType = bulletType;
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
        switch(bulletType){
          case Const.BULLET_TYPE_SMALL:
            bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                                            ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                                            ,null));
            break;
          case Const.BULLET_TYPE_LARGE:
            bulletList.add(new LargeBullet(new PVector(enemyLocation.x,enemyLocation.y)
                                            ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                                            ,null));
            break;
        }
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

/*------------------------------------------------------------*/
/* 放射レーザー弾幕クラス */
class AllRoundLaserBulletHell extends BulletHell{
  PVector enemyLocation;  //敵機位置
  int num;      //レーザー本数
  float laserLen;  //レーザー長さ
  int rotateFlg;  //回転フラグ
  
  float rotateCnt = 0.0;  //回転係数
  

  //**コンストラクタ
  AllRoundLaserBulletHell(PVector enemyLocation,float laserRange,int num,float laserLen,int rotateFlg){
    super();
    this.enemyLocation = enemyLocation;
    this.num = num;
    this.laserLen = laserLen;
    this.rotateFlg = rotateFlg;
    
    //レーザー生成(※途中での生成はないものとする)
    for(int i=0;i<this.num;i++){
      float angle = (2*PI/this.num) * i;
      laserList.add(new NormalLaser(new PVector(this.enemyLocation.x,this.enemyLocation.y)
                                    ,new PVector((cos(angle)*this.laserLen)+this.enemyLocation.x,(sin(angle)*this.laserLen)+this.enemyLocation.y)
                                    ,laserRange));
    }
    
  }

  //**弾幕を描画
  void draw(int status){
    
    float angle = 0.0;  //回転角度
    float addAngle = 0.0;//回転角度増分
    boolean angleUpdateFlg = false;  //角度更新フラグ
    
    //*回転なし
    if(rotateFlg == Const.LASER_ROTATE_OFF){
      drawBulletHell();
      return;
    }
    
    //*回転あり
    for(int i=0;i<num;i++){
      Laser l = laserList.get(i);
      if(l.getStatus() == Const.LASER_STATUS_SHOOT){
        angleUpdateFlg = true;
        //角度を回転させる
        addAngle = (2*PI/360) * rotateCnt;
        if(rotateFlg == Const.LASER_ROTATE_CLOCKWISE){
          angle = (2*PI/num) * i + addAngle;
        }else if(rotateFlg == Const.LASER_ROTATE_COUNTER_CLOCKWISE){
          angle = (2*PI/num) * i - addAngle;
        }
        //レーザーの終点位置を更新
        l.setEndPoint(new PVector((cos(angle)*this.laserLen)+this.enemyLocation.x,(sin(angle)*this.laserLen)+this.enemyLocation.y));
      }
    }
    
    drawBulletHell();
    if(angleUpdateFlg){
      //回転分の角度を更新(1フレームで0.1°回転)
      rotateCnt = ( rotateCnt >= 360 ? 0 : rotateCnt + 0.1);
    }
    
  }
    
}

/*------------------------------------------------------------*/
/* リニアクリーチャー弾幕クラス */
class LinearCleatureBulletHell extends BulletHell{

  //**コンストラクタ
  LinearCleatureBulletHell(){
    super();
    
  }
  
  //**弾幕を描画
  void draw(int status){
    
  }
}
