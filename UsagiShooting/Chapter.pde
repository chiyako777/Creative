/* チャプタークラス(基底) */
abstract class Chapter{
  
  protected int chapterNo;  //チャプター番号
  protected ArrayList<Enemy> enemyList;  //敵リスト
    
  //**コンストラクタ
  Chapter(){
    
    chapterNo = 0;
    enemyList = new ArrayList<Enemy>();
    
  }
  
  //**敵を生成
  abstract void createEnemy(Player player);
  
  //**チャプターシナリオを実行
  abstract void exec(Player player,Music music);

  
  //**チャプターが終了したか判定
  boolean isChapterEnd(){
    //敵がすべて処理終了ならばチャプター終了
    for(Enemy e : enemyList){
      if(e.getStatus() != Const.STATUS_ENEMY_DONE){
        return false;
      }
    }
    return true;
  }
  
  //**シナリオ:前の敵機が非アクティブになったら次の敵機が出てくる
  void execNormalSenario(Player player,Music music){
    int beforeStatus = 99;
    
    for(int i=0; i<enemyList.size(); i++){
      
      Enemy e = enemyList.get(i);
      
      //最初の敵をアクティブ状態に
      if(i==0 && e.getStatus() == Const.STATUS_ENEMY_WAIT){
        e.setStatus(Const.STATUS_ENEMY_ACTIVE);
      }
      
      //前の敵が非アクティブor終了したら、次の敵をアクティブ状態にする
      if(e.getStatus() == Const.STATUS_ENEMY_WAIT){
        if(beforeStatus == Const.STATUS_ENEMY_NOT_ACTIVE || beforeStatus == Const.STATUS_ENEMY_DONE){
          e.setStatus(Const.STATUS_ENEMY_ACTIVE);
        }
      }
      
      //待機中の敵についてはスキップ
      if(e.getStatus() == Const.STATUS_ENEMY_WAIT){
        continue;
      }
        
      /*敵機、弾幕の描画*/
      e.updateLocation();
      e.draw();
      e.drawBulletHell();
      
      /*敵機への攻撃・撃破判定*/
      e.judgeHitToEnemy(player);
      if(e.isDefeat()){
        //敵機を非アクティブ状態に更新
        println("敵機撃破");
        music.playDefeteEnemy();
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
      }

      /*敵機の画面アウト判定*/
      if(e.isOutOfScreen()){
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
      }
      
      /*敵機のタイムアウト判定*/
      if(e.isTimeOut()){
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
      }
      
      /*敵機の処理終了判定*/
      if(e.isDone()){
        e.setStatus(Const.STATUS_ENEMY_DONE);
      }

      /*自機への弾幕当たり判定*/
      if(player.getStatus() != Const.STATUS_PLAYER_MUTEKI && e.isHitBulletToPlayer(player)){
        player.hit(music);
      }
      
      /*自機の敵機への衝突判定*/
      if(e.getStatus() == Const.STATUS_ENEMY_ACTIVE && e.isHitEnemyToPlayer(player)){
        player.hitEnemy(e);
      }
      
      beforeStatus = e.getStatus();
      
    }    
   
    /*自機の時間経過に伴う状態制御*/
    player.updateStatusByTime();
  }
  
