package wkmb.control;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import wkmb.dao.FriendDao;
import wkmb.dao.UserDao;
import wkmb.domain.User;

@Controller
@RequestMapping("/wkmb")
public class WKMBControl {
  
  @Autowired
  UserDao userDao;
  
  @Autowired
  FriendDao friendDao;
  
  @RequestMapping(value="/login", method=RequestMethod.POST)
  public String login(String id, String password, HttpSession session)
  {
    User user = userDao.getLoginInfo(id, password);
    if(user != null)
    {
      // 로그인을 성공한다면, 로그인 기본 정보를 세션에 보관한다.
      session.setAttribute("loginInfo", user);
      
      return "redirect:main.wkmb";
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
      model.addAttribute("friendList", friendDao.selectFriendList(user.getUid()));
      model.addAttribute("friendCount", friendDao.selectFriendCount(user.getUid()));
      model.addAttribute("solvedFriend", friendDao.selectSolvedFriend(user.getUid()));
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
      mv.addObject("friendList", friendDao.selectSearchFriendList(user.getUid(), name));
    }
  
    mv.setViewName("./searchFriends.jsp");
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
