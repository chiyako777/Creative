/* チャプタークラス */
class Chapter{ 
  
  private int chapterNo;  //チャプター番号
  private ArrayList<Enemy> enemyList;  //敵リスト
  
  //チャプター毎の敵数
  final int[] enemyNumList = {3,4,5,6,7};
  
  //**コンストラクタ
  Chapter(int chapterNo){
    
    //チャプター番号セット
    this.chapterNo = chapterNo;
    //敵リストを生成
    enemyList = new ArrayList<Enemy>();
    
    //最初のチャプターの場合、敵インスタンスを生成する
    if(chapterNo == 1){
      for(int i=0;i<enemyNumList[0];i++){
        //★今は固定でEnemy001にしているけど、後でチャプター1のシナリオに合った敵タイプにする
        enemyList.add(new Enemy001());
      }
    }
    
  }
  
  //**敵を生成
  void createEnemy(){
    //当該チャプターの敵数分、インスタンス生成
    int enemyNum = enemyNumList[chapterNo-1]; 
    for(int i=0; i<enemyNum; i++){
      //★今は固定でEnemy001にしているけど、後で各チャプターのシナリオに合った敵タイプにする
      enemyList.add(new Enemy001());
    }
  }
  
  //**チャプターが終了したか判定
  boolean isChapterEnd(){
    //println("isChapterEnd : enemyList.size() = " + enemyList.size());
    //敵がすべて撃破済ならばチャプター終了
    if(enemyList.size() == 0){
      return true;
    }
    return false;
  }
  
  //**チャプターシナリオを実行
  void exec(Player player){
    switch(chapterNo){
      case 1:
        Enemy e = enemyList.get(0);
        e.updateLocation();
        e.draw();
        e.judgeHit(player);
        if(e.isDefeat()){
          println("撃破");
          enemyList.remove(0);
        }
        break;
    }
  }
  
  
}
