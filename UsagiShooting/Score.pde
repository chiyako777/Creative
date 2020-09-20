/*スコア*/
static class Score{
  static int score = 0;
  
  //**スコア取得
  static int getScore(){
    return score;
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
  }
  
}
