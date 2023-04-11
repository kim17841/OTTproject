package com.test.test1.board.qna.dto;

public class Criteria {
    
    private int page;
    private int perPageNum;
	private String keyword, option, sort;
	
	public String getKeyword() {
		return keyword;
	}
	
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	
	public String getOption() {
		return option;
	}
	
	public void setOption(String option) {
		this.option = option;
	}
    
    public int getPageStart() {
        return (this.page-1)*perPageNum;
    }
    
    public Criteria() {
        this.page = 1;
        this.perPageNum = 10;
    }
    
    public int getPage() {
        return page;
    }
    
    public void setPage(int page) {
        if(page <= 0) {
            this.page = 1;
        } else {
            this.page = page;
        }
    }
    
    public int getPerPageNum() {
        return perPageNum;
    }
    
    //////// 추천수 정렬을 위해 추가 - 02.21 김범수 ///////////
    public String getSort() {
		return sort;
	}
    
	public void setSort(String sort) {
		this.sort = sort;
	}
	/////////////////////////////////////////////////
	
	public void setPerPageNum(int pageCount) {
        int cnt = this.perPageNum;
        if(pageCount != cnt) {
            this.perPageNum = cnt;
        } else {
            this.perPageNum = pageCount;
        }
    }
    
    @Override
    public String toString() {
    	return "Criteria[page = " + page + ", perPageNum = " + perPageNum + ", sort =" + sort + "]";
    }
    
}
