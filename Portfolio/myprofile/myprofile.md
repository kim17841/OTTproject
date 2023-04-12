### 4.5. 내 프로필 업로드 기능
<details>
<summary> <b>기능 설명</b> </summary>

  - 프로필 변경버튼을 누르면 파일 선택이 진행되어 사용자가 선택한 이미지로 프로필이 바뀜.

  - 변경된 프로필은 사용자가 로그인하는 동안에 다른 페이지에서도 상단에 이미지가 유지.

</details>
  
<details>

  <summary> <b>JSP</b> </summary>

  
- 사용자가 프로필을 변경하면 JS를 통해 form태그에 해당 이미지를 Controller로 전송합니다.
- 사용자가 설정해 놓은 이미지가 없을 경우 기본 이미지를 출력합니다.
- 설정한 이미지가 있을 경우 내 페이지와 다른 페이지 상단에 프로필 이미지를 출력합니다.
- 사용자가 영상에 댓글을 남기면 설정한 프로필이 나옵니다.

  <details>
    <summary> <b>네비바 이미지 출력</b> </summary>

 
    ```
    <!-- 상단에 프로필 이미지 출력 -->
    (...생략...)
    <c:choose>
        <!-- 사용자가 변경한 이미지가 있을 경우 -->
        <c:when test="${img != null && img != ''}">
            <img src="${img}" id="img_onload" class="img_tag"> 
        </c:when>
        <!-- 사용자가 변경한 이미지가 없을 경우 -->
        <c:when test="${img == null}">
            <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4
            _L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
        </c:when>
    </c:choose>
    (...생략...)
    ```

  </details>
    <details>
    <summary> <b>프로필 이미지 등록/변경</b> </summary>

    
    ```
    <!-- 내 페이지 프로필 변경-->
    (... 생략...)
    <div class="left-side">
    <!-- 프로필 기능 -->
        <c:choose>
            <!-- 사용자가 설정한 이미지가 있을 경우 -->
            <c:when test="${data.img != null && data.img != ''}">
                <img src="${data.img}" id="img_onload" class="img_tag"> 
            </c:when>
            <!-- 사용자가 설정한 이미지가 없을 경우 - 기본이미지 -->
            <c:when test="${data.img == null}">
                <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1gg
                I4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="img_tag">
            </c:when>
        </c:choose>
        <!-- 프로필 변경 버튼 - input type을 display : none하고 label로 연결 -->
        <div class="input_file_box">
            <label class="input_button" for="uploadFile">프로필 변경</label>
            <input type="file" name='uploadFile' id="uploadFile">
        </div>
    </div>
    (... 생략...)
    ```

  </details>
  
     <details>
    <summary> <b>댓글 프로필 출력</b> </summary>

    
    ```
    <!-- 내 페이지 프로필 변경-->
    (... 생략...)
    <div class="left-side">
  <!-- 댓글에 사용자의 프로필 이미지 출력 -->
  <div class="user_img_area">
      <c:choose>
          <!-- 컨트롤러에서 리턴한 이미지를 받고 ready를 통해 함수 호출 -> 이미지 출력 -->
          <c:when test="${comt.img != null && comt.img != ''}">
              <img src="${comt.img}" class="com_img">
          </c:when>
          <c:when test="${comt.img == null}">
              <img src="https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1gg
              I4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU" class="default_img">
          </c:when>
      </c:choose>
  </div>
    ```
  </details>

</details>

<details>
<summary> <b>Javascript</b> </summary>

