package com.test.test1.admin.controller;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.admin.dto.AdminETCDto;
import com.test.test1.admin.service.AdminService;
import com.test.test1.algorithm.service.AlgorithmService;
import com.test.test1.board.qna.dto.Criteria;
import com.test.test1.board.qna.dto.PageMaker;
import com.test.test1.user.service.UserService;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.service.VideoService;

@Controller
public class AdminController {
   
   @Autowired
   UserService userService;
   @Autowired
   AlgorithmService algorithmService;
   @Autowired
   AdminService adminService;
   @Autowired
   VideoService videoService;
   
   //모든 관리자 페이지 접근 URL로 불가 - 02.18 장재호
   //일괄처리 안되서 메서드화 후 일괄처리 - 02.21 장재호
   public String access(HttpServletRequest request) {
      //URL접근 차단 - 02.18 장재호
      return request.getHeader("REFERER");
   }
   
   //페이지 불러왔을 때 알고리즘 정보 가져오기 - 02.15 장재호
   //관리자 페이지의 URL 주소 접근 차단 - 02.18 장재호
   @RequestMapping("/admin")
   @ResponseBody
   public ModelAndView adminMain(ModelAndView mv, HttpServletRequest request, HttpSession session) {
      //URL접근 차단 - 02.18 장재호
      if(session.getAttribute("user_id") == null || !session.getAttribute("user_id").equals("admin")) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }      

