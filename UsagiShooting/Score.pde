/*スコア*/
static class Score{
  static int score = 0;
  static int graze = 0;
  static int grazeExtend = 0;  //エクステンド判定用のグレイズ(一定数たまったら初期化する)
  
  //**スコア取得
  static int getScore(){
    return score;
  }
  //**グレイズ取得
  static int getGraze(){
    return graze;
  }
  //**エクステンド判定用グレイズ取得
  static int getGrazeExtend(){
    return grazeExtend;
  }

  //**撃破ボーナス
  static void addDefeatBonus(Enemy e){
    if(e.getBossFlg()){
      println("ボス撃破ボーナス!");
      score += Const.SCORE_BOSS_DEFEAT;
    }else{
      println("敵機撃破ボーナス!");
      score += Const.SCORE_ENEMY_DEFEAT;
    }
  }
  
  //**ボススペル回避ボーナス
  static void addSpellClearBonus(){
    println("ボススペル回避成功");
    score += Const.SCORE_BOSS_SPELLCLEAR;
  }
  
  //**一定時間ノー被弾ボーナス
  static void addNoMissBonus(){
    score += Const.SCORE_NO_MISS;
  }
  
  //**グレイズボーナス
  static void addGrazeBonus(){
    score += Const.SCORE_GRAZE;
    graze += 1;
    grazeExtend += 1;
  }
  
  //エクステンド判定用グレイズの初期化
  static void initGrazeEntend(){
    grazeExtend = 0;
  }
  
  //**初期化
  static void init(){
    score = 0;
    graze = 0;
    grazeExtend = 0;
  }
}
