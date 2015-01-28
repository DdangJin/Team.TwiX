package wkmb.dao;

import java.util.HashMap;
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
  
  public List<Question> selectQuestionList(int uid)                                     // uid를 받아와 그 uid에 해당하는 Question 목록을 받아옴.
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      return sqlSession.selectList("wkmb.dao.QuestionDao.selectQuestionList", uid);     // QuestionDao.xml의 selectQuestionList 쿼리문으로 Question 목록을 받아옴.
    }catch(Exception e)
    {
      e.printStackTrace();
      return null;
    }finally
    {
      sqlSession.close();
    }
  }
  
  public void insertQuestion(Question question)
  {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      sqlSession.delete("wkmb.dao.QuestionDao.insertQuestion", question);     // QuestionDao.xml의 insertQuestion 쿼리문으로 Question 삽입.
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }
  
  public void updateQuestion(Question question) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    
    try
    {
      sqlSession.delete("wkmb.dao.QuestionDao.updateQuestion", question);     // QuestionDao.xml의 updateQuestion 쿼리문으로 Question 변경.
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }

  public void deleteQuestion(int uid, int qid) {
    SqlSession sqlSession = sqlSessionFactory.openSession();
    HashMap<String, Integer> hs = new HashMap<String, Integer>();
    hs.put("uid", uid);
    hs.put("qid", qid);
    
    try
    {
      sqlSession.delete("wkmb.dao.QuestionDao.deleteQuestion", hs);     // QuestionDao.xml의 deleteQuestion 쿼리문으로 해당되는 Question 삭제.
    }catch(Exception e)
    {
      e.printStackTrace();
    }finally
    {
      sqlSession.close();
    }
  }

}
