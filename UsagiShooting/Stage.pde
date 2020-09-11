/* ステージクラス(基底) */
abstract class Stage{

  protected int stageNo;  //ステージ番号
  protected ArrayList<Chapter> chapterList;  //チャプターリスト
  
  Stage(){
    stageNo = 0;
    chapterList = new ArrayList<Chapter>();
  }
  
}

/*------------------------------------------------------------*/
/*ステージ1*/
class Stage1 extends Stage{
  
  Stage1(){
    super();
    stageNo = 1;
    chapterList.add(new Chapter1());
    chapterList.add(new Chapter2());
    chapterList.add(new Chapter3());
  }
  
}

/*------------------------------------------------------------*/
