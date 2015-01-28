package wkmb.control;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.sun.net.httpserver.HttpsConfigurator;

import wkmb.dao.FriendDao;
import wkmb.dao.QuestionDao;
import wkmb.dao.UserDao;
import wkmb.domain.Friend;
import wkmb.domain.Question;
import wkmb.domain.User;

@Controller
@RequestMapping("/wkmb")
public class WKMBControl {
  
  @Autowired
  UserDao userDao;
  
  @Autowired
  FriendDao friendDao;
  
  @Autowired
  QuestionDao questionDao;
  
  // 현재 프로젝트 경로를 알기위해 선언
  @Autowired
  ServletContext context;
  
  @RequestMapping(value="/login", method=RequestMethod.POST)
  public String login(String id, String password, HttpSession session)
  {
    User user = userDao.getLoginInfo(id, password);
    if(user != null)
    {
      // 로그인을 성공한다면, 로그인 기본 정보를 세션에 보관한다.
      session.setAttribute("loginInfo", user);
      
      return "redirect:./main.wkmb";
    }else
    {
      return "redirect:../";
    }
    
  }
  
  @RequestMapping("/check")
  public ModelAndView check(String id)
  {
    ModelAndView mv = new ModelAndView();
    
    if(userDao.exist(id))   // 존재할 경우
    {
      mv.addObject("checkId", id);
    }
  
    mv.setViewName("./check.jsp");
    return mv;
  }
  
   //http://localhost:8080/WhoKnowsMeBest/member/signUp.do
   @RequestMapping(value="/signUp", method=RequestMethod.POST)
   public String signUp(User user)
   {
     try
     {
       userDao.insert(user);
     }catch(Exception e)
     {
       e.printStackTrace();
     }
     return "redirect:../";
   }
 
  @RequestMapping("/main")
  public String main(Model model, HttpSession session)
  {
    User user = (User)(session.getAttribute("loginInfo"));

    if(user != null)
    {
      // 메인 화면 가운데에 나오는 프로필들을 출력하기 위한 속성 추가. 날짜, 점수 순으로 내림차순 정렬을 DB에서 함.
      model.addAttribute("friendProfile", friendDao.selectFriendListByDate(user.getUid()));
      // 메인 화면 오른쪽에 있는 친구창에 나오기 위한 친구 목록, 친구 이름, 아이디순으로 정렬을 함
      model.addAttribute("friendList", friendDao.selectFriendList(user.getUid()));
      // 메인 
      model.addAttribute("friendCount", friendDao.selectFriendCount(user.getUid()));
      model.addAttribute("solvedFriend", friendDao.selectSolvedFriend(user.getUid()));
      
      // 마지막으로 푼 날짜가 오늘의 전이라면 threeTime을 초기화 한다.
      List<Friend> clearFriendList = friendDao.selectClearFriendList(user.getUid());
      Date today = new Date();
      Date lastDate;
      for (Friend friend : clearFriendList) {
        lastDate = friend.getLastDate();
        if(lastDate == null)
          break;
        if(today.getYear() != lastDate.getYear()
            || today.getMonth() != lastDate.getMonth() || today.getDate() != lastDate.getDate())
          friendDao.updateClearThreeTime(friend.getUid(), user.getUid());
      }
    }
    /*
     * 내 친구들 리스트를 가져옴!
     */

    return "/wkmb/main.jsp";
  }
  
  @RequestMapping("/logout")
  public String logout(HttpSession session)
  {
    session.invalidate();
    
    return "redirect:../";
  }
  
  @RequestMapping("/addFriend")
  public ModelAndView addFriend(String fid, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)session.getAttribute("loginInfo");
    
    if(friendDao.insertFriend(fid, user.getUid()))
      mv.addObject("checkId", fid);
  