- 사용자가 파일 선택을 진행하면 해당 파일이 이미지인지 검사 후에 AJAX로 Controller에 전달을 진행합니다.
- ResponseEntity로 반환 받은 이미지 경로를 encoding해서 쿼리스트링으로 display 메소드를 호출, 이미지를 출력합니다.
- 위와 같은 방식으로 네비바, 댓글에도 이미지를 상시 출력합니다.
  <details>
  <summary> <b>네비바 이미지 출력</b> </summary>

  ```javascript
	// 네비바 이미지 로딩 위한 함수
	$(function() {
		$('.img_tag').ready(function() {
			$.ajax({
				url : '/user/navbarImg2',
				dataType : 'text',
				success : function(result2) {
					if(result2 == "" || result2 == null){return}
					let fileCallPath = encodeURI(result2); // 해당 파일의 이름
					$('.img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
				}
			});
		})
	});

	  ```

	  </details>
	  <details>
	  <summary> <b>프로필 이미지 등록/변경</b> </summary>

	  ```javascript
	//파일 선택 후 이미지인지 점검 -> ajax로 Controller에 전송
	$(function() {
		$("input[type='file']").on("change", function(e){
			// formData 객체 선언 - 이미지 파일을 전송하기 위함
			let formData = new FormData();
			// 사용자가 선택한 파일
			let fileInput = $('input[name="uploadFile"]'); 
			let fileList = fileInput[0].files; // 첫번째 선택한 파일
			let fileObj = fileList[0]; // 파일 객체

			// 이미지인지 파일 체크, 용량 체크 
			if(!fileCheck(fileObj.name, fileObj.size)){
				return false;
			}

			// formData 객체에 해당 파일 추가(uploadFile로 이름 설정)
			formData.append("uploadFile", fileObj); 

			$.ajax({
				url: '/mypage/upload',
		    processData : false,
		    contentType : false,
		    data : formData, 
		    type : 'POST',
		    dataType : 'json', // 제이슨타입으로 formData를 전달
		    success : function(result) {
					showUploadImage(result);  //이미지 출력 함수
				},
		    error : function(result){
			alert("이미지 파일이 아닙니다.");
		    }
			});
		});
	});

	  // 이미지인지 파일 체크, 용량 체크 
	  function fileCheck(fileName, fileSize){
	      let regex = new RegExp("(.*?)\.(jpg|png)$"); 
	      let maxSize = 1048576; //1MB

	      if(fileSize >= maxSize){ // 파일 사이즈 검사
		  alert("파일 사이즈 초과");
		  return false;
	      }

	      if(!regex.test(fileName)){ // 이미지가 아닌 파일 잡는것
		  alert("해당 종류의 파일은 업로드할 수 없습니다.");
		  return false;
	      }
	      return true;		
	  }

	  //이미지 등록후 프로필을 출력하기 위한 함수
	  function showUploadImage(result){
	      // 전달받은 데이터가 값이 없는 경우
	      if(result == "" || result == null){return} 
	      // fileCallPath에 리턴받은 해당 이미지 경로를 encoding
	      let fileCallPath = encodeURI("C:\\upload\\"+result.uploadPath + result.uuid + 
	      "_" + result.fileName); // 해당 파일의 이름
	      // src 경로 값으로 쿼리스트링과 encoding한 이미지 경로를 설정 
	      // -> display 메소드 호출하면서 파라미터 fileName의 값을 encoding한 
	      // 이미지 경로를 부여
	      $('.img_tag').attr('src', "/mypage/display?fileName=" + fileCallPath);
	  }

	  //이미지 상시 출력을 위한 함수 
	  $(function() {
	      $("#img_onload").ready(function(){
		  let formData = new FormData();
		  // fileInput : 이미지 태그의 src값 
		  // - Controller에서 리턴한 이미지의 절대 경로를 담고 있음
		  let fileInput = $('#img_onload').attr('src');
		  // formData 객체에 해당 파일 추가(uploadFile로 이름 설정) 
		  formData.append("uploadFile", fileInput); 

		  $.ajax({
		      url: '/mypage/onload',
		  processData : false,
		  contentType : false,
		  data : formData, 
		  type : 'POST',
		  dataType : 'text', 
		      // 제이슨타입으로 formData를 전달 - ResponseEntity 타입이 String이기 때문
		  success : function(result) {
			  showOnloadImage(result);  //이미지 상시 출력 메서드
		      },
		  error : function(result){
			  alert("이미지 파일이 아닙니다.");
		  }
		  });
	      });
	  });

	  //이미지 로딩 위한 함수
	  function showOnloadImage(result){
	      // 전달받은 데이터가 값이 없는 경우
	      if(result == "" || result == null){return}
	      let fileCallPath = encodeURI(result); // 이미지 절대 경로를 encoding
	      $('#img_onload').attr('src', "/mypage/display?fileName=" + fileCallPath);
	  }

  ```

  </details>
   <details>
  <summary> <b>댓글 이미지 출력</b> </summary>

  ```javascript
  // 원댓글 이미지 출력
  $(function() {
      $('.com_img').ready(function() {
          let fileInput = document.querySelectorAll('.com_img');
          for(let i = 0; i < fileInput.length; i++){
              let formData = new FormData();
              formData.append("uploadFile", fileInput[i].currentSrc);
              $.ajax({
                  url: '/mypage/onload',
              processData : false,
              contentType : false,
                  data : formData,
              type : 'POST',
                  dataType : 'text',
                  success : function(result2) {
                      if(result2 == "" || result2 == null){return}
                      let fileCallPath = encodeURI(result2); // 해당 파일의 이름
                      fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
                  }
              });
          }
      })
  });

  // 대댓글 이미지 출력
  function imgOnload() {
      $('.cocom_img').ready(function() {
          let fileInput = document.querySelectorAll('.cocom_img');
          for(let i = 0; i < fileInput.length; i++){
              let formData = new FormData();
              formData.append("uploadFile", fileInput[i].currentSrc);
              $.ajax({
                  url: '/mypage/onload',
              processData : false,
              contentType : false,
                  data : formData,
              type : 'POST',
                  dataType : 'text',
                  success : function(result2) {
                      if(result2 == "" || result2 == null){return}
                      let fileCallPath = encodeURI(result2); // 해당 파일의 이름
                      fileInput[i].src = "/mypage/display?fileName=" + fileCallPath;
                  }
              });
          }
      });
  }

  // 대댓글 형성후 - 이미지 로딩
  (... 생략...)
  cocomText += "<tr>";
      if(this.img != null && this.img != '') {
          cocomText += "<td class='cocom_title text'>"
          cocomText += "	<div class='user_img_area'>"
          cocomText += "		<img src='" + this.img + "' class='cocom_img'>"
          cocomText += "	</div>"
      }
      else {
          cocomText += "<td class='cocom_title text'>"
          cocomText += "	<div class='user_img_area'>"
          cocomText += "		<img src='https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQxmp7sE1ggI4_L7NGZWcQT9EyKaqKLeQ5RBg&usqp=CAU' 
              				class='img_tag2'>"
          cocomText += "	</div>"
      }
  (... 생략...)
  cocomText += "</td>"
  (... 생략...)
  imgOnload();

  ```

  </details>
  
