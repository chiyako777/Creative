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
    enemyList.add(new Enemy001(240.0,new PVector(width/2,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL,true));
    enemyList.add(new Enemy001(240.0,new PVector(width/4,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL,true));
    enemyList.add(new Enemy001(240.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL,true));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music){

    /*★★シナリオ概要：全方位弾*3 撃破したら次の敵機が出てくる★★*/
    execNormalSenario(player,music);
    
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
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true));
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(width,100.0),new PVector(-3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true));
    enemyList.add(new Enemy002(Const.HP_ENEMY_INVALID,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID,true));
    //ランダム弾*3
    enemyList.add(new Enemy003(180.0,new PVector(width/2,0.0),new PVector(0.0,2.0),720,true));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),720,true));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),720,true));
  }

  //**チャプターシナリオを実行
  void exec(Player player,Music music){

    /*★★シナリオ概要：自機狙い弾敵*3+ランダム弾*3 画面アウトしたら次の敵が出てくる★★*/
    execNormalSenario(player,music);
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
                        ,false));
    enemyList.add(new Enemy004(
                        Const.HP_ENEMY_INVALID
                        ,new PVector(7*width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_CLOCKWISE
                        ,180
                        ,false));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music){
    execAtOnceSenario(player,music);
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
                        ,false));
    //ランダム弾*2                    
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),600,true));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),600,true));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music){
    execAtOnceSenario(player,music);
  }  
  
}

/*------------------------------------------------------------*/
/*チャプター5*/
class Chapter5 extends Chapter{

  Chapter5(){
    super();
    chapterNo = 4;
  }
  
  //**敵を生成
  void createEnemy(Player player){
    for(int i=0; i<20; i++){
      enemyList.add(new Enemy005(Const.HP_ENEMY_INVALID,new PVector(random(width),random(Const.HEIGHT_INFO,400)),new PVector(0,1),60,PI/2,true));
    }
  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music){
    execConstantSenario(player,music,30);
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
    enemyList.add(new Boss001(1200,new PVector(width/2,100),new PVector(0,0),3600,false));
    enemyList.add(new Boss002(300,new PVector(width/2,250),new PVector(0,0),1800,false));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music){
    execNormalSenario(player,music);
  }  
  
}
