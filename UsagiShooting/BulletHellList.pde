/*------------------------------------------------------------*/
/* 弾タイプ */
/*------------------------------------------------------------*/
/* 全方位弾幕 */
class AllRoundBullletHell extends BulletHell{
  
  private int num;  //弾数
  PVector enemyLocation;  //敵機位置
  
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
    color col = color(98,216,198);
        
    //1秒毎に弾幕を生成する(敵機がアクティブの場合)
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%60 == 0){
      for(int i=0; i<num;i++){
        angle = 2*PI/num * (i+1);
        switch(bulletType){
          case Const.BULLET_TYPE_SMALL:
            bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                                            ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                                            ,null,col));
            break;
          case Const.BULLET_TYPE_LARGE:
            bulletList.add(new LargeBullet(new PVector(enemyLocation.x,enemyLocation.y)
                                            ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                                            ,null,col));
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
/* 自機狙い弾幕 */
class TargetingBulletHell extends BulletHell{
    PVector enemyLocation;  //敵機位置
    PVector playerLocation;  //自機位置
    color col = color(199,165,204);
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
                      ,null,col));
    }
    
    //描画
    drawBulletHell();
    
    //画面外に出た弾のインスタンス削除
    deleteBullet();

  }

}

/*------------------------------------------------------------*/
/* ランダム発射弾幕 */
class RandomBulletHell extends BulletHell{
  PVector enemyLocation;  //敵機位置
  int interval;  //発射間隔
  color col = color(98,216,198);

  RandomBulletHell(PVector enemyLocation,String bulletType,int interval){
    super();
    this.enemyLocation = enemyLocation;
    this.bulletType = bulletType;
    this.interval = interval;
  }
  
  //**弾幕を描画
  void draw(int status){
    
    float angle;         //弾幕の角度
    float velocity = 2.5;  //弾幕の速度
    
    //一定間隔で弾幕生成(敵機がアクティブの場合)
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%interval == 0){
      angle = random(2*PI);
      switch(bulletType){
        case Const.BULLET_TYPE_SMALL :
          bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y)
                          ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                          ,new PVector(0.0,1.0),col));
          break;
        case Const.BULLET_TYPE_LARGE :
          bulletList.add(new LargeBullet(new PVector(enemyLocation.x,enemyLocation.y)
                          ,new PVector(cos(angle)*velocity,sin(angle)*velocity)
                          ,new PVector(0.0,1.0),col));
          break;
      }
    }
    
    //描画
    drawBulletHell();
    
    //画面外に出た弾のインスタンス削除
    deleteBullet();
    
  }
 
}

/*------------------------------------------------------------*/
/* 落下弾幕 */
class FallBulletHell extends BulletHell{
  color col = color(98,216,198);
  FallBulletHell(){
    super();
  }
  
  //**弾幕を描画
  void draw(int status){
     if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%10 == 0){
       bulletList.add(new LargeBullet(new PVector(random(width),0),new PVector(0,0),new PVector(0,2),col));
     }
    //描画
    drawBulletHell();
    //画面外に出た弾のインスタンス削除
    deleteBullet();   
  }
  
}

/*------------------------------------------------------------*/
/* レーザー型弾幕 */
class LaserLikeBulletHell extends BulletHell{
  PVector enemyLocation;  //敵機位置
  float angle;  //発射角度
  float vector;  //速度
  color col = color(98,216,198);
  
  LaserLikeBulletHell(PVector enemyLocation,float angle){
    super(); 
    this.enemyLocation = enemyLocation;
    this.angle = angle;
    this.vector = 4.0;
  }
  
  //**弾幕を描画
  void draw(int status){
    if(status == Const.STATUS_ENEMY_ACTIVE && frameCount%4 == 0){
      bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y),new PVector(cos(angle)*vector,sin(angle)*vector),null,col));
    }
    //描画
    drawBulletHell();
    //画面外に出た弾のインスタンス削除
    deleteBullet();   
  }
  
}
/*------------------------------------------------------------*/
/* らせん放射型弾幕 */
class HelixBulletHell extends BulletHell{
  PVector enemyLocation;
  float angle = PI/2;
  float angleAdd;
  float vector;
  
  HelixBulletHell(PVector enemyLocation,String bulletType,float angleAdd){
    super();
    this.bulletType = bulletType;
    this.enemyLocation = enemyLocation;
    this.angleAdd = angleAdd;
    vector = 4;
  }
  
  //**弾幕を描画
  void draw(int status){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      angle += angleAdd;
      if(angle>2*PI){ angle -= 2*PI; }
      println("らせん angle = " + degrees(angle));
      switch(bulletType){
        case Const.BULLET_TYPE_SMALL:
          bulletList.add(new SmallBullet(new PVector(enemyLocation.x,enemyLocation.y),new PVector(cos(angle)*vector,sin(angle)*vector),null,color(98,216,198)));
          break;
        case Const.BULLET_TYPE_LARGE:
          bulletList.add(new LargeBullet(new PVector(enemyLocation.x,enemyLocation.y),new PVector(cos(angle)*vector,sin(angle)*vector),null,color(98,216,198)));
          break;
      }
    }
    drawBulletHell();
    deleteBullet();
  }

}

