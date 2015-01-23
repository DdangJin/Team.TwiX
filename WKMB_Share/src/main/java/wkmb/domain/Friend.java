package wkmb.domain;

import java.util.Date;

public class Friend extends User{
  protected int fuid;
  protected int mode;
  protected int score;
  protected Date lastDate;

  public int getUid() {
    return uid;
  }
  public void setUid(int uid) {
    this.uid = uid;
  }
  public int getFuid() {
    return fuid;
  }
  public void setFuid(int fuid) {
    this.fuid = fuid;
  }
  public int getMode() {
    return mode;
  }
  public void setMode(int mode) {
    this.mode = mode;
  }
  public int getScore() {
    return score;
  }
  public void setScore(int score) {
    this.score = score;
  }
  public Date getLastDate() {
    return lastDate;
  }
  public void setLastDate(Date lastDate) {
    this.lastDate = lastDate;
  }
}
