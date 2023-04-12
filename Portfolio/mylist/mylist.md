	   
### 4.4. 내 보관함 기능
<details>
<summary> <b>기능 설명</b> </summary>

  - 내 보관함 기능 : 해당 영상에 찜하기 버튼을 클릭하면 영상이 내 보관함 리스트에 담김.

  - 찜하기 아이콘을 다시 클릭하면 내 보관함 리스트에 담긴 해당 영상이 삭제.

 
</details>
  
<details>
<summary> <b>JSP</b> </summary>

  
- DB에서 해당 정보를 리턴 받아와 view로 출력합니다.
```
  (... 생략 ...)
  <!-- 영상페이지에 있는 찜하기 버튼 -> 클릭시 내 보관함 리스트에 영상 추가 -->
  <input type="hidden" id="title_data" value="${dto.title}">
  <!-- 찜하기 버튼 value -->
  <c:set var="rental_id" value="${rental_id}"/>
  <c:choose>
      <c:when test="${rental_id ne null}"> <!-- rental_id가 null값이 아닐 경우 -->
          <i class="fas fa-heart comu_btn" id="subscribe"></i>
      </c:when>
      <c:otherwise> <!-- rental_id가 null일 경우 -->
          <i class="far fa-heart comu_btn" id="subscribe"></i>
      </c:otherwise>
  </c:choose>
  <p>찜하기</p>
  (... 생략 ...)

  <!-- 내 보관함 리스트 영역-->
  <div class="section">
        <!-- 내 보관함 text -->
        <div><h1 class="mylocker_text">내보관함</h1></div>
        <!-- 내 보관함 슬라이드 - 양옆 버튼 추가, 슬릭 기능 -->
        <div class="slider">
           <!-- 내보관함 리스트 출력 영역-->
           <c:forEach var="movie" items="${dto}">
              <div class="video_div">
                 <a href="/video/detail?video_id=${movie.video_id}"> 
			<img src="${movie.image_url}" alt="Image not found"></a>
              </div> 
           </c:forEach>

        </div>
     </div>
```
</details>
	  
<details>
<summary> <b>Javascript</b> </summary>

- 찜하기 버튼을 누르면 아이콘 변경 후 보관함에 담기 / 삭제를 합니다.
- 찜한 영상은 내 페이지에 접속하면 영상 리스트가 나옵니다
  <details>
  <summary> <b>찜하기 버튼 구현 코드</b> </summary>

  ```javascript
	// 찜하기 버튼 클릭 이벤트
	const comu_btn = document.querySelectorAll('.comu_btn'); 
	comu_btn[0].addEventListener('click', function(){ // 찜하기 버튼 클릭 이벤트
		let title = $('#title_data').val(); // 찜하기 버튼 value 
	    if(this.className.includes('fas')){ // 내보관함에서 삭제
		$.ajax({ // 내보관함에서 삭제
			url : 'mylocker_de',
			type : 'post',
			data : {'title' : title},		
		})
		this.className = 'far fa-heart comu_btn';
		alert('내보관함에서 삭제되었습니다');

	    }else { // 내보관함에 담기
		$.ajax({
			url : 'mylocker_in',
			type : 'post',
			data : {'title' : title},
		})
		this.className = 'fas fa-heart comu_btn';
		alert('내보관함에 담겼습니다');
	    }
	});

  ```

  </details>

	
  <details>
  <summary> <b>슬라이드 기능</b> </summary>

  ```javascript
  // 슬릭 이벤트
	$(function(){
		(...생략...)
		$(".slider").not('.slick-initialized').slick({
			slidesToShow:6,
			slidesToScroll:6,    
			prevArrow: "<button type='button' class='slick-arrow'><i class='fa-solid fa-angle-left'></i></button>",
			nextArrow: "<button type='button' class='slick-next'><i class='fa-solid fa-angle-right'></i></button>",
		});
	})
  ```

  </details>
  
</details>
	   
<details>
<summary> <b>Controller</b> </summary>

