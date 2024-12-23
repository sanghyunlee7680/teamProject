package com.spring.domain;

public class BoardLike {
	private long likeNum;
	private long brdNum;
	private String nickName;
	
	public BoardLike(){}
	
	// Getter && Setter
	public long getLikeNum() {
		return likeNum;
	}

	public void setLikeNum(long likeNum) {
		this.likeNum = likeNum;
	}

	public long getBrdNum() {
		return brdNum;
	}

	public void setBrdNum(long brdNum) {
		this.brdNum = brdNum;
	}

	public String getNickName() {
		return nickName;
	}

	public void setNickName(String nickName) {
		this.nickName = nickName;
	}

	
	
}
