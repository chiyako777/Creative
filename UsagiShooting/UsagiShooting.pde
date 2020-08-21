
/** ★★★うさぎシューティング★★★ **/

//シーン番号
int sceneNo = Const.SCENE_NO_TITLE;

//オブジェクト
Opening op;
Player player;
ArrayList<Chapter> chapterList;


void setup(){
  size(600,750);
  op = new Opening();
  player = new Player(width/2,height*4/5);
  chapterList = new ArrayList<Chapter>();
  for(int i=0; i<Const.CHAPTER_NUM; i++){
    chapterList.add(new Chapter(i+1));
  }
}

void draw(){
  background(0);
  
  switch(sceneNo){
  
     case Const.SCENE_NO_TITLE:
       /*タイトル画面*/
       drawTitle();
       break;
    
     case Const.SCENE_NO_OPENING:
       /*オープニング画面(カウントダウン)を描画*/
       int count = op.drawOpening();
       if(count == 0){
         sceneNo = 2;
       }
       break;

     case Const.SCENE_NO_STAGE:
       /*ゲーム(道中)画面*/
       execGame();
       
       break;

     case Const.SCENE_NO_PRE_BOSS:
       break;

     case Const.SCENE_NO_BOSS:
       break;

     case Const.SCENE_NO_CLEAR:
       break;
  }
}

void keyPressed(){
  /* 自機移動方向制御 */
  player.pushDirect();
  /* 自機ステータス制御 */
  player.updateStatusByKey(key,Const.KEY_FLG_PRESS);  
}

void keyReleased(){
  /* 自機移動方向制御 */
  player.popDirect();
  /* 自機ステータス制御 */
  player.updateStatusByKey(key,Const.KEY_FLG_RELEASE);
}


//**タイトル画面を描画
void drawTitle(){
  textSize(30);
  text("pless any key...",50,370);
  
  if(keyPressed){
    sceneNo = Const.SCENE_NO_OPENING;
  }
}

//**ゲームを実行
void execGame(){
  
  /*上部情報画面描画*/
  fill(127);
  rect(0,0,width,Const.HEIGHT_INFO);
  
  /*自機を描画*/
  player.draw();
  
  /*チャプターを実行準備*/
  Chapter ch = chapterList.get(0);
  
  //チャプター終了判定
  if(ch.isChapterEnd()){
    
    println("chapter end");

    //終了したチャプターはリストから削除
    chapterList.remove(0);
   
    //全てのチャプターが終了した場合はゲームクリア
    if(chapterList.size() == 0){
      println("game clear");
      return;
    }
    
    //次のチャプターの敵インスタンスの準備
    ch = chapterList.get(0);
    ch.createEnemy();
    
  }
  
  /*チャプターを実行*/
  ch.exec(player);
  
}