- JS로 받은 정보를 통해 사용자의 아이디와 해당 영상의 아이디를 불러와 DB에 전달합니다.
- 추가 / 삭제가 이루어지면 각각의 다른 결과를 view단으로 리턴합니다.

  <details>
  <summary> <b>찜하기 버튼</b> </summary>

  ```java
  // 내 보관함 기능 구현 - 찜하기 버튼
	@RequestMapping(value = {"mylocker_in", "mylocker_de"}, method = RequestMethod.POST)
	@ResponseBody
	public ModelAndView mylocker(String title, RentalDTO dto, HttpSession session, 
					HttpServletRequest request, ModelAndView mv) throws Exception{
		String requestUrl = request.getRequestURL().toString(); 
		// mylocker_in와 mylocker_de의 매핑을 다르게 받기 위해 사용
		String id = (String) session.getAttribute("user_id");
		int video_id = videoService.getid(title); 
		// 비디오 제목을 가져가 비디오 아이디를 가져오는것
		if(id == null) { // 로그인 상태가 아닌 경우 / 세션 유지 시간이 만료된 경우
			mv.setViewName("redirect:/user/signin");
		}
		
		if(requestUrl.contains("mylocker_in")) { // 내 보관함 담기
			dto.setVideo_id(video_id);
			dto.setId(id);
			rentalService.insert(dto);
			String rental_id = rentalService.getid(dto);
			// 영상 ID와 유저 ID를 담은 rental_id를 영상메인페이지로 리턴 
			mv.addObject("rental_id",rental_id); 
			mv.setViewName("video/detail");
		}
		else { // 내 보관함 삭제
			dto.setId(id);
			dto.setVideo_id(video_id);
			rentalService.delete(dto);
			String rental_id = rentalService.getid(dto);
			mv.addObject("rental_id",rental_id);
			mv.setViewName("video/detail");
		}		
		return mv;	
	}

  ```
    
   ```java
	// 찜하기 아이콘 유지
	public ModelAndView detail(@RequestParam int video_id, ModelAndView mv, 
				HttpSession session, RentalDTO dto) {
		dto.setId(id); // dto에 저장
		String rental_id = rentalService.getid(dto);// rental id를 가져오는 것
		mv.addObject("rental_id",rental_id);
		mv.setViewName("video/detail");
		return mv;
	}
  ```
   
  </details>
  <details>
  <summary> <b>보관함 리스트 구현</b> </summary>

   ```java
	  public ModelAndView detail(HttpSession session, ModelAndView mv) {
		String user_id =(String) session.getAttribute("user_id").toString(); 
		// 세션에서 사용자의 아이디를 가져옴
		List<VideoDto> list = rentalService.list(user_id); 
		// 해당 아이디에 저장된 비디오 리스트를 가져오기 위함
		mv.addObject("dto", list);
		mv.setViewName("mypage/mydetail");
		return mv;
	}
   ```

  </details>

</details>
	
<details>
<summary> <b>DTO</b> </summary>

- 테이블에 들어 있는 정보를 미리 변수로 생성하고 getter/setter를 설정한 파일입니다.
 
```java 
// VideoDTO
package com.test.test1.video.dto;

import java.util.Date;

public class VideoDto {
	private String title, video_url, image_url, summary, create_country, 
									grade, actor, genre_id, create_year;
	private int video_id, recommand, category_id;
	private Date upload_date;
	
	public String getTitle() {
		return title;
	}
	
	public void setTitle(String title) {
		this.title = title;
	}
	
	public String getVideo_url() {
		return video_url;
	}
	
	public void setVideo_url(String video_url) {
		this.video_url = video_url;
	}
	
	public String getImage_url() {
		return image_url;
	}
	
	public void setImage_url(String image_url) {
		this.image_url = image_url;
	}
	
	public String getSummary() {
		return summary;
	}
	
	public void setSummary(String summary) {
		this.summary = summary;
	}
	
	
	public String getGrade() {
		return grade;
	}
	
	public void setGrade(String grade) {
		this.grade = grade;
	}
	
	public String getGenre_id() {
		return genre_id;
	}
	
	public void setGenre_id(String genre_id) {
		this.genre_id = genre_id;
	}	
	
	public String getActor() {
		return actor;
	}
	
	public void setActor(String actor) {
		this.actor = actor;
	}	
	
	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public String getCreate_year() {
		return create_year;
	}
	
	public void setCreate_year(String create_year) {
		this.create_year = create_year;
	}
	
	public int getRecommand() {
		return recommand;
	}
	
	public void setRecommand(int recommand) {
		this.recommand = recommand;
	}	
	
	public int getCategory_id() {
		return category_id;
	}
	
	public void setCategory_id(int category_id) {
		this.category_id = category_id;
	}

	public Date getUpload_date() {
		return upload_date;
	}

	public void setUpload_date(Date upload_date) {
		this.upload_date = upload_date;
	}

	public String getCreate_country() {
		return create_country;
	}

	public void setCreate_country(String create_country) {
		this.create_country = create_country;
	} 
	
	@Override
	public String toString() {
		return "VideoDto [title = " + title
			+ ", video_url = " + video_url
			+ ", image_url = " + image_url
			+ ", summary = " + summary
			+ ", country = " + create_country
			+ ", grade = " + grade
			+ ", actor = " + actor
			+ ", genre_id = " + genre_id
			+ ", video_id = " + video_id
			+ ", create_year = " + create_year
			+ ", recommand = " + recommand
			+ ", category_id = " + category_id 
			+ "]";
	}
	
}
```
```java 
// RentalDTO
package com.test.test1.video.dto;

import java.util.Date;

public class RentalDTO {
	
	private String id;
	private int video_id;
	private Date rental_date;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public int getVideo_id() {
		return video_id;
	}

	public void setVideo_id(int video_id) {
		this.video_id = video_id;
	}
	
	public Date getRental_date() {
		return rental_date;
	}

	public void setRental_date(Date rental_date) {
		this.rental_date = rental_date;
	}
	
	@Override
	public String toString() {
		return "rentalDTO[id = " + id 
			+ ", video_id = " + video_id 
			+ ", rental_date = " + rental_date 
			+ "]";
	}
}
```
</details>
	