</details>

<details>
<summary> <b>Controller</b> </summary>

- 프로필 이미지를 경로, 날짜, uuid를 설정하고, 파일 명에 합쳐 Service에 전달합니다.
- upload 메소드 : 경로 설정을 끝낸 이미지 파일을 ResponseEntity 객체로 변환하여 리턴합니다.
- display 메소드 : 경로가 부여된 이미지 파일을  깊은 복사를 한 후 헤더 설정과 HTTP 상태 코드를  ResponseEntity 객체에 담아 리턴하여 이미지를 view에 출력합니다.
- onload 메소드 : 절대 경로가 담긴 이미지 파일을 ResponseEntity 객체에 HTTP 상태 코드를 같이 담아서 리턴합니다.
- 네비바 이미지 출력은 onload 메소드처럼 리턴한 후 display메소드를 호출해 이미지를 출력한다.

  <details>
  <summary> <b>네비바 이미지 출력</b> </summary>

  ```java
	// 네비바 프로필 이미지 호출
	@RequestMapping(value={"navbarImg1", "navbarImg2"}, produces = MediaType.APPLICATION_JSON_VALUE)
	public ResponseEntity<String> navbarImg(HttpSession session, UserDto dto, 
					HttpServletRequest request) {
		String requestUrl = request.getRequestURL().toString(); 
		// 매핑값마다 실행되는 코드를 다르게 하기 위해 HttpServletRequest 객체로 매핑 조정
		if(requestUrl.contains("navbarImg1")) { // 네비바1에서의 프로필 로딩
			String id =(String) session.getAttribute("user_id").toString();
			String img = userService.navbarImg(id); 
			// 아이디 정보를 통해서 해당 사용자의 프로필 경로를 받아옴
			// 이미지 값을 ResponseEntity로 변환
			// -> 프로필 이미지 절대 경로와 HTTP 상태 코드를 객체에 넣음
			ResponseEntity<String> result1 = new ResponseEntity<String>(img, HttpStatus.OK); 
			return result1;
		}
		else { // 네비바2에서의 프로필 로딩
			String id =(String) session.getAttribute("user_id").toString();
			String img = userService.navbarImg(id);
			ResponseEntity<String> result2 = new ResponseEntity<String>(img, HttpStatus.OK);
			return result2;
		}
	}

  ```

  </details>

  <details>
  <summary> <b>프로필 이미지 등록/변경</b> </summary>

   ```java

	  // 프로필 등록
	  @RequestMapping(value="upload", produces = MediaType.APPLICATION_JSON_VALUE)
	  public ResponseEntity<ImgDto> test(MultipartFile uploadFile, ImgDto dto, HttpSession session, ModelAndView mv) { 
	      // 세션에 저장된 사용자의 아이디 변수 id에 저장
	      String id = (String) session.getAttribute("user_id"); 

	      // 이미지 파일 체크
	      File checkfile = new File(uploadFile.getOriginalFilename()); // 파일명을 불러옴
	      String type = null;
	      try {
		  type = Files.probeContentType(checkfile.toPath()); 
		  // 해당 파일의 확장자를 불러옴, 확장자가 없으면 type은 null값을 반환
	      } catch (IOException e) {
		  e.printStackTrace();
	      }
	      // Date 객체로 날짜 경로 만들기 
	      // - 하나의 파일에 파일이 많아지면 데이터 관리에 부담이 생김		
	      SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd-"); 
	      // 뒤에 '-'을 더 붙인 이유 : 날짜와 파일명을 구분하기 위함
	      Date date = new Date();
	      String str = sdf.format(date); // yyyy-MM-dd 형식으로 날짜가 들어감
	      // '-'를 separator(파일 구분자)로 나눠 놓음 
	      // -> 2023 - 02 - 24 형식으로 폴더를 만들기 위함
	      String datePath = str.replace("-", File.separator);  

	      String uploadFolder = "C:\\upload\\"; // 처음 경로 설정
	      File uploadPath = new File(uploadFolder, datePath); 
	      // 파일 생성 클래스 -> 파일 객체 생성

	      if(uploadPath.exists() == false) { // 해당 경로에 파일이 없으면 파일 생성
		      uploadPath.mkdirs();
	      }

	      // 파일 이름
	      String uploadFileName = uploadFile.getOriginalFilename();
	      dto.setFileName(uploadFileName);
	      dto.setUploadPath(datePath);

	      // uuid적용한 파일 이름
	      String uuid = UUID.randomUUID().toString(); 
	      // uuid 생성, 파일을 구분하는 키값을 생성하기 위함
	      uploadFileName = uuid + "_" + uploadFileName;
	      dto.setUuid(uuid);

	      String saveFilestr = uploadPath + uploadFileName;
	      File saveFile = new File(uploadPath, uploadFileName); 

	      try {
		  uploadFile.transferTo(saveFile); // saveFile을 저장
		  dto.setSaveFileStr(saveFilestr);
		  dto.setId(id);
		  userService.img_update(dto); 
		  // 해당 사용자의 아이디에 프로필 이미지 경로를 등록하기 위함
	      } catch (IOException e) {
		  e.printStackTrace();
	      }

	      // ResponseEntity 객체로 HTTP 상태 코드와 이미지 경로를 저장
	      ResponseEntity<ImgDto> result = new ResponseEntity<ImgDto>(dto, 
	      HttpStatus.OK); 

	      return result;		
	  }

	  // 이미지 출력 메소드
	  @RequestMapping(value = "display")
	  public ResponseEntity<byte[]> display(String fileName) 
			  throws FileNotFoundException { // 이미지 파일을 바이트 배열로 받아옴

	      File file = new File(fileName);
	      if (!file.exists() || !file.canRead()) { // 파일이 없는 경우
		  throw new FileNotFoundException("The file '" + fileName + "' 을 찾을수 없습니다.");
	      }
	      ResponseEntity<byte[]> result = null; // ResponseEntity 객체 초기화

	      try {
		  HttpHeaders header = new HttpHeaders(); // HttpHeaders 객체 생성
		  header.add("Content-type", Files.probeContentType(file.toPath())); 
		  // 헤더 객체에 Content-type을 파일 확장자로 설정 
		  // ResponseEntity 객체에 이미지 바이트 배열화된 파일 복사한 것과  
		  // HttpHeaders 객체, HTTP 상태 코드를 담음
		  result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file), header, 
		  HttpStatus.OK);
	      } catch (IOException e) {
		  e.printStackTrace();
	      }
	      return result;
	  }

	  // 프로필 상시 
	  @RequestMapping(value="onload", produces = MediaType.APPLICATION_JSON_VALUE)
	  public ResponseEntity<String> onload(String uploadFile) { 
	      // 절대 경로로 된 이미지를 HTTP 상태 코드와 함께  ResponseEntity 객체에 담음
	      ResponseEntity<String> result = new ResponseEntity<String>(uploadFile, 
	      HttpStatus.OK);
	      return result;		
	  }
   ```

  </details>


