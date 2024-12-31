package com.spring.service;

import java.util.List;

import com.spring.domain.Board;
import com.spring.domain.Road;

public interface BoardService {

	void setAddBoard(Board board);
	List<Board> getAllBoards(int offset, int limit);
	int getBoardCount();
	Board getOneBoard(long brdNum);
	Road getOneBoard(String usernick);
	void setUpdateBoard(Board board);
	void deleteBoard(long brdNum);
	void setViews(long brdNum);

	Road getMyRoad(String usernick);
	
	void addComment(Board board);
	void updateComment(Board board);
	void deleteComment(long commentId);
	
	
	List<Board> getCommentsByBoardId(long brdNum);


}