  //**シナリオ:敵機が一気に出撃
  void execAtOnceSenario(Player player,Music music){
    for(Enemy e : enemyList){
      //最初はアクティブ化
      if(e.getStatus() == Const.STATUS_ENEMY_WAIT){
        e.setStatus(Const.STATUS_ENEMY_ACTIVE);
      }

      //敵機が待機中または終了状態の時はスキップ
      if(e.getStatus() == Const.STATUS_ENEMY_WAIT || e.getStatus() == Const.STATUS_ENEMY_DONE){
        continue;
      }
      /*敵機・弾幕描画*/
      e.updateLocation();
      e.draw();
      e.drawBulletHell();

      /*敵機への攻撃・撃破判定*/
      e.judgeHitToEnemy(player);
      if(e.isDefeat()){
        println("撃破:敵機を非アクティブ化");
        music.playDefeteEnemy();
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
        //弾幕を削除
        e.deleteAllBullet();
      }
      
      /*敵機のタイムアウト判定*/
      if(e.isTimeOut()){
        println("タイムアウト:敵機を非アクティブ化");
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
        //弾幕を削除
        e.deleteAllBullet();
      }

      /*敵機の処理終了判定*/
      if(e.isDone()){
        println("敵機処理終了");
        e.setStatus(Const.STATUS_ENEMY_DONE);
      }

      /*自機への弾幕当たり判定*/
      //println("自機ステータス = " + player.getStatus());
      if(player.getStatus() != Const.STATUS_PLAYER_MUTEKI && e.isHitBulletToPlayer(player)){
        player.hit(music);
      }
      
      /*自機の敵機への衝突判定*/
      if(e.getStatus() == Const.STATUS_ENEMY_ACTIVE && e.isHitEnemyToPlayer(player)){
        player.hitEnemy(e);
      }

    }

    /*自機の時間経過に伴う状態制御*/
    player.updateStatusByTime();
        
  }
}

/*------------------------------------------------------------*/
/*チャプター1クラス*/
class Chapter1 extends Chapter{
  
  //**コンストラクタ
  Chapter1(){
    super();
    chapterNo = 1;
  }

  //**敵を生成
  void createEnemy(Player player){
    //全方位弾敵*3
    enemyList.add(new Enemy001(240.0,new PVector(width/2,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL));
    enemyList.add(new Enemy001(240.0,new PVector(width/4,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL));
    enemyList.add(new Enemy001(240.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),960,Const.BULLET_TYPE_SMALL));

  }
  
  //**チャプターシナリオを実行
  void exec(Player player,Music music){

    /*★★シナリオ概要：全方位弾*3 撃破したら次の敵機が出てくる★★*/
    execNormalSenario(player,music);
    
  }

}

/*------------------------------------------------------------*/
/*チャプター2クラス*/
class Chapter2 extends Chapter{
  
  //**コンストラクタ
  Chapter2(){
    super();
    chapterNo = 2;
  }

  //**敵を生成
  void createEnemy(Player player){
    //自機狙い弾敵*3
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID));
    enemyList.add(new Enemy002(120.0,new PVector(width,100.0),new PVector(-3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID));
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation(),Const.TIMEOUT_ENEMY_INVALID));
    //ランダム弾*3
    enemyList.add(new Enemy003(180.0,new PVector(width/2,0.0),new PVector(0.0,2.0),720));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),720));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),720));
  }

  //**チャプターシナリオを実行
  void exec(Player player,Music music){

    /*★★シナリオ概要：自機狙い弾敵*3 画面アウトしたら次の敵が出てくる★★*/
    execNormalSenario(player,music);
  }
  
}

/*------------------------------------------------------------*/
/*チャプター3クラス*/
class Chapter3 extends Chapter{

  //**コンストラクタ
  Chapter3(){
    super();
    chapterNo = 3;
  }

  //**敵を生成
  void createEnemy(Player player){
    //放射レーザー*2
    enemyList.add(new Enemy004(
                        120.0
                        ,new PVector(width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_COUNTER_CLOCKWISE
                        ,180));
    enemyList.add(new Enemy004(
                        120.0
                        ,new PVector(7*width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_CLOCKWISE
                        ,180));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music){
    execAtOnceSenario(player,music);
  } 
  
}

/*------------------------------------------------------------*/
/*チャプター4クラス*/
class Chapter4 extends Chapter{
  
  //**コンストラクタ
  Chapter4(){
    super();
    chapterNo = 4;
  }

  //**敵を生成
  void createEnemy(Player player){
    //放射レーザー+水滴
    enemyList.add(new Enemy004(
                        600.0
                        ,new PVector(width/2,100.0)
                        ,new PVector(0.0,0.0)
                        ,9
                        ,Const.LASER_ROTATE_OFF
                        ,600));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0),600));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0),600));
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player,Music music){
    execAtOnceSenario(player,music);
  }  
  
}
