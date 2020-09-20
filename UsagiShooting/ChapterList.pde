/*------------------------------------------------------------*/
/*チャプター1*/
class Chapter1 extends Chapter{
  
  Chapter1(){
    super();
    chapterNo = 1;
  }

  //**敵を生成
  void createEnemy(Player player){
    //全方位弾敵*3
    enemyList.add(new Enemy001(120.0,new PVector(width/2,0.0),new PVector(0.0,2.0),480,Const.BULLET_TYPE_SMALL,true,false));
    enemyList.add(new Enemy001(120.0,new PVector(width/4,0.0),new PVector(0.0,2.0),480,Const.BULLET_TYPE_SMALL,true,false));
    enemyList.add(new Enemy001(120.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),480,Const.BULLET_TYPE_SMALL,true,false));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music,Image img){

    /*★★シナリオ概要：全方位弾*3 撃破したら次の敵機が出てくる★★*/
    execNormalSenario(player,music,img);
    
  }

}

/*------------------------------------------------------------*/
/*チャプター2*/
class Chapter2 extends Chapter{
  
  Chapter2(){
    super();
    chapterNo = 2;
  }

  //**敵を生成
  void createEnemy(Player player){
    //自機狙い弾敵*3
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true,false));
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(width,100.0),new PVector(-3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true,false));
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true,false));
    //ランダム弾*3
    enemyList.add(new Enemy003(180.0,new PVector(width/2,0.0),new PVector(0.0,2.0),720,Const.BULLET_TYPE_LARGE,true,false,6));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),720,Const.BULLET_TYPE_LARGE,true,false,6));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),720,Const.BULLET_TYPE_LARGE,true,false,6));
  }

  //**チャプターシナリオを実行
  void exec(Player player,Music music,Image img){

    /*★★シナリオ概要：自機狙い弾敵*3+ランダム弾*3 画面アウトしたら次の敵が出てくる★★*/
    execNormalSenario(player,music,img);
  }
  
}

/*------------------------------------------------------------*/
/*チャプター3*/
class Chapter3 extends Chapter{

  Chapter3(){
    super();
    chapterNo = 3;
  }

  //**敵を生成
  void createEnemy(Player player){
    //放射レーザー*2
    enemyList.add(new Enemy004(
                        Const.HP_ENEMY_INVALID
                        ,new PVector(width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_COUNTER_CLOCKWISE
                        ,180
                        ,false
                        ,false));
    enemyList.add(new Enemy004(
                        Const.HP_ENEMY_INVALID
                        ,new PVector(7*width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_CLOCKWISE
                        ,180
                        ,false
                        ,false));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music,Image img){
    execAtOnceSenario(player,music,img);
  } 
  
}

/*------------------------------------------------------------*/
/*チャプター4*/
class Chapter4 extends Chapter{
  
  Chapter4(){
    super();
    chapterNo = 4;
  }

  //**敵を生成
  void createEnemy(Player player){
    //放射レーザー
    enemyList.add(new Enemy004(
                        Const.HP_ENEMY_INVALID
                        ,new PVector(width/2,100.0)
                        ,new PVector(0.0,0.0)
                        ,9
                        ,Const.LASER_ROTATE_OFF
                        ,600
                        ,false
                        ,false));
    //ランダム弾*2                    
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),600,Const.BULLET_TYPE_SMALL,true,false,3));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),600,Const.BULLET_TYPE_SMALL,true,false,3));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music,Image img){
    execAtOnceSenario(player,music,img);
  }  
  
}

/*------------------------------------------------------------*/
/*チャプター5*/
class Chapter5 extends Chapter{

  Chapter5(){
    super();
    chapterNo = 5;
  }
  
  //**敵を生成
  void createEnemy(Player player){
    for(int i=0; i<20; i++){
      enemyList.add(new Enemy005(Const.HP_ENEMY_INVALID,new PVector(random(width),random(Const.HEIGHT_INFO,250)),new PVector(0,1),60,PI/2,true,false));
    }
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music,Image img){
    execConstantSenario(player,music,30,img);
  }
  
}

/*------------------------------------------------------------*/
/*チャプター6(新しく作った弾幕とりあえずここに)*/
class Chapter6 extends Chapter{

  Chapter6(){
    super();
    chapterNo = 6;
  }
  
  //**敵を生成
  void createEnemy(Player player){
    enemyList.add(new Enemy006(90,new PVector(width/2,0.0),new PVector(0,2),480,Const.BULLET_TYPE_SMALL,true,false,radians(22)));
    enemyList.add(new Enemy006(90,new PVector(width/4,0.0),new PVector(0,2),480,Const.BULLET_TYPE_SMALL,true,false,radians(22)));
    enemyList.add(new Enemy006(90,new PVector(3*width/4,0.0),new PVector(0,2),480,Const.BULLET_TYPE_SMALL,true,false,radians(22)));
    //複数らせん(角度増分3°、発射間隔1、放射数5、転換あり、転換間隔20
    //enemyList.add(new Enemy007(90,new PVector(width/2,100.0),new PVector(0,2),Const.TIMEOUT_ENEMY_INVALID,Const.BULLET_TYPE_SMALL,true,false,radians(3),1,4,true,20));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music,Image img){
    execNormalSenario(player,music,img);
  }
  
}

/*------------------------------------------------------------*/
/*ボス戦*/
class BossChapter extends Chapter{

  BossChapter(){
    super();
    chapterNo = 5;
  }

  //**敵を生成
  void createEnemy(Player player){
    //enemyList.add(new Boss001(1200,new PVector(width/2,100),new PVector(0,0),3600,false,true));
    enemyList.add(new Boss002(300,new PVector(width/2,250),new PVector(0,0),1800,false,true));
    enemyList.add(new Boss003(600,new PVector(width/2,100),new PVector(0,0),3600,false,true));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music,Image img){
    execNormalSenario(player,music,img);
  }  
  
}
