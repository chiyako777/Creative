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
  abstract void exec(Player player);

  
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
  void execNormalSenario(Player player){
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
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
      }

      /*敵機の画面アウト判定*/
      if(e.isOutOfScreen()){
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
      }
      
      /*敵機の処理終了判定*/
      if(e.isDone()){
        e.setStatus(Const.STATUS_ENEMY_DONE);
      }

      /*自機への弾幕当たり判定*/
      if(player.getStatus() != Const.STATUS_PLAYER_MUTEKI && e.isHitBulletToPlayer(player)){
        player.hit();
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
    enemyList.add(new Enemy001(240.0,new PVector(width/2,0.0),new PVector(0.0,2.0)));
    enemyList.add(new Enemy001(240.0,new PVector(width/4,0.0),new PVector(0.0,2.0)));
    enemyList.add(new Enemy001(240.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0)));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player){

    /*★★シナリオ概要：全方位弾*3 撃破したら次の敵機が出てくる★★*/
    execNormalSenario(player);
    
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
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation()));
    enemyList.add(new Enemy002(120.0,new PVector(width,100.0),new PVector(-3.0,0.0),player.getLocation()));
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation()));
    //ランダム弾*3
    enemyList.add(new Enemy003(180.0,new PVector(width/2,0.0),new PVector(0.0,2.0)));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0)));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0)));
  }

  //**チャプターシナリオを実行
  void exec(Player player){

    /*★★シナリオ概要：自機狙い弾敵*3 画面アウトしたら次の敵が出てくる★★*/
    execNormalSenario(player);
  }
  
}

/*------------------------------------------------------------*/
/*チャプター3クラス*/
class Chapter3 extends Chapter{

  int progress = 1;  //シナリオ進捗
  
  //**コンストラクタ
  Chapter3(){
    super();
    chapterNo = 3;
  }

  //**敵を生成
  void createEnemy(Player player){
    //シナリオ1:放射レーザー*2
    enemyList.add(new Enemy004(
                        120.0
                        ,new PVector(width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_COUNTER_CLOCKWISE));
    enemyList.add(new Enemy004(
                        120.0
                        ,new PVector(7*width/8,100.0)
                        ,new PVector(0.0,0.0)
                        ,16
                        ,Const.LASER_ROTATE_CLOCKWISE));
    //シナリオ2:放射レーザー+水滴
    enemyList.add(new Enemy004(
                        120.0
                        ,new PVector(width/2,100.0)
                        ,new PVector(0.0,0.0)
                        ,9
                        ,Const.LASER_ROTATE_OFF));
    enemyList.add(new Enemy003(180.0,new PVector(width/4,0.0),new PVector(0.0,2.0)));
    enemyList.add(new Enemy003(180.0,new PVector(3*width/4,0.0),new PVector(0.0,2.0)));
    
  }
  
  //**チャプターシナリオを実行+
  void exec(Player player){
    
    /*シナリオ遷移判定 ※もう少しコンパクトに書きたい..*/
    Enemy e0 = enemyList.get(0);
    Enemy e1 = enemyList.get(1);
    Enemy e2 = enemyList.get(2);
    Enemy e3 = enemyList.get(3);
    Enemy e4 = enemyList.get(4);
    if(progress == 1){
      if(e0.getStatus() == Const.STATUS_ENEMY_DONE && e1.getStatus() == Const.STATUS_ENEMY_DONE){
        println("シナリオ進捗:2に更新");
        progress = 2;
      }
    }
    if(progress == 2){
      if(e2.getStatus() == Const.STATUS_ENEMY_DONE 
          && e3.getStatus() == Const.STATUS_ENEMY_DONE
          && e4.getStatus() == Const.STATUS_ENEMY_DONE){
        println("シナリオ進捗:3に更新");    
        progress = 3;
      }      
    }
    
    
    /*★★シナリオ1：放射レーザー★★*/
    if(progress == 1){
      
      for(int i=0; i<2; i++){
        Enemy e = enemyList.get(i);
        //最初はアクティブ化
        if(e.getStatus() == Const.STATUS_ENEMY_WAIT){
          e.setStatus(Const.STATUS_ENEMY_ACTIVE);
        }
        e.updateLocation();
        e.draw();
        e.drawBulletHell();
      }
            
    }
    
    /*★★シナリオ2：放射レーザー★★*/
    if(progress == 2){
      
      for(int i=2; i<5; i++){
        Enemy e = enemyList.get(i);
        //最初はアクティブ化
        if(e.getStatus() == Const.STATUS_ENEMY_WAIT){
          e.setStatus(Const.STATUS_ENEMY_ACTIVE);
        }
        e.updateLocation();
        e.draw();
        e.drawBulletHell();
      }
      
    }
    
    /*当たり判定、状態遷移など*/
    for(Enemy e : enemyList){
      
      //敵機が待機中または終了状態の時はスキップ
      if(e.getStatus() == Const.STATUS_ENEMY_WAIT || e.getStatus() == Const.STATUS_ENEMY_DONE){
        continue;
      }

      /*敵機への攻撃・撃破判定*/
      e.judgeHitToEnemy(player);
      if(e.isDefeat()){
        println("撃破:敵機を非アクティブ化");
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
        //レーザーを削除
        e.deleteAllBullet();
      }
      
      /*敵機のタイムアウト判定*/
      if(e.getActiveTime() > 1000){
        println("タイムアウト:敵機を非アクティブ化");
        //敵機を非アクティブ状態に更新
        e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
        //レーザーを削除
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
        player.hit();
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
