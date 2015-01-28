package wkmb.dao;

import java.util.HashMap;
import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wkmb.domain.Friend;

@Repository
public class FriendDao {
  @Autowired
  SqlSessionFactory sqlSessionFactory;
  
  @Autowired
  UserDao userDao;
  
  public List<Friend> selectFriendList(int uid)                                     // uid를 받아와 그 uid에 해당하는 Friend목록을 받아옴.
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.FriendDao.selectFriendList", uid);     // FriendDao.xml의 selectList쿼리문으로 Friend목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public List<Friend> selectFriendListByDate(int uid)                                     // uid를 받아와 그 uid에 해당하는 Friend목록을 받아옴.
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.FriendDao.selectFriendListByDate", uid);     // FriendDao.xml의 selectList쿼리문으로 Friend목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public List<Friend> selectFriendListByScore(int uid)                                     // uid를 받아와 그 uid에 해당하는 Friend목록을 받아옴.
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.FriendDao.selectFriendListByScore", uid);     // FriendDao.xml의 selectList쿼리문으로 Friend목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public int selectSolvedFriend(int uid)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectOne("wkmb.dao.FriendDao.selectSolvedFriend", uid);     // FriendDao.xml의 selectList쿼리문으로 Friend목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return 0;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public boolean insertFriend(String fid, int uid)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      int fuid = userDao.selectUserUid(fid);
      
      HashMap<String, Integer> hm = new HashMap<String, Integer>();
      hm.put("fuid", fuid);
      hm.put("uid", uid);
      sqlSession.selectOne("wkmb.dao.FriendDao.insertFriendMe", hm);     // FriendDao.xml의 insertFriend쿼리문으로 Friend목록에 추가.
      sqlSession.selectOne("wkmb.dao.FriendDao.insertFriendYou", hm);     // FriendDao.xml의 insertFriend쿼리문으로 Friend목록에 추가.
      
      sqlSession.commit();
      
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

  public List<Friend> selectSearchFriendList(int uid, String name) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(uid);
      friend.setName(name);
      return sqlSession.selectList("wkmb.dao.FriendDao.selectSearchFriendList", friend);
      // FriendDao.xml의 selectSearchFriendList쿼리문으로 Friend 목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }

  public int selectFriendCount(int uid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectOne("wkmb.dao.FriendDao.selectFriendCount", uid);     // 친구 명수 받아옴
    }catch(Exception e)
    {
      e.printStackTrace();
      return 0;
    }finally
    {
      sqlSession.close();
    }
  }

  public void updateFriend(int uid, int fuid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(uid);
      friend.setFuid(fuid);
      
      sqlSession.update("wkmb.dao.FriendDao.updateFriend", friend);     // mode를 0으로 바꿈.
      
      sqlSession.commit();
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }
  
  public void deleteFriend(int uid, int fuid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(uid);
      friend.setFuid(fuid);
      
      sqlSession.delete("wkmb.dao.FriendDao.deleteFriend", friend);     // 삭제
      
      sqlSession.commit();
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }

  public void updateScore(int questionUid, int uid, int correctCount)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(questionUid);
      friend.setFuid(uid).setCorrectCount(correctCount);
      
      sqlSession.delete("wkmb.dao.FriendDao.updateScore", friend);
      
      sqlSession.commit();
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }
  
  public int selectThreeTime(int questionUid, int uid)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(questionUid);
      friend.setFuid(uid);
      
      return sqlSession.selectOne("wkmb.dao.FriendDao.selectThreeTime", friend);
    }catch(Exception e)
    {
      e.printStackTrace();
      return 3;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public void updateCountThreeTime(int questionUid, int uid)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(questionUid);
      friend.setFuid(uid);
      
      sqlSession.update("wkmb.dao.FriendDao.updateCountThreeTime", friend);
      
      sqlSession.commit();
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }
  
  public void updateClearThreeTime(int questionUid, int uid)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      Friend friend = new Friend();
      friend.setUid(questionUid);
      friend.setFuid(uid);
      
      sqlSession.update("wkmb.dao.FriendDao.updateClearThreeTime", friend);
      
      sqlSession.commit();
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }

  public List<Friend> selectClearFriendList(int uid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.FriendDao.selectClearFriendList", uid);
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }

//  public boolean exist(String id) {                                                  // 친구신청할때 이미 친구인지 or 이미 친구신청을 했는지 확인하기위해 만듬.
//    SqlSession sqlSession = sqlSessionFactory.openSession();
//
//    try
//    {
//      int count = sqlSession.selectOne("wkmb.dao.FriendDao.exist", id);
//
//      if(count == 0)
//        return false;
//      else
//        return true;
//    }catch(Exception e)
//    {
//      e.printStackTrace();
//      return false;
//    }finally
//    {
//      sqlSession.close();
//    }
//    
//  }
}
