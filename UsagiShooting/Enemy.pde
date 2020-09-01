/*敵機クラス(基底)*/
abstract class Enemy{
  
  //※派生クラスからも使用できるようにするため、protected
  protected float hp;  //体力
  protected int status;  //ステータス
  protected float range;  //当たり判定の半径
  protected PVector location;  //敵機の位置ベクトル
  protected PVector direction;  //敵機の移動方向ベクトル
  protected BulletHell bulletHell;  //弾幕オブジェクト(注：敵機に紐づく弾幕は敵機撃破と同時に消滅)
  
  //**コンストラクタ
  Enemy(float hp,PVector location,PVector direction){
    
    //個別セット
    this.status = Const.STATUS_ENEMY_ACTIVE;
    this.hp = hp;
    this.location = location;
    this.direction = direction;
    
    //デフォルト値セット(サブクラスで実値セット)
    range = 0.0;
    bulletHell = null;
    
  }
  
  //**敵機の位置を更新
  abstract void updateLocation();
  
  //**敵機を描画
  abstract void draw();

  //**敵機から射出する弾幕を描画
  void drawBulletHell(){
    bulletHell.draw(status);
  }
  
  //**敵機の体力を計算(メモ：減少仕方を変更したい場合、各クラスでオーバーライドする)
  void calcHP(){
    hp = hp - 1;
  }

  //**敵機への自機ショット当たり判定
  void judgeHitToEnemy(Player player){
    //敵機が非アクティブなら何もしない
    if(status == Const.STATUS_ENEMY_NOT_ACTIVE){ return; }
    
    //自機がショット射出状態
    if(player.getStatus() == Const.STATUS_PLAYER_SHOOT){
      //自機ショットが敵機に当たっている
      if(player.getLocation().x > location.x - range && player.getLocation().x < location.x + range && player.getLocation().y > location.y){
        calcHP();
      }
    }
    
  }
  
  //**敵機撃破判定
  boolean isDefeat(){
    //アクティブ状態かつ、hpが0以下
    return ( status == Const.STATUS_ENEMY_ACTIVE && hp <= 0 ? true : false); 
  }
  
  //**自機への弾幕当たり判定
  boolean isHitBulletToPlayer(Player player){
    return bulletHell.isHitToPlayer(player);
  }
  
  //**自機への敵機本体当たり判定
  boolean isHitEnemyToPlayer(Player player){
     //自機位置が敵機当たり範囲内
    if(player.getLocation().x > location.x - range && player.getLocation().x < location.x + range){
      if(player.getLocation().y > location.y - range && player.getLocation().y < location.y + range){
        //println("敵機本体に衝突");
        return true;
      }
    }   
    return false;
  }
  
  //**弾幕を初期化
  void deleteAllBullet(){
    bulletHell.deleteAllBullet();
  }
  
  //**敵機の削除判定
  boolean isDeletable(){
    //すべての弾が画面からアウトしたら敵機削除可能
    if(status == Const.STATUS_ENEMY_NOT_ACTIVE && bulletHell.getBulletList().size() == 0){
      println("敵機削除可能");
      return true;
    }
    return false;
  }
  
  /*getter,setter*/
  int getStatus(){
    return status;
  }
  void setStatus(int status){
    this.status = status;
  }
  
}


/*------------------------------------------------------------*/
/*敵機タイプ①　丸型敵機:全方位弾射出*/
class Enemy001 extends Enemy{

  Enemy001(float hp,PVector location,PVector direction){
    super(hp,location,direction);
    range = 10.0;
    //全方位弾幕生成(弾幕数、敵機位置)
    bulletHell = new AllRoundBullletHell(20,this.location);
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
  void draw(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      ellipse(location.x,location.y,20,20);
    }
  }
  
}

/*------------------------------------------------------------*/
/*敵機タイプ②　丸型敵機:自機狙い弾射出　*/
class Enemy002 extends Enemy{

  //**コンストラクタ
  Enemy002(float hp,PVector location,PVector direction,PVector playerLocation){
    super(hp,location,direction);
    range = 10.0;
    //自機狙い弾幕生成(敵機位置、自機位置)
    bulletHell = new TargetingBulletHell(this.location,playerLocation);
  }
 
  //**敵機の位置を更新
  void updateLocation(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      location.add(direction);
    }
  }
  
  //**敵機を描画
  void draw(){
    if(status == Const.STATUS_ENEMY_ACTIVE){
      fill(255,247,153);
      ellipse(location.x,location.y,20,20);
    }
  }
  
}
