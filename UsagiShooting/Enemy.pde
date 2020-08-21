/*敵機クラス(基底)*/
abstract class Enemy{
  
  //※派生クラスからも使用できるようにするため、protected
  protected float hp;  //体力
  protected float range;  //当たり判定の半径
  protected PVector location;  //敵機の位置ベクトル
  protected PVector direction;  //敵機の移動方向ベクトル
  
  //**コンストラクタ
  Enemy(){
    hp = 0.0;
    range = 0.0;
    location = new PVector(0.0,0.0);
    direction = new PVector(0.0,0.0);
  }
  
  //**敵機の位置を更新
  abstract void updateLocation();
  
  //**敵機を描画
  abstract void draw();
  
  //**敵機の体力を計算(メモ：減少仕方を変更したい場合、各クラスでオーバーライドする)
  void calcHP(){
    hp = hp - 1;
  }

  //**当たり判定
  void judgeHit(Player player){ 
    //自機がショット射出状態
    if(player.getStatus() == Const.STATUS_SHOOT){
      //自機位置が敵機当たり範囲に入っている
      if(player.getLocation().x > location.x - range && player.getLocation().x < location.x + range){
        calcHP();
      }
    }
  }
  
  //**撃破判定
  boolean isDefeat(){
    return ( hp <= 0 ? true : false); 
  }
  
}

/*敵機クラス001*/
class Enemy001 extends Enemy{

  Enemy001(){
    super();
    hp = 120.0;
    range = 10.0;
    location = new PVector(width/2,0.0);
    direction = new PVector(0.0,2.0);
  }
  
  //**敵機の位置を更新
  void updateLocation(){
    if(location.y < 100){
      location.add(direction);        
    }
  }

  //**敵機を描画
  void draw(){
    fill(255,247,153);
    ellipse(location.x,location.y,20,20);
  }
  
}
