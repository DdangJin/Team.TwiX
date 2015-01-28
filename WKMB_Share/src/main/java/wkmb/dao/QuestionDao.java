package wkmb.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import wkmb.domain.Question;

@Repository
public class QuestionDao {
  @Autowired
  SqlSessionFactory sqlSessionFactory;
  
  public List<Question> selectQuestionList(int uid)                                     // uid를 받아와 그 uid에 해당하는 Friend목록을 받아옴.
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.QuestionDao.selectQuestionList", uid);     // FriendDao.xml의 selectList쿼리문으로 Friend목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }
  
}