</details>
	  
<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 

package com.test.test1.mypage.dto;

public class ImgDto {

	/* 경로 */
	private String uploadPath;
	
	/* uuid */
	private String uuid;
	
	/* 파일 이름 */
	private String fileName;
	
	private String saveFilestr;
	
	private String id;
	

	public String getUploadPath() {
		return uploadPath;
	}

	public void setUploadPath(String uploadPath) {
		this.uploadPath = uploadPath;
	}

	public String getUuid() {
		return uuid;
	}

	public void setUuid(String uuid) {
		this.uuid = uuid;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}

	public String getSaveFile() {
		return saveFilestr;
	}

	public void setSaveFileStr(String saveFilestr) {
		this.saveFilestr = saveFilestr;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	@Override
	public String toString() {
		return "ImagDto [uploadPath=" + uploadPath 
			+ ", uuid=" + uuid 
			+ ", fileName=" + fileName 
			+ ", saveFilestr=" + saveFilestr 
			+ ", id=" + id 
			+"]";
	}
}
  

```
</details>

<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- Controller로 받은 데이터를 DAO로 전달합니다.


```java 
// 네비바 이미지 출력 기능 Service / ServiceImpl
// Service
public interface UserService {
	String navbarImg(String id);

}

// ServiceImpl
@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDao userDao;

