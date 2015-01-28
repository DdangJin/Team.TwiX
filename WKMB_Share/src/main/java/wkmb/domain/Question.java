package wkmb.domain;

public class Question {
  int qid;
  int uid;
  String question;
  String answer;
  
  public int getQid() {
    return qid;
  }
  public Question setQid(int qid) {
    this.qid = qid;
    
    return this;
  }
  public int getUid() {
    return uid;
  }
  public Question setUid(int uid) {
    this.uid = uid;
    
    return this;
  }
  public String getQuestion() {
    return question;
  }
  public Question setQuestion(String question) {
    this.question = question;
    
    return this;
  }
  public String getAnswer() {
    return answer;
  }
  public Question setAnswer(String answer) {
    this.answer = answer;
    
    return this;
  }
  
}
