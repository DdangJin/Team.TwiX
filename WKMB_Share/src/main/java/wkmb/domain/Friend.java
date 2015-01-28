package wkmb.domain;

import java.util.Date;

public class Friend extends User{
  protected int fuid;
  protected int mode;
  protected int correctCount;
  protected int solveCount;
  protected int threeTime;
  protected Date lastDate;
  
  public int getFuid() {
    return fuid;
  }
  public Friend setFuid(int fuid) {
    this.fuid = fuid;
    
    return this;
  }
  public int getMode() {
    return mode;
  }
  public Friend setMode(int mode) {
    this.mode = mode;
    
    return this;
  }
  public int getCorrectCount() {
    return correctCount;
  }
  public Friend setCorrectCount(int correctCount) {
    this.correctCount = correctCount;
    
    return this;
  }
  public int getSolveCount() {
    return solveCount;
  }
  public Friend setSolveCount(int solveCount) {
    this.solveCount = solveCount;
    
    return this;
  }
  public int getThreeTime() {
    return threeTime;
  }
  public Friend setThreeTime(int threeTime) {
    this.threeTime = threeTime;
    
    return this;
  }
  public Date getLastDate() {
    return lastDate;
  }
  public Friend setLastDate(Date lastDate) {
    this.lastDate = lastDate;
    
    return this;
  }
  public int getScore() // 스코어 점수를 처리하기 위한 세터 메소드
  {
    return (int)(((float)correctCount/solveCount) * 100);
  }
  
}
