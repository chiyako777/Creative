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
    //自機狙い弾的*3 :チャプター2送りにする
    //enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation()));
    //enemyList.add(new Enemy002(120.0,new PVector(width,100.0),new PVector(-3.0,0.0),player.getLocation()));
    //enemyList.add(new Enemy002(120.0,new PVector(0.0,100.0),new PVector(3.0,0.0),player.getLocation()));
  }
  
  //**チャプターシナリオを実行
  void exec(Player player){

    /*★★シナリオ概要：全方位弾*3 撃破したら次の敵機が出てくる★★*/
    
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
        println("敵機撃破");
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