      //1. 카테고리 순위
      mv.addObject("category", algorithmService.categoryRate());
      //2. 장르 순위
      mv.addObject("genre", algorithmService.genreRate());
      /* 주간 방문자, 매출 차트 추가 - 02.21 장재호 */
      mv.addObject("visit", algorithmService.weeklyVisitor());
      mv.addObject("sales", algorithmService.weeklySales());
      /**********************************/
      //3. 매출
      int total = adminService.getTotalSales() * 15000;
      int daily = adminService.getDailySales() * 15000;      
      mv.addObject("totalSales", total);
      mv.addObject("dailySales", daily);      
      //4. 방문자 수
      int totalVisit = adminService.getTotalVisit();
      int todayVisit = adminService.getTodayVisit();
      mv.addObject("totalVisit", totalVisit);
      mv.addObject("todayVisit", todayVisit);
      /*********************끝*****************************/      
      mv.setViewName("admin/index");
      return mv;               
   }
   
   //전체조회 - 01.31 장재호
   //17일 취합 때 삭제되있는거 롤백(Model쪽도 싹다) - 02.18 장재호
   @RequestMapping("/admin/userlist")
   public ModelAndView userList(ModelAndView mv, Criteria cri, HttpServletRequest request) throws Exception {
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      
      PageMaker pageMaker = new PageMaker();
      pageMaker.setCri(cri); //page, perpagenum 셋팅
      pageMaker.setTotalCount(userService.listCount(cri)); //총 게시글 수 셋팅
      
      mv.addObject("pageMaker", pageMaker);
      mv.addObject("data", userService.list(cri));
      mv.setViewName("/admin/user_list");
      return mv;
   }
   
   //selectbox를 통한 다중 삭제 - 02.18 장재호
   @RequestMapping(value="/admin/userDeletes", method=RequestMethod.POST)
   public String userDeletes(@RequestBody List<Integer> delArr) {
      adminService.deletes(delArr);
      return "redirect:/admin/userlist";
   }
   
   //관리자 VIDEO CRUD를 위한 VIDEO DB페이지 - 02.19 장재호
   // 추천수 오름차순/내림차순을 위한 수정 - 02.21 김범수
   @ResponseBody
   @RequestMapping("/admin/databases/video")
   public ModelAndView videoList(ModelAndView mv, Criteria cri, HttpServletRequest request) throws Exception { // 추천수 오름차순/내림차순을 위한 sort 추가 - 02.21 김범수
      //최종검수(URL접근차단) - 03.06 장재호
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      
      PageMaker pageMaker = new PageMaker();
      pageMaker.setCri(cri); //page, perpagenum 셋팅
      pageMaker.setTotalCount(videoService.adminListCount(cri)); //총 게시글 수 셋팅

      mv.addObject("pageMaker", pageMaker);
      mv.addObject("sort", cri.getSort()); // 추천수 오름차순/내림차순을 위한 sort 추가 - 02.21 김범수
      mv.addObject("data", videoService.adminList(cri)); // 추천수 오름차순/내림차순을 위한 sort 추가 - 02.21 김범수
      mv.setViewName("admin/admin_video");
      return mv;
   }
   
   //Video detail READ - 02.19 장재호
   @RequestMapping("/admin/databases/video/{video_id}")
   public ModelAndView adminVideoDetail(ModelAndView mv, HttpServletRequest request, @PathVariable int video_id) {
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      mv.addObject("data", videoService.detail(video_id));
      mv.setViewName("admin/admin_video_detail");
      return mv;
   }
   
   //VIDEO CREATE PAGE - 02.19 장재호
   @RequestMapping("/admin/databases/video/create")
   public ModelAndView videoCreatePage(HttpServletRequest request, ModelAndView mv) {
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      
      else mv.setViewName("admin/admin_video_create");
      return mv;
   }
   
   //VIDEO CREATE - 02.19 장재호
   @RequestMapping(value="/admin/videoCreate", method=RequestMethod.POST)
   public ModelAndView videoCreate(ModelAndView mv, AdminETCDto dto) {
      if(adminService.check(dto) != null) {
         mv.addObject("error", "중복 된 제목이 존재합니다");
         mv.setViewName("redirect:/admin/databases/video/create");
         return mv;
      }
      //1. 카테고리
      try {
         String category_name = dto.getCategory_name();
         adminService.addCategory(category_name);
         //2. 장르
         String genre_name = dto.getGenre_name();
         adminService.addGenre(genre_name);
         //3. 배우
         String[] actor = dto.getActor_name().split(",");
         adminService.addActor(actor);
         //4. 비디오
         adminService.addVideo(dto);
         //5. 비디오카테고리
         adminService.addVideoCategory(dto);
         //6. 비디오장르 
         adminService.addVideoGenre(dto);
         //7. 비디오액터
         List<String> list = new ArrayList<>();
         for(String a : actor) {
            list.add(a);
         }
         List<Integer> list2 = new ArrayList<>();
         for(int i=0; i<list.size(); i++) {
            list2.add(dto.getVideo_id());
         }
         dto.setActor(list);
         dto.setVideoidx(list2);
         adminService.addVideoActor(dto);   
      }catch(Exception e) {
         e.printStackTrace();
      }

      mv.setViewName("admin/admin_video");
      return mv;
   }
   
   //VIDEO DELETE - 02.19 장재호
   @RequestMapping("/videoDataDelete")
   public String videoDel(int delVideoID) {
      adminService.videoDel(delVideoID);
      return "redirect:/admin/databases/video";
   }
   
   //체크박스 다중삭제 - 02.19 장재호   
   @RequestMapping(value="/admin/videoDataDeletes", method=RequestMethod.POST)
   public String videoDels(@RequestBody List<Integer> delArr) {
      adminService.videoDels(delArr);
      return "redirect:/admin/databases/video";
   }
   
   //비디오 데이터 수정 - 02.19 장재호
   @RequestMapping(value="/videoDataModify", method=RequestMethod.POST)
   public String videoDataModify(ModelAndView mv, VideoDto dto) {
      adminService.videoDataModify(dto);
      return "redirect:/admin/databases/video";
   }

   //관리자 타 TABLE CRUD를 위한  DB페이지 - 02.19 장재호
   @RequestMapping("/admin/databases/others")
   public ModelAndView othersDB(ModelAndView mv, HttpServletRequest request){
      if(access(request) == null) {
         mv.addObject("error", "잘못된 접근입니다");
         mv.setViewName("redirect:/");
         return mv;
      }
      
      mv.addObject("data", adminService.getCategory());
      mv.addObject("datasec", adminService.getGenre());      
      mv.addObject("datathr", adminService.getActor());
      mv.setViewName("admin/admin_otherdb");      
      return mv;
   }
   
   /***************** 카테고리, 장르 추가 및 삭제 - 02.19 장재호 *************/
   @RequestMapping("/admin/addCategory")
   public String addCategory(String category_name) {
      adminService.addCategory(category_name);
      return "redirect:/admin/databases/others";
   }
   
   @RequestMapping("/admin/addGenre")
   public String addGenre(String genre_name) {
      adminService.addGenre(genre_name);
      return "redirect:/admin/databases/others";
   }
   
   @RequestMapping("/admin/addActor")
   public String addActor(String actor_name) {
      adminService.addActorDb(actor_name);
      return "redirect:/admin/databases/others";
   }
   
   @RequestMapping("/admin/delCategory")
   public String delCategory(String category_name) {
      try {
         adminService.delCategory(category_name);
      }catch(Exception e){
         return "redirect:/admin/databases/others";
      }
      return "redirect:/admin/databases/others";
   }
   
   @RequestMapping("/admin/delGenre")
   public String delGenre(String genre_name) {
      try {
         adminService.delGenre(genre_name);
      }catch(Exception e) {
         return "redirect:/admin/databases/others";
      }
      return "redirect:/admin/databases/others";
   }
   
   @RequestMapping("/admin/delActor")
   public String delActor(String actor_name) {
      try {
         adminService.delActor(actor_name);
      }catch(Exception e) {
         return "redirect:/admin/databases/others";
      }
      return "redirect:/admin/databases/others";
   }
   /***************************************************************/
}