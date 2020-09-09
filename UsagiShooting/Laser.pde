/* レーザークラス(基底) */
abstract class Laser{

  protected PVector startPoint;  //始点ベクトル
  protected PVector endPoint;    //終点ベクトル
  protected PVector laserVector; //レーザーベクトル(当たり判定用)
  protected float laserRange;    //レーザー幅
  protected int status;          //ステータス
  protected int preTime;     //予告状態時間(フレーム数)
  
  //**コンストラクタ
  Laser(PVector startPoint,PVector endPoint,float laserRange){
    
    this.startPoint = startPoint;
    this.endPoint = endPoint;
    this.laserRange = laserRange;
    this.status = Const.LASER_STATUS_PRE;
    this.preTime = 0;
    //当たり判定用ベクトル生成
    this.laserVector = (new PVector(this.endPoint.x - this.startPoint.x,this.endPoint.y - this.startPoint.y));
    
  }

  //** レーザーを描画
  abstract void draw();
  
  
  //**自機への当たり判定
  boolean isHitToPlayer(Player player){
    /*予告状態の場合スキップ*/
    if(status == Const.LASER_STATUS_PRE){
      return false;
    }
    
    /*当たり判定用レーザーベクトルの更新(回転などで初期生成時から変わっている可能性があるため)*/
    laserVector = (new PVector(endPoint.x - startPoint.x,endPoint.y - startPoint.y));
    
    /*レーザーと自機の距離と、自機当たり半径を比較*/
    
    //レーザーベクトルを正規化
    PVector laserVectorNormal = laserVector.copy();
    laserVectorNormal.normalize();
   
    //レーザーの始点から自機の中心へのベクトルを定義
    PVector vectorB = new PVector(player.getLocation().x - startPoint.x,player.getLocation().y - startPoint.y);
    
    //レーザーと自機の距離を算出
    float distance = vectorB.x * laserVectorNormal.y - laserVectorNormal.x * vectorB.y;  //レーザー中心と自機中心の最短距離を算出(外積)
    distance = Math.abs(distance);    //絶対値化
    distance -= laserRange/2;    //レーザー幅を考慮
    
    //自機半径と比較
    if(distance >= Const.RANGE_HIT_PLAYER){
      return false;
    }
    
    /*自機がレーザーの範囲に入っているか判定*/

    //レーザーの終点から自機の中心へのベクトルを定義
    PVector vectorC = new PVector(player.getLocation().x - endPoint.x,player.getLocation().y - endPoint.y);
    
    //各ベクトルの内積を計算 : いずれかが正、いずれかが負なら範囲に入っている
    float dot1 = vectorB.x * laserVectorNormal.x + vectorB.y * laserVectorNormal.y;
    float dot2 = vectorC.x * laserVectorNormal.x + vectorC.y * laserVectorNormal.y;
    if(dot1 > 0 && dot2 < 0){
      return true;
    }else if(dot1 < 0 && dot2 > 0){
      return true;
    }
    
    /*レーザーの末端付近に当たっているか判定*/
    if(vectorB.mag() < Const.RANGE_HIT_PLAYER || vectorC.mag() < Const.RANGE_HIT_PLAYER){
      return true;
    }
    
    return false;
  }
  
  //**レーザーの状態遷移
  void updateStatus(){
    
    //予告状態の終了判定
    if(status == Const.LASER_STATUS_PRE && preTime >= Const.LASER_PRE_TIME_NORMAL){
      status = Const.LASER_STATUS_SHOOT;
    }
    
  }
  
  /*getter,setter*/
  
  void setEndPoint(PVector endPoint){
    this.endPoint = endPoint;
  }
  
  int getStatus(){
    return status;
  }
  
}

/*------------------------------------------------------------*/
/* 通常レーザー */
class NormalLaser extends Laser{
  
  //**コンストラクタ
  NormalLaser(PVector startPoint,PVector endPoint,float laserRange){
    super(startPoint,endPoint,laserRange);
  }
  
  void draw(){
    /*実ショット*/
    if(status == Const.LASER_STATUS_SHOOT){
      //println("実線");
      stroke(65,105,225);
      strokeWeight(laserRange);
      line(startPoint.x,startPoint.y,endPoint.x,endPoint.y);
    }
    /*予告線*/
    if(status == Const.LASER_STATUS_PRE){
      //println("予告線:preTime = " + preTime);
      stroke(65,105,225,16);
      strokeWeight(laserRange);
      line(startPoint.x,startPoint.y,endPoint.x,endPoint.y);
      //予告状態制御
      preTime += 1;
      updateStatus();
    }
  }
  
}
