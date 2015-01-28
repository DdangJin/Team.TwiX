package wkmb.dao;

import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wkmb.domain.User;

@Repository
public class UserDao {
  @Autowired
  SqlSessionFactory sqlSessionFactory;
  
  public void insert(User user)
    {
      SqlSession sqlSession = sqlSessionFactory.openSession();
      
      try
      {
        sqlSession.insert("wkmb.dao.UserDao.insert", user);
        
        sqlSession.commit();
      }catch(Exception e)
      {
        e.printStackTrace();
      }finally
      {
        sqlSession.close();
      }
    }

  public User getLoginInfo(String id, String password) {
    SqlSession sqlSession = sqlSessionFactory.openSession();

    try
    {
      HashMap<String, String> params = new HashMap<String, String>();
      params.put("id", id);
      params.put("password", password);


      return sqlSession.selectOne("wkmb.dao.UserDao.loginInfo", params);
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }

  // id 중복검사
  public boolean exist(String id) {
    SqlSession sqlSession = sqlSessionFactory.openSession();

    try
    {
      int count = sqlSession.selectOne("wkmb.dao.UserDao.exist", id);

      if(count == 0)
        return false;
      else
        return true;
    }catch(Exception e)
    {
      e.printStackTrace();
      return false;
    }finally
    {
      sqlSession.close();
    }
  }
  
  // id값을 입력하면 그에 해당하는 uid 반환
  public int selectUserUid(String id)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();

    try
    {
      return sqlSession.selectOne("wkmb.dao.UserDao.selectUserUid", id);
    }catch(Exception e)
    {
      e.printStackTrace();
      return -1;
    }finally
    {
      sqlSession.close();
    }
  }
  
  // uid값을 입력하면 그에 해당하는 User 반환
  public User selectOne(int uid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();

    try
    {
      return sqlSession.selectOne("wkmb.dao.UserDao.selectOne", uid);
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }

  
  public void updateUser(User user) {
    SqlSession sqlSession = sqlSessionFactory.openSession();

    try
    {
      sqlSession.selectOne("wkmb.dao.UserDao.updateUser", user);
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }

}