<details>
<summary> <b>Service / ServiceImpl</b> </summary>
  

- Controller로 받은 데이터를 DAO로 전달합니다.


```java 
// 찜하기 버튼 기능 Service / ServiceImpl
// service
public interface RentalService {

	void insert(RentalDTO dto);

	void delete(RentalDTO dto);
}
  
//ServiceImpl
@Service
public class RentalServiceImpl implements RentalService{
	
	@Inject
	RentalDao rentalDao;

	@Override
	public void insert(RentalDTO dto) {
		rentalDao.insert(dto);
	}

	@Override
	public void delete(RentalDTO dto) {
		rentalDao.delete(dto);
	}

}

```
  
```java 
// 보관함 리스트 기능 Service / ServiceImpl
// Service
public interface RentalService {

	List<VideoDto> list(String user_id);

}
  
// ServiceImpl
@Service
public class RentalServiceImpl implements RentalService{
	
	@Inject
	RentalDao rentalDao;

	@Override
	public List<VideoDto> list(String user_id) {
		return rentalDao.list(user_id);
	}

}

```
</details>
  
<details>
<summary> <b>DAO</b> </summary>
  

- Service에서 전달 받은 데이터를 XML로 전달합니다.
  


```java 
// 찜하기 기능 구현 DAO
@Repository
public class RentalDao {
	
	@Inject
	SqlSession sqlSession;

	// rental_id를 입력
	public void insert(RentalDTO dto) {
		sqlSession.insert("rental.insert", dto);
	}

	// rental_id를 삭제
	public void delete(RentalDTO dto) {
		sqlSession.delete("rental.delete", dto);
	}

}
  
```
  
```java 
// 보관함 리스트 구현 DAO
@Repository
public class RentalDao {
	
	@Inject
	SqlSession sqlSession;

	// 해당 사용자가 찜한 영상을 불러오는 것
	public List<VideoDto> list(String user_id) {
		return sqlSession.selectList("rental.list", user_id);
	}

}
  
```
</details>
  
<details>
<summary> <b>XML</b> </summary>

- DAO에서 전달 받은 데이터로 쿼리문을 통해 내 보관함 데이터를 추가/삭제합니다.
- 보관함 리스트는 VIDEO_DTO를 통해 영화 제목/이미지 URL 등 데이터를 view단으로 반환하여 영상 리스트를 출력합니다.


```xml 
<!-- 찜하기 기능 구현 XML -->
<!-- 찜하기 -->
<insert id="insert">
	insert into RENTAL(USER_ID, VIDEO_ID)
	values((select USER_ID from USER where ID = "${id}"), #{video_id})
</insert>

<!-- 찜 제거-->
<delete id="delete">
	<![CDATA[
	delete from RENTAL
	 where USER_ID = (select USER_ID from USER where ID = "${id}")
		 and VIDEO_ID = #{video_id}
	]]>
</delete>
```
  
```xml 
<!-- 보관함 리스트 구현 XML -->
<select id="list" resultType="com.test.test1.video.dto.VideoDto">
	<![CDATA[
	select distinct v.VIDEO_ID, v.TITLE, v.IMAGE_URL, v.VIDEO_URL
    from VIDEO v 
    left join RENTAL r
		  on v.VIDEO_ID = r.VIDEO_ID
		left join USER u
		  on r.USER_ID = u.USER_ID
	 where u.USER_ID = (select USER_ID from USER where ID = "${user_id}")
	]]>
</select>
```
</details>