    mv.setViewName("./check.jsp");
    return mv;
  }
  
  @RequestMapping("/searchFriends")
  public ModelAndView searchFriends(String name, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));

    if(user != null)
    {
      // 메인 화면 가운데에 나오는 프로필들을 출력하기 위한 속성 추가. 날짜, 점수 순으로 내림차순 정렬을 DB에서 함.
      mv.addObject("friendProfile", friendDao.selectSearchFriendList(user.getUid(), name));
    }
  
    mv.setViewName("./searchFriends.jsp");
    return mv;
  }
  
  @RequestMapping("/myPage")
  public ModelAndView myPage(String id, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    

    if(user != null)
    {
      int pageUid = userDao.selectUserUid(id);
      
      mv.addObject("friendList", friendDao.selectFriendList(user.getUid()));
      mv.addObject("pageUser", userDao.selectOne(pageUid));
      mv.addObject("pageFriendList", friendDao.selectFriendListByScore(pageUid));
    }

    mv.setViewName("./myPage.jsp");
    return mv;
  }
  
  @RequestMapping("/requestAccept")
  public ModelAndView requestAccept(int fuid, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    

    if(user != null)
    {
      friendDao.updateFriend(user.getUid(), fuid);  // 내 친구 모드도 0으로
      friendDao.updateFriend(fuid, user.getUid());  // 친구의 나에 대한 모드도 0으로!
      mv.addObject("friendList", friendDao.selectFriendList(user.getUid()));
    }

    mv.setViewName("./requestFriendList.jsp");
    return mv;
  }
  
  @RequestMapping("/requestDeny")
  public ModelAndView requestDeny(int fuid, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    

    if(user != null)
    {
      friendDao.deleteFriend(user.getUid(), fuid);  // 내 친구 요청 목록에서 삭제
      friendDao.deleteFriend(fuid, user.getUid());  // 친구도 나를 신청 목록에서 삭제
      mv.addObject("friendList", friendDao.selectFriendList(user.getUid()));
    }

    mv.setViewName("./requestFriendList.jsp");
    return mv;
  }
  
  @RequestMapping("/changeMyPhoto")
  public void changeMyPhoto(MultipartFile photo, HttpSession session)
  {
    User user = (User)session.getAttribute("loginInfo");
    String realPath = context.getRealPath("/files");
    String fileName = "photo_" + System.currentTimeMillis();
    
    // 원래 있던 파일이 non-photo.png가 아니면 삭제
    String oriFileName = user.getPhoto();
    if(!oriFileName.equals("non-photo.png"))
      new File(realPath +"/" + oriFileName).delete();
    
    try
    {
      photo.transferTo(new File(realPath +"/" + fileName));
      user.setPhoto(fileName);  // 세션의 loginInfo의 photo값을 수정 즉, 세션의 값을 수정
      userDao.updateUser(user);
    }catch(Exception e)
    {
      e.printStackTrace();
    }
  }
  
  @RequestMapping("/deleteMyPhoto")
  public void deleteMyPhoto(HttpSession session)
  {
    User user = (User)session.getAttribute("loginInfo");
    String realPath = context.getRealPath("/files");
    
 // 원래 있던 파일이 non-photo.png가 아니면 삭제
    String oriFileName = user.getPhoto();
    if(!oriFileName.equals("non-photo.png"))
      new File(realPath +"/" + oriFileName).delete();
    
    try
    {
      user.setPhoto("non-photo.png");  // 세션의 loginInfo의 photo값을 수정 즉, 세션의 값을 수정
      userDao.updateUser(user);
    }catch(Exception e)
    {
      e.printStackTrace();
    }
  }
  
  // 사진을 변경 시 프로필을 ajax로 리프레쉬 하기 위해서
  @RequestMapping("/changeMyProfile")
  public String changeMyProfile()
  {
    return "./changeMyProfile.jsp";
  }
  
  @RequestMapping("/changeMyMessage")
  public void changeMyMessage(String message, HttpSession session)
  {
    User user = (User)session.getAttribute("loginInfo");
    
    try
    {
      user.setMessage(message);  // 세션의 loginInfo의 message값을 수정 즉, 세션의 값을 수정
      userDao.updateUser(user);
    }catch(Exception e)
    {
      e.printStackTrace();
    }
  }
  
  @RequestMapping("/solve")
  public ModelAndView solve(String id, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    int uid = userDao.selectUserUid(id);
    User questionUser = userDao.selectOne(uid);
    User user = (User)session.getAttribute("loginInfo");
    
    if(uid != 0)
    {
      if(friendDao.selectThreeTime(uid, user.getUid()) >= 3)
      {
        mv.setViewName("redirect:./main.wkmb");
        return mv;
      }
      
      List<Question> tmp_questionList = questionDao.selectQuestionList(uid);
      List<Question> questionList = new ArrayList<Question>();
      
      if(tmp_questionList.size() == 0)
        questionList = null;
      else
      {
        // 문제 랜덤하게 5개 받아오기
        for(int i = 0; i< 5; i++)
        {
          questionList.add(tmp_questionList.get((int)(Math.random() * tmp_questionList.size())));
          
          for(int j = 0; j< i; j++)
            if(questionList.get(i) == questionList.get(j))
            {
              questionList.remove(i);
              i--;
              break;
            }
        }
        
        // threeTime 1 증가
        friendDao.updateCountThreeTime(uid, user.getUid());
      }
      
      session.setAttribute("questionUser", questionUser);
      session.setAttribute("questionList", questionList);
      
      mv.addObject("questionList", questionList);
      mv.addObject("questionUser", questionUser);
    }

    mv.setViewName("./solve.jsp");
    return mv;
  }
  
  @RequestMapping("/answer")
  public ModelAndView sumbit(String[] answer, HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User questionUser = (User)session.getAttribute("questionUser");
    List<Question> questionList = (List<Question>)session.getAttribute("questionList");
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(answer == null)
    {
      mv.setViewName("./main.wkmb");
      return mv;
    }
    
    if(questionUser != null)
    {
      session.removeAttribute("questionUser");
      session.removeAttribute("questionList");
      
      int currectCount = 0;
      for(int i = 0; i< questionList.size(); i++)
        if((questionList.get(i)).getAnswer().equalsIgnoreCase(answer[i]))
          currectCount++;
      
      friendDao.updateScore(questionUser.getUid(), user.getUid(), currectCount);
      
      mv.addObject("questionUser", questionUser);
      mv.addObject("questionList", questionList);
      mv.addObject("answer", answer);
      mv.addObject("currectCount", currectCount);
      mv.addObject("user", user);
      
    }
    
    mv.setViewName("./answer.jsp");
    return mv;
  }
  
  @RequestMapping("/make")
  public ModelAndView make(HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(user != null)
    {
      mv.addObject("questionList", questionDao.selectQuestionList(user.getUid()));
    }
    
    mv.setViewName("./make.jsp");
    return mv;
  }
  
  @RequestMapping(value="/confirmMake", method=RequestMethod.POST)
  public String confirmMake(String[] question, String[] answer, HttpSession session)
  {
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(question.length< 5 || answer.length< 5)
    {
      return "./myPage.wkmb?id=" + user.getId();
    }
    
    return "./myPage.wkmb?id=" + user.getId();
  }
  
  @RequestMapping("/reloadMyProfile")
  public ModelAndView reloadMyProfile(HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(user != null)
      mv.addObject("solvedFriend", friendDao.selectSolvedFriend(user.getUid()));
    
    mv.setViewName("./reloadMyProfile.jsp");
    return mv;
  }
  
  @RequestMapping("/reloadApplyFriendList")
  public ModelAndView reloadApplyFriendList(HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(user != null)
      mv.addObject("friendList", friendDao.selectFriendList(user.getUid()));
    
    
    mv.setViewName("./reloadApplyFriendList.jsp");
    return mv;
  }
  
  @RequestMapping("/reloadFriendProfile")
  public ModelAndView reloadFriendProfile(HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(user != null)
    {
      mv.addObject("solvedFriend", friendDao.selectSolvedFriend(user.getUid()));
      mv.addObject("friendProfile", friendDao.selectFriendListByDate(user.getUid()));
      mv.addObject("friendCount", friendDao.selectFriendCount(user.getUid()));
    }
    
    
    mv.setViewName("./reloadApplyFriendList.jsp");
    return mv;
  }
  
  @RequestMapping("/reloadFriendList")
  public ModelAndView reloadFriendList(HttpSession session)
  {
    ModelAndView mv = new ModelAndView();
    User user = (User)(session.getAttribute("loginInfo"));
    
    if(user != null)
      mv.addObject("friendList", friendDao.selectFriendList(user.getUid()));
    
    
    mv.setViewName("./reloadApplyFriendList.jsp");
    return mv;
  }
  
  
