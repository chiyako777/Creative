/*自機クラス*/
class Player{

  private PVector location;  //自機の位置ベクトル
  private PVector direction;  //自機の移動方向ベクトル
  private ArrayList<Integer> directList;  //移動方向リスト
  private float vpf;  //速度(1フレームで何ピクセル進むか)
  
  private int zanki;    //残機
  private int status;    //ステータス
  
  //**コンストラクタ
  Player(float locationX,float locationY){
    
    location = new PVector(locationX,locationY);  //初期位置で自機を生成
    direction = new PVector(0.0,0.0);  //初期状態(静止)で移動方向ベクトルを生成
    directList = new ArrayList<Integer>();
    
    vpf = 3.0;
    zanki = 5;
    status = Const.STATUS_NON;
    
  }
  
  //**自機を描画
  void draw(){
    
    /*自機位置更新*/
    updateVector();
    location.add(direction);
    
    /*自機描画*/
    noStroke();
    fill(255);
    ellipse(location.x,location.y,10,10);
    
    /*ショット描画*/
    if(status == Const.STATUS_SHOOT){
      stroke(255,64);
      strokeWeight(5);
      line(location.x,location.y,location.x,Const.HEIGHT_INFO);
    }
    
    /*残機数描画*/
    noStroke();
    for(int i=0; i<zanki; i++){
      rect(400 + (i*40),20,20,20);
    }
    
  }
  
  //**移動方向リストに追加
  void pushDirect(){
    
    int d = 99;
    switch(keyCode){
      case UP:
        d = Const.DIRECTION_UP;
        break;
      case DOWN:
        d = Const.DIRECTION_DOWN;
        break;
      case LEFT:
        d = Const.DIRECTION_LEFT;
        break;
      case RIGHT:
        d = Const.DIRECTION_RIGHT;
        break;
    }
    
    if(d != 99 && directList.indexOf(d) == -1){
      directList.add(d);
    }
    
  }

  //**移動方向リストから削除
  void popDirect(){
    int index = 0;
    switch(keyCode){
      case UP:
        index = directList.indexOf(Const.DIRECTION_UP);
        if(index != -1){directList.remove(index);}
        break;
      case DOWN:
        index = directList.indexOf(Const.DIRECTION_DOWN);
        if(index != -1){directList.remove(index);}
        break;
      case LEFT:
        index = directList.indexOf(Const.DIRECTION_LEFT);
        if(index != -1){directList.remove(index);}
        break;
      case RIGHT:
        index = directList.indexOf(Const.DIRECTION_RIGHT);
        if(index != -1){directList.remove(index);}
        break;
    }
  }

  //**キー操作によるステータス変更
  void updateStatusByKey(char key,int keyFlg){
    
    switch(key){
      case Const.KEY_SHOOT:
      status = (keyFlg == Const.KEY_FLG_PRESS ? Const.STATUS_SHOOT : Const.STATUS_NON);
      break;
    }
    
  }

  //**移動方向ベクトルの更新
  private void updateVector(){
    //println("updateVector: directList.size() = " + directList.size()); //<>//
    
    //どの矢印キーも押されていなければ静止する
    if(directList.size() == 0){
      direction.x = 0.0;
      direction.y = 0.0;
      return;
    }
    
    //移動方向リストの末尾の方向に更新
    int d = directList.get(directList.size()-1);
    switch(d){
      case Const.DIRECTION_UP:
        direction.x = 0.0;
        if(location.y > Const.HEIGHT_INFO){
          direction.y = vpf * -1.0;
        }else{
          direction.y = 0.0;
        }
        break;
      case Const.DIRECTION_DOWN:
        direction.x = 0.0;
        if(location.y < height){
          direction.y = vpf;
        }else{
          direction.y = 0.0;
        }
        break;
      case Const.DIRECTION_LEFT:
        if(location.x > 0){
          direction.x = vpf * -1.0;
        }else{
          direction.x = 0.0;
        }
        direction.y = 0.0;
        break;
      case Const.DIRECTION_RIGHT:
        if(location.x < width){
          direction.x = vpf;
        }else{
          direction.x = 0.0;
        }
        direction.y = 0.0;
        break;
    }
    
  }
  
  //**フィールドのgetter,setter
  //(privateで宣言しているのに、他クラスからアクセスできてしまっているみたいだけど、
  //注意喚起も兼ねてアクセスの際はこちらを使用
  
  int getStatus(){
    return status;
  }
  
  PVector getLocation(){
    return location;
  }
  
}