	@Override
	public String navbarImg(String id) {
		return userDao.navbarImg(id);
	}
}

```
  
```java 
// 프로필 이미지 등록/변경 기능 Service / ServiceImpl
// Service
public interface UserService {
	void img_update(ImgDto dto);

}

// ServiceImpl
@Service
public class UserServiceImpl implements UserService{
	
	@Inject
	UserDao userDao;

	@Override
	public void img_update(ImgDto dto) {
		userDao.img_update(dto);
	}
}

```
</details>
	  
<details>
<summary> <b>DAO</b> </summary>
  

- Service에서 전달 받은 데이터를 XML로 전달합니다.
  


```java 
// 네비바 이미지 출력 기능 구현 DAO
@Repository
public class UserDao {
	
	@Inject
	SqlSessionTemplate sqlSessionTemplate;
	
	public String navbarImg(String id) {
		return sqlSessionTemplate.selectOne("user.navbarImg" , id);
	}
}
  
```
  
```java 
// 프로필 이미지 등록/변경 기능 구현 DAO
@Repository
public class UserDao {
	
	@Inject
	SqlSessionTemplate sqlSessionTemplate;
	
	public void img_update(ImgDto dto) {
		sqlSessionTemplate.selectOne("user.img_update" , dto);
	}
}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>
  

- DAO에서 전달 받은 데이터로 쿼리문을 통해 프로필 이미지 경로를 등록하거나 리턴합니다.

  <details>
    <summary> <b>네비바 이미지 출력</b> </summary>

    - 해당 사용자의 프로필 이미지 경로를 아이디 정보를 통해 불러옵니다.
 
    ```xml 
    <!-- 네비바 이미지 출력 기능 xml -->
    <select id="navbarImg" resultType="String">
            <![CDATA[
            select IMG
              from USER
             where ID=#{user_id}
            ]]>
    </select>
    ```
 
  </details>
    <details>
    <summary> <b>프로필 이미지 등록/변경</b> </summary>

    - 이미지 경로를 해당 사용자의 정보에 저장합니다.<br>
    - 변경을 할 때에도 위와 같은 방법으로 저장이 이루어집니다. 
 
    ```xml 
    <!-- 프로필 이미지 등록/변경 기능 xml -->
    <update id="img_update">
      update USER
             set IMG = #{saveFilestr}
         where ID = #{id}
    </update>
    ```
 
  </details>

</details>
