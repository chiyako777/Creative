/* 定数定義 */

class Const{
  
  //シーン番号
  final static int SCENE_NO_TITLE = 0;
  final static int SCENE_NO_OPENING = 1;
  final static int SCENE_NO_STAGE = 2;
  final static int SCENE_NO_PRE_BOSS = 3;
  final static int SCENE_NO_BOSS = 4;
  final static int SCENE_NO_CLEAR = 5;
  final static int SCENE_NO_GAMEOVER = 6;
  
  //チャプター数
  final static int CHAPTER_NUM = 5;
  
  //自機ステータス
  final static int STATUS_NON = 0;  //ノーショット状態
  final static int STATUS_SHOOT = 1;  //ショット状態
  final static int STATUS_BOM = 2;  //ボム状態(未実装)
  
  //上部情報画面
  final static float HEIGHT_INFO = 50.0;
  
  //キー操作フラグ
  final static int KEY_FLG_PRESS = 1;
  final static int KEY_FLG_RELEASE = 0;
  
  //キー種類
  final static char KEY_SHOOT = 'z';   //ショット発射(z)
 
  //移動方向
  final static int DIRECTION_UP = 1;
  final static int DIRECTION_DOWN = 2;
  final static int DIRECTION_LEFT = 3;
  final static int DIRECTION_RIGHT = 4;
      

}
