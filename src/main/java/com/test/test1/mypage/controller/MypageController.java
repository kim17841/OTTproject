package com.test.test1.mypage.controller;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.test.test1.algorithm.service.AlgorithmService;
import com.test.test1.mypage.dto.ImgDto;
import com.test.test1.user.dao.UserDao;
import com.test.test1.user.dto.UserDto;
import com.test.test1.user.service.UserService;
import com.test.test1.video.dto.VideoDto;
import com.test.test1.video.service.RentalService;
import com.test.test1.video.service.VideoService;

@Controller
@RequestMapping("mypage/**")
public class MypageController {
   
   @Autowired
   UserService userService;
   @Autowired
   UserDao userDao;
   @Autowired
   RentalService rentalService;
   @Autowired 
   VideoService videoService;
   @Autowired 
   AlgorithmService algorithmService;
   

   // 회원정보가진 개인정보페이지 연결  23/02/16 김지혜 
      @RequestMapping(value= "/info_mydetail")
      public ModelAndView detail(HttpSession session, ModelAndView mv) {
         // 유저 아이디를 통해 세션에서 정보 가져오기 
         String user_id =(String) session.getAttribute("user_id").toString();
         UserDto dto = userService.detail(user_id); // 회원 ID를 사용하여 해당 회원의 정보를 찾아 dto에 넣는다.
         mv.addObject("data", dto); // 위에서 받은 회원정보를 model을 통해 view에 보내준다.;
         //////////////////////////////////////////////////////////////////
         List<VideoDto> list = rentalService.list(user_id);
         mv.addObject("dto", list);
         //////////////////// 02.27 시청기록 구현 - 김범수 //////////////////////
         List<VideoDto> userlist = algorithmService.userlist(user_id);
         mv.addObject("userlist", userlist);
         mv.setViewName("mypage/mydetail");
         return mv;       
      }   
      
      // VIEW에서 받아온 값을 이용하여 수정페이지  _ 23/02/18~ 23/02/20수정_ 김지혜
      @RequestMapping(value="/info_modify", method=RequestMethod.GET)
      public ModelAndView detailModify(HttpSession session, ModelAndView mv) {
      // 세션에서 정보가져오기 
         String user_id = (String) session.getAttribute("user_id").toString();
         UserDto list = userService.detail(user_id);
         mv.addObject("list", list);
         mv.setViewName("mypage/info_modify");
         return mv;
      }   
      
      // VIEW에서 받아온 값을 이용하여 수정페이지  _ 23/02/18~ 
      @RequestMapping(value="/info_modify", method=RequestMethod.POST)
      public String detailModify(@ModelAttribute UserDto dto, HttpSession session) {
         // 재 입력된 값을 받아 db 저장. (수정된 내용이던, 수정되지 않은 내용이던 수정하기 버튼을 누르면 디비에 새롭게 update되도록 처리)
         dto.setId((String) session.getAttribute("user_id"));      
         userService.infoModify(dto);         
         return "redirect:/mypage/info_mydetail";
      }
      
      
      // 프로필 구현 02.24 김범수
      @RequestMapping(value="upload", produces = MediaType.APPLICATION_JSON_VALUE)
      public ResponseEntity<ImgDto> test(MultipartFile uploadFile, ImgDto dto, HttpSession session, ModelAndView mv) { 
         String id = (String) session.getAttribute("user_id");
         
         /* 이미지 파일 체크 */
         File checkfile = new File(uploadFile.getOriginalFilename());
         String type = null;
         try {
            type = Files.probeContentType(checkfile.toPath());
         } catch (IOException e) {
            e.printStackTrace();
         }
         
         SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-"); // Date 객체로 날짜 경로 만들기 - 파일이 많아지면 부담이 생김
         Date date = new Date();
         String str = sdf.format(date);
         String datePath = str.replace("-", File.separator);
         
         String uploadFolder = "C:\\upload\\"; // 처음 경로 설정
         File uploadPath = new File(uploadFolder, datePath); // 파일 생성 메소드 

         if(uploadPath.exists() == false) { 
            uploadPath.mkdirs();
         }

         // 파일 이름
         String uploadFileName = uploadFile.getOriginalFilename();
         dto.setFileName(uploadFileName);
         dto.setUploadPath(datePath);
            
         /* uuid 적용 파일 이름 */
         String uuid = UUID.randomUUID().toString();
         uploadFileName = uuid + "_" + uploadFileName;
         dto.setUuid(uuid);
         
         String saveFilestr = uploadPath + "\\" + uploadFileName;
         File saveFile = new File(uploadPath + "\\", uploadFileName); 
            
         try {
            uploadFile.transferTo(saveFile); // saveFile을 저장
            dto.setSaveFileStr(saveFilestr);
            dto.setId(id);
            userService.img_update(dto);
         } catch (IOException e) {
            e.printStackTrace();
         }
         ResponseEntity<ImgDto> result = new ResponseEntity<ImgDto>(dto, HttpStatus.OK);
      
         return result;      
      }
      
      @RequestMapping(value = "display")
      public ResponseEntity<byte[]> display(String fileName) throws FileNotFoundException {
          File file = new File(fileName);
          if (!file.exists() || !file.canRead()) {
              throw new FileNotFoundException("The file '" + fileName + "' 을 찾을수 없습니다.");
          }
          ResponseEntity<byte[]> result = null;

          try {
              HttpHeaders header = new HttpHeaders();
              header.add("Content-type", Files.probeContentType(file.toPath()));// 파일 확장자 명이 들어감
              result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, HttpStatus.OK);

          } catch (IOException e) {
              e.printStackTrace();
          }

          return result;
      }
      
      // 프로필 로드 - 02.27 김범수
      @RequestMapping(value="onload", produces = MediaType.APPLICATION_JSON_VALUE)
      public ResponseEntity<String> onload(String uploadFile) {
         ResponseEntity<String> result = new ResponseEntity<String>(uploadFile, HttpStatus.OK);
         return result;      
      }

}
