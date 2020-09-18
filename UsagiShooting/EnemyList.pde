
/*------------------------------------------------------------*/
/*敵機タイプ①　丸型敵機:全方位弾射出*/
class Enemy001 extends Enemy{

  Enemy001(float hp,PVector location,PVector direction,int timeout,String bulletType,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    bulletHellList.add(new AllRoundBullletHell(20,bulletType,this.location));
  }
  
  //**敵機の位置を更新
  void updateLocation(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      if(location.y < 100){
        location.add(direction);    
      }
    }
  }

  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      noStroke();
      ellipse(location.x,location.y,20,20);
      activeTime += 1;
    }
  }
  
}

/*------------------------------------------------------------*/
/*敵機タイプ②　丸型敵機:自機狙い弾射出　*/
class Enemy002 extends Enemy{

  Enemy002(float hp,PVector location,PVector direction,PVector playerLocation,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    //自機狙い弾幕生成(敵機位置、自機位置)
    bulletHellList.add(new TargetingBulletHell(this.location,playerLocation));
  }
 
  //**敵機の位置を更新
  void updateLocation(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      location.add(direction);
    }
  }
  
  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      noStroke();
      ellipse(location.x,location.y,20,20);
      activeTime += 1;
    }
  }
  
}

/*------------------------------------------------------------*/
/*敵機タイプ③　丸型敵機:ランダム水滴弾射出　*/
class Enemy003 extends Enemy{

  Enemy003(float hp,PVector location,PVector direction,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    //ランダム水滴弾幕生成(敵機位置)
    bulletHellList.add(new RandomBulletHell(this.location));
  }

  //**敵機の位置を更新
  void updateLocation(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      if(location.y < 100){
        location.add(direction);    
      }
    }
  }
  
  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      noStroke();
      ellipse(location.x,location.y,20,20);
      activeTime += 1;
    }
  }
   
}

/*------------------------------------------------------------*/
/*敵機タイプ④　放射レーザー(細)　*/
class Enemy004 extends Enemy{

  Enemy004(float hp,PVector location,PVector direction,int laserNum ,int rotateFlg,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    bulletHellList.add(new AllRoundLaserBulletHell(this.location,3,laserNum,750,rotateFlg));
  }
  
  //**敵機の位置を更新
  void updateLocation(){
    location.add(direction);
  }
  
  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      noStroke();
      ellipse(location.x,location.y,20,20);
      activeTime += 1;
    }
  }
  
}

/*------------------------------------------------------------*/
/*敵機タイプ⑤　レーザー弾幕　*/
class Enemy005 extends Enemy{
  
  Enemy005(float hp,PVector location,PVector direction,int timeout,float angle,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    //レーザー弾幕生成(敵機位置)
    bulletHellList.add(new LaserLikeBulletHell(this.location,angle));
  }

  //**敵機の位置を更新
  void updateLocation(){
    location.add(direction);
  }

  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      noStroke();
      ellipse(location.x,location.y,20,20);
      activeTime += 1;
    }
  }
 
}

/*------------------------------------------------------------*/
/*ボス敵機　スペルカード:リニアクリーチャーっぽいやつ　*/
class Boss001 extends Enemy{

  Boss001(float hp,PVector location,PVector direction,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    bulletHellList.add(new WideLaserBulletHell(3,20));
    bulletHellList.add(new FallBulletHell());
  }

  //**敵機の位置を更新
  void updateLocation(){
    location.add(direction);
  }

  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      drawBoss(img);
      activeTime += 1;
    }
  }
  
}

/*------------------------------------------------------------*/
/*ボス敵機　スペルカード:ハートエイク　*/
class Boss002 extends Enemy{

  Boss002(float hp,PVector location,PVector direction,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    bulletHellList.add(new HeartBulletHell(this.location));
  }

  //**敵機の位置を更新
  void updateLocation(){
    location.add(direction);
  }

  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      drawBoss(img);
      activeTime += 1;
    }
  }

}

/*------------------------------------------------------------*/
/*ボス敵機　スペルカード:泳ぐ鳥　*/
class Boss003 extends Enemy{
  
  boolean moveFlg;
  float angle;
  float margin = 30.0;
  
  Boss003(float hp,PVector location,PVector direction,int timeout,boolean bulletRemainFlg){
    super(hp,location,direction,timeout,bulletRemainFlg);
    range = 10.0;
    bulletHellList.add(new BoundBulletHell());
    moveFlg = false;
  }
  
  //**敵機の位置を更新
  void updateLocation(){
    //移動制御
    if(frameCount%120 == 0){
      if(moveFlg){
        direction.x = 0.0;
        direction.y = 0.0;
        moveFlg = false;
      }else{
        angle = random(2*PI);
        direction.x = cos(angle)*2;
        direction.y = sin(angle)*2;
        moveFlg = true;
      }
    }
    //画面端に行ったらバウンド(敵機グラもあるので余白を取る)
    if(frameCount%120 != 0){
      if(location.x <= 0 + margin || location.x >= width - margin){
        direction.x *= -1;
      }
      if(location.y <= Const.HEIGHT_INFO + margin || location.y >= 2*height/3){  //あまり下へはいかないように
        direction.y *= -1;
      }
    }
    //位置更新
    location.add(direction);
  }
  
  //**敵機を描画
  void draw(Image img){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      drawBoss(img);
      activeTime += 1;
    }
  }
  
}
