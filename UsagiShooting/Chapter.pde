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
    //敵がすべて撃破済ならばチャプター終了
    if(enemyList.size() == 0){
      return true;
    }
    return false;
  }
   
}

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
    //自機狙い弾的*3
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(4.0,0.0),player.getLocation()));
    enemyList.add(new Enemy002(120.0,new PVector(width,100.0),new PVector(-4.0,0.0),player.getLocation()));
    enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(4.0,0.0),player.getLocation()));

  }
  
  //**チャプターシナリオを実行
  void exec(Player player){
    
    //----試行錯誤中----
    
    /*敵機、弾幕の描画*/
    Enemy e = enemyList.get(0);
    e.updateLocation();
    e.draw();
    e.drawBulletHell();
    
    /*敵機への攻撃・撃破判定*/
    e.judgeHitToEnemy(player);
    if(e.isDefeat()){
      println("敵機撃破");
      //敵機を非アクティブ状態に更新
      e.setStatus(Const.STATUS_ENEMY_NOT_ACTIVE);
    }
    
    /*処理終了した敵機の削除*/
    if(e.isDeletable()){
      enemyList.remove(0);
    }
    
    /*自機への弾幕当たり判定*/
    if(player.getStatus() != Const.STATUS_PLAYER_MUTEKI && e.isHitBulletToPlayer(player)){
      player.hit();
    }
    
    /*自機の敵機への衝突判定*/
    if(e.getStatus() == Const.STATUS_ENEMY_ACTIVE && e.isHitEnemyToPlayer(player)){
      player.hitEnemy(e);
    }
    
    /*自機の時間経過に伴う状態制御*/
    player.updateStatusByTime();
    
  }


}
