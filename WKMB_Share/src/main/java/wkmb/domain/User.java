package wkmb.domain;

public class User {
  protected int uid;
  protected String id;
  protected String password;
  protected String name;
  protected String sex;
  protected String photo;
  protected String message;
  
  public int getUid() {
    return uid;
  }
  public User setUid(int uid) {
    this.uid = uid;
    
    return this;
  }
  public String getId() {
    return id;
  }
  public User setId(String id) {
    this.id = id;
    
    return this;
  }
  public String getPassword() {
    return password;
  }
  public User setPassword(String password) {
    this.password = password;
    
    return this;
  }
  public String getName() {
    return name;
  }
  public User setName(String name) {
    this.name = name;
    
    return this;
  }
  public String getSex() {
    return sex;
  }
  public User setSex(String sex) {
    this.sex = sex;
    
    return this;
  }
  public String getPhoto() {
    return photo;
  }
  public User setPhoto(String photo) {
    this.photo = photo;
    
    return this;
  }
  public String getMessage() {
    return message;
  }
  public User setMessage(String message) {
    this.message = message;
    
    return this;
  }
  
  
}