/*------------------------------------------------------------*/
/* ハート型弾幕 */
class HeartBulletHell extends BulletHell{
  PVector enemyLocation;
  float x;
  float y;
  float xFormula;
  float yFormula;
  color col = color(241,141,158);
  int myFrameCount;
  
  HeartBulletHell(PVector enemyLocation){
    super();
    this.enemyLocation = enemyLocation;
    myFrameCount = frameCount-70;
  }
  
  //**弾幕を描画
  void draw(int status){
    //弾幕生成
    int interval = int(random(90,131));
    if(frameCount - myFrameCount >= interval){  
      myFrameCount = frameCount;
      for (int i = 0; i < 360; i+=5) {
        xFormula = (16 * sin(radians(i)) * sin(radians(i)) * sin(radians(i)));
        yFormula = (13 * cos(radians(i)) - 5 * cos(radians(2 * i)) - 2 * cos(radians(3 * i)) - cos(radians(4 * i))) * (-1);
        x = 5 * xFormula + enemyLocation.x;
        y = 5 * yFormula + enemyLocation.y;
        bulletList.add(new SmallBullet(new PVector(x,y),new PVector(xFormula*0.1,yFormula*0.1),null,col));
      }
    }
    //描画
    drawBulletHell();
    //画面外に出た弾のインスタンス削除
    deleteBullet(); 
  }
}

/*------------------------------------------------------------*/
/* バウンド弾幕 */
/*(現状、スペカ用にある程度シナリオ化された動きをする。より自由に、雑魚的用に使いたい場合は別クラスを用意するなど考える) */
class BoundBulletHell extends BulletHell{
  float angle;
  int colNo;
  color col[] = {color(98,216,198),color(241,141,158),color(235,223,0)};
  
  BoundBulletHell(){
    super();
  }

  //**弾幕を描画
  void draw(int status){
    //弾幕生成、バウンド処理
    if(frameCount%120 == 0){
      for(int i=0; i<5; i++){
        //初期位置、進行方向はランダム
        angle = random(2*PI);
        colNo = int(random(0,3));
        if(colNo == 3){ colNo = 2; }
        bulletList.add(new SmallBullet(new PVector(random(0,width),random(Const.HEIGHT_INFO,400)),new PVector(cos(angle)*2.5,sin(angle)*2.5),null,col[colNo]));
      }
    }
    bound();
    
    //描画
    drawBulletHell();
    //画面外に出た弾のインスタンス削除
    deleteBullet();     
  }
  
  //**バウンド処理
  void bound(){
    for(Bullet b : bulletList){
      if(b.getBoundNum() >= 3){ continue; }
      float locationX = b.getLocation().x;
      float locationY = b.getLocation().y;
      float velocityX = b.getVelocity().x;
      float velocityY = b.getVelocity().y;
      if(locationX <= (0 + Const.SMALLBULLET_DIAMETER/2) || locationX >= (width - Const.SMALLBULLET_DIAMETER/2)){
        velocityX *= -1;
        b.countBoundNum();
      }
      if(locationY <= (Const.HEIGHT_INFO + Const.SMALLBULLET_DIAMETER/2) || locationY >= (height - Const.SMALLBULLET_DIAMETER/2)){
        velocityY *= -1;
        b.countBoundNum();
      }
      b.setVelocity(new PVector(velocityX,velocityY));
    }
  }
  
  
}

/*------------------------------------------------------------*/
/* レーザータイプ */
/*------------------------------------------------------------*/
/* 放射レーザー弾幕クラス */
class AllRoundLaserBulletHell extends BulletHell{
  PVector enemyLocation;  //敵機位置
  int num;      //レーザー本数
  float laserLen;  //レーザー長さ
  int rotateFlg;  //回転フラグ
  color col = color(98,216,198);
  
  float rotateCnt = 0.0;  //回転係数
  
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
                                    ,laserRange
                                    ,Const.LASER_PRE_TIME_NORMAL,col));
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
/* 全体レーザー弾幕クラス */
class WideLaserBulletHell extends BulletHell{
  
  int num;      //レーザー本数
  float laserRange;  //レーザー幅
  int myFrameCount;  //インスタンス生成時のフレームカウント
  color col = color(72,151,216);
  
  //**コンストラクタ
  WideLaserBulletHell(float laserRange,int num){
    super();
    this.num = num;
    this.laserRange = laserRange;
    this.myFrameCount = frameCount;
  }
  
  //**弾幕を描画
  void draw(int status){
    //レーザーを消す
    if((frameCount-myFrameCount)%600 == 0){
      laserList.clear();
      return;
    }
    //レーザーを一定時間毎に作成
    if((frameCount-myFrameCount)%300 == 0){
      //myFrameCount = frameCount;
      for(int i=0; i<num; i++){
        float p = height/num * i + Const.HEIGHT_INFO;
        if(i%2 != 0){
          laserList.add(new NormalLaser(new PVector(0,p),new PVector(width,random(p-150,p+150)),laserRange,Const.LASER_PRE_TIME_LONG,col));
        }else{
          laserList.add(new NormalLaser(new PVector(0,random(p-150,p+150)),new PVector(width,p),laserRange,Const.LASER_PRE_TIME_LONG,col));
        }
      }
    }
    //描画
    drawBulletHell();
  }
  
}
