/* 定数定義 */

class Const{
  
  //モード
  final static int MODE_DEV = 0;  //(ゲームオーバーにならない)
  final static int MODE_PRO = 1;
  
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
  final static int STATUS_PLAYER_NON = 0;      //ノーショット状態
  final static int STATUS_PLAYER_SHOOT = 1;    //ショット状態
  final static int STATUS_PLAYER_BOM = 2;      //ボム状態(未実装)
  final static int STATUS_PLAYER_MUTEKI = 3;   //被弾後無敵時間
  
  //敵機ステータス
  final static int STATUS_ENEMY_WAIT = 0;          //待機状態
  final static int STATUS_ENEMY_ACTIVE = 1;        //アクティブ状態(プレイヤーから見えている状態の敵)
  final static int STATUS_ENEMY_NOT_ACTIVE = 2;    //非アクティブ状態(撃破済み、画面アウト、元から不可視の敵などで　プレイヤーから見えてない状態の敵)
                                                   //※敵機が消えても弾幕は生きていることがある
  final static int STATUS_ENEMY_DONE = 3;          //終了状態
  
  
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
  
  //自機当たり判定の半径
  final static float RANGE_HIT_PLAYER = 5.0;
  
  //自機被弾後の無敵時間(フレーム数)
  final static int MUTEKI_TIME_PLAYER = 60;

}
