/*敵機クラス(基底)*/
abstract class Enemy{
  
  protected float hp;  //体力
  protected int status;  //ステータス
  protected float range;  //敵機当たり判定の半径
  protected PVector location;  //敵機の位置ベクトル
  protected PVector direction;  //敵機の移動方向ベクトル
  protected int activeTime = 0;  //アクティブ時間(フレーム数)
  protected int timeout;    //タイムアウト時間(フレーム数)
  protected boolean bulletRemainFlg;  //弾幕残しフラグ(敵機非アクティブ化後、弾幕を即消去するか残すか)
  protected ArrayList<BulletHell> bulletHellList;  //弾幕オブジェクトリスト
  
  Enemy(float hp,PVector location,PVector direction,int timeout,boolean bulletRemainFlg){
    
    //個別セット
    this.status = Const.STATUS_ENEMY_WAIT;
    this.hp = hp;
    this.location = location;
    this.direction = direction;
    this.timeout = timeout;
    this.bulletRemainFlg = bulletRemainFlg;
    
    //デフォルト値セット(サブクラスで実値セット)
    range = 0.0;
    bulletHellList = new ArrayList<BulletHell>();
    
  }
  
  //**敵機の位置を更新
  abstract void updateLocation();
  
  //**敵機を描画
  abstract void draw(Image img);

  //**敵機から射出する弾幕を描画
  void drawBulletHell(){
    for(BulletHell bulletHell : bulletHellList){
      bulletHell.draw(status);
    }
  }
  
  //**敵機の体力を計算(メモ：減少仕方を変更したい場合、各クラスでオーバーライドする)
  void calcHP(){
    hp = hp - 1;
  }

  //**敵機への自機ショット当たり判定
  void judgeHitToEnemy(Player player){
    //撃破不能の敵:判定なし
    if(hp == Const.HP_ENEMY_INVALID){ return; }
    //敵機が非アクティブ:判定なし
    if(status == Const.STATUS_ENEMY_NOT_ACTIVE){ return; }
    
    //当たり判定実施
    if(player.getStatus() == Const.STATUS_PLAYER_SHOOT){
      if(player.getLocation().x > location.x - range && player.getLocation().x < location.x + range && player.getLocation().y > location.y){
        calcHP();
      }
    }
  }
  
  //**敵機撃破判定
  boolean isDefeat(){
    //アクティブ状態かつ、hpが0以下、かつ撃破不能的ではない
    return ( status == Const.STATUS_ENEMY_ACTIVE && hp <= 0  && hp != Const.HP_ENEMY_INVALID ? true : false); 
  }
  
  //**自機への弾幕当たり判定
  boolean isHitBulletToPlayer(Player player){
    boolean isHit = false;
    for(BulletHell bulletHell : bulletHellList){
      if(bulletHell.isHitToPlayer(player)){
        isHit = true;
      }
    }
    return isHit;
  }
  
  //**自機への敵機本体当たり判定
  boolean isHitEnemyToPlayer(Player player){
     //自機位置が敵機当たり範囲内
    if(player.getLocation().x > location.x - range && player.getLocation().x < location.x + range){
      if(player.getLocation().y > location.y - range && player.getLocation().y < location.y + range){
        return true;
      }
    }   
    return false;
  }

  //**敵機の画面外判定
  boolean isOutOfScreen(){
    //アクティブ状態でない:判定なし
    if(status != Const.STATUS_ENEMY_ACTIVE){
      return false;
    }
    
    if(location.x < 0 || location.x > width){
      return true;
    }
    if(location.y < 0 || location.y > height){
      return true;
    }
    return false;
    
  }
  
  //**敵機のタイムアウト判定
  boolean isTimeOut(){
    //アクティブ状態でない:判定なし
    if(status != Const.STATUS_ENEMY_ACTIVE){
      return false;
    }
    
    if(timeout != Const.TIMEOUT_ENEMY_INVALID && activeTime >= timeout){
      return true;
    }
    return false;
    
  }
  
  //**弾幕を初期化
  void deleteAllBullet(){
    for(BulletHell bulletHell : bulletHellList){
      bulletHell.deleteAllBullet();
    }
  }
  
  //**敵機の処理終了判定
  boolean isDone(){
    
    //まだ敵機が非アクティブになっていない=false
    if(status != Const.STATUS_ENEMY_NOT_ACTIVE){
      return false;
    }
    
    //全ての弾幕の処理が終了していない=false
    for(BulletHell bulletHell : bulletHellList){
      if(bulletHell.getBulletList().size() != 0 || bulletHell.getLaserList().size() != 0){
        return false;
      }
    }
    
    return true;
  }
  
  /*getter,setter*/
  int getStatus(){
    return status;
  }
  void setStatus(int status){
    this.status = status;
  }
  int getActiveTime(){
    return activeTime;
  }
  boolean getBulletRemainFlg(){
    return bulletRemainFlg;
  }
}