//  @RequestMapping("/applyFriend")
//  public ModelAndView applyFriend(String id)
//  {
//    ModelAndView mv = new ModelAndView();
//    
//    if(FriendDao.exist(id))   // 존재할 경우
//    {
//      mv.addObject("checkId", id);
//    }
//  
//    mv.setViewName("./check.jsp");
//    return mv;
//  }
  
//  // http://localhost:8080/WhoKnowsMeBest/member/signUp.do
//  @RequestMapping("/회원정보 수정할때 쓸거")
//  public String signUp(User user, MultipartFile file)
//  {
//    String realPath = context.getRealPath("/files");
//    String fileName = "photo_" + System.currentTimeMillis();
//    
//    try
//    {
//      file.transferTo(new File(realPath +"/" + fileName));
//      user.setPhoto(fileName);
//      usersDao.insert(user);
//    }catch(Exception e)
//    {
//      e.printStackTrace();
//    }
//    return "redirect:../index.html";
//  }
  
  
  

//  
//  @RequestMapping("/mypage")
//  public String myPage(Model model)
//  {
////    model.addAttribute("friendList", friendsDao.);
//    /*
//     * 친구목록과 요청 랭킹 나오게!
//     */
//    
//    model.addAttribute("userList", usersDao);
//    
//    return "/wkmb/mypage.jsp";
//  }
//  
//  /**
//   * 이 메소드는 유저의 이름과 문제를 알아내온다.
//   * 
//   * 다구현하고나서 나중에는 친구목록에 있는 친구의 문제풀리고
//   * 들어온 것인지 확인하는 작업도 처리할 것.
//   * @param model
//   * @param user
//   * @param qid
//   * @return
//   */
//  @RequestMapping("/solve")
//  public String solve(Model model, User user, int qid)
//  {
////    int uid = userDao.;
//    /*
//     * 유저의 uid를 알아내서 퀴즈를 구하기 위해 저장
//     * 이거 나중에 퀴즈다오의 파라미터에 직접적으로 넣어버릴거
//     */
//    
//    model.addAttribute("user", usersDao);
//    /*
//     * 유저의 이름을 알아내기 위해서
//     */
//    model.addAttribute("question", qustionsDao);
//    /*
//     * 퀴즈 받아오기 위해서
//     */
//    
//    
//    return "/wkmb/solve.jsp";
//  }
//  
//  @RequestMapping("/answer")
//  public String answer(Model model, User user)
//  {
//    model.addAttribute("questionList", qustionsDao);
//    /*
//     * uid로 그 사람에 대한 퀴즈를 리스트로 받아옴.
//     */
//    
//    return "/wkmb/answer.jsp";
//  }
//  
//  @RequestMapping("/make")
//  public String make(Model model, User user)
//  {
////    int uid = userDao.;
//    /*
//     * 유저의 uid를 알아내서 퀴즈를 구하기 위해 저장
//     * 이거 나중에 퀴즈다오의 파라미터에 직접적으로 넣어버릴거
//     */
//    
//    model.addAttribute("user", usersDao);
//    /*
//     * 유저의 이름을 알아내기 위해서
//     */
//    model.addAttribute("question", qustionsDao);
//    /*
//     * 퀴즈 받아오기 위해서
//     */
//    
//    
//    return "/wkmb/make.jsp";
//  }
  
  
  

  

  

}
