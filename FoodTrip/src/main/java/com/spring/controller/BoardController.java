package com.spring.controller;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.domain.Board;
import com.spring.domain.Member;
import com.spring.domain.Road;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	// 게시판 게시글 생성 : Create
	@GetMapping("/addBoard")
	public String addBoard(@RequestParam(value = "usernick", required = false) String usernick,
							@RequestParam(value = "roadId", required = false)String roadId,
							@ModelAttribute("addBrd")Board board,HttpSession session,
							Model model) {
		System.out.println("/addBoard()실행 : 게시글 작성 폼 제공");
		System.out.println("usernick : "+usernick+" || roadId : "+ roadId);
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
        Road road = null;
        if(usernick != null && roadId != null) {
        	System.out.println("null이 아니네? ");
        	road = boardService.getMyRoad(usernick);
        }
        //System.out.println("road의 포인트 : "+road.getPoints());
        model.addAttribute("road", road);
		System.out.println(sessionId.getEmail());
		return "/Board/addBoard";
	}
	
	
	@PostMapping("/addBoard")
	public String submitBoard(@ModelAttribute("addBrd")Board board, HttpSession session, HttpServletRequest request) {
		System.out.println("submitBoard() 실행 : 게시글 생성 시작");
		
		System.out.println("road 가져왔니? : "+(Road)session.getAttribute("road"));
		Road road = (Road)session.getAttribute("road");
		String roadId = null;
		if(road != null) {
			roadId = road.getRoadId();
		}
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
		// Ip 주소를 저장
		board.setIp(request.getRemoteAddr());
		// 게시글 작성 시간을 저장
		board.setNickName(sessionId.getNickName());
        board.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Timestamp(System.currentTimeMillis())));
        board.setDepth(1); // 게시글은 depth 1
        board.setRoadId(roadId);
       boardService.setAddBoard(board);

		return "redirect:/board/boards";
	}
	
	// 게시판 게시글 전체 조회 : ReadAll
	@GetMapping("/boards")     //파라미터가 필수요소가 아님을 설정, 기본값 1 설정
	public String getAllBoards(@RequestParam(value = "pageNum", required = false, defaultValue = "1")int pageNum,Model model) {
		System.out.println("getAllBoards()실행 : 게시글 조회");
		
		int limit=10; // 한 페이지에 표시할 게시글 수
		List<Board> boardList = boardService.getAllBoards((pageNum - 1) * limit, limit);
        int totalPage = (int) Math.ceil((double) boardService.getBoardCount() / limit);

        model.addAttribute("boardList", boardList);
        model.addAttribute("pageNum", pageNum);
        model.addAttribute("totalPage", totalPage);
        return "Board/Boards"; 
		
		
	
	}
	
	// 게시글 조회 (1개) : ReadOne
	@GetMapping("/BoardView")
	public String boardView(@RequestParam("num") long brdNum,HttpSession session,
							Model model) 
	{	
		Board board = boardService.getOneBoard(brdNum);
	    if (board == null) {
	        return "redirect:/board/boards"; // 게시글이 없는 경우 목록으로 리다이렉트
	    }
	    Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
    
    
    // 댓글 조회
    List<Board> comments = boardService.getCommentsByBoardId(brdNum);
    System.out.println("코멘츠 : " + comments);
    for(int i=0; i<comments.size(); i++) {
    	int depth = comments.get(i).getDepth();
    	//System.out.println("조회뎁스" + depth);
    }

    // 코스 조회
    Road road = null;
    if(board!= null) {
    	road = boardService.getOneBoard(board.getNickName());
    }
    model.addAttribute("board", board);
    model.addAttribute("road", road);
    model.addAttribute("comments", comments);
    boardService.setViews(brdNum); // 조회수 증가
    return "Board/BoardView";
	
	}
	
	// 게시글 수정 : Update
	@GetMapping("/updateBoard")
	public String updateBoard(@ModelAttribute("uptBrd") Board board, @RequestParam("num") long brdNum,Model model,HttpSession session) { 
		System.out.println("updateBoard()실행 : 게시글 수정 폼 제공");
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }

        board = boardService.getOneBoard(brdNum);
        System.out.println("보드" + board);
        if (board == null || !board.getNickName().equals(sessionId.getNickName())) {
            return "redirect:/board/boards";
        }

        model.addAttribute("board", board);
        return "Board/updateBoard";

	}

	@PostMapping("/updateBoard")
	public String submitUpdateBoard(@ModelAttribute("uptBrd") Board board,@RequestParam("num")long BrdNum, HttpSession session) { 
		System.out.println("submitUpdateBoard() 실행 : 게시글 수정 시작");
		Member sessionId = (Member) session.getAttribute("sessionId");
		if (sessionId == null || !board.getNickName().equals(sessionId.getNickName())) {
	           return "redirect:/member/login";
		}
		board.setBrdNum(BrdNum);
		board.setUpdateDay(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Timestamp(System.currentTimeMillis())));
		boardService.setUpdateBoard(board);

		return "redirect:/board/BoardView?num=" + board.getBrdNum();
		
	}
	
	// 게시판 삭제 : Delete
	@GetMapping("/deleteBoard")
	public String deleteBoard(@RequestParam("num")long brdNum, HttpSession session) { // Board board
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }

        Board board = boardService.getOneBoard(brdNum);
        if (board != null && board.getNickName().equals(sessionId.getNickName())) {
            boardService.deleteBoard(brdNum);
        }

        return "redirect:/board/boards";

	}
	
	

	// 댓글, 대댓글 생성 : Create
	@ResponseBody
	@PostMapping("/comment")
	public String comment(@RequestBody HashMap<String,Object> map, HttpServletRequest request) { 
		System.out.println("comment() 실행");
		
		Board comment = new Board();
        comment.setNickName(map.get("nickName").toString());
        comment.setContent(map.get("content").toString());
        comment.setParentNum(Long.parseLong(map.get("parentNum").toString()));
        comment.setDepth(Integer.parseInt(map.get("depth").toString()));
        System.out.println("컨트롤러뎁스 : " + comment.getDepth());
        comment.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Timestamp(System.currentTimeMillis())));
        comment.setIp(request.getRemoteAddr());
        boardService.addComment(comment);
        return "success";
		
	}
	
	// 댓글 수정 : Update
	@ResponseBody
	@PutMapping("/comment") 
	public String updateComment(@RequestBody HashMap<String,Object> map) {
		System.out.println("updateComment() 실행 : 댓글 수정");
		Board brd = new Board();
		brd.setBrdNum(Long.parseLong(map.get("brdNum").toString()));
		brd.setContent(map.get("content").toString());
		brd.setUpdateDay(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Timestamp(System.currentTimeMillis())));
		
		boardService.updateComment(brd);
		return "success";
	}
	
	// 댓글 삭제 : Delete
	@ResponseBody
	@DeleteMapping("/comment/{id}/{admin}")
	public String deleteComment(@PathVariable("id") long commentId, @PathVariable("admin")int admin) {
		System.out.println("deleteComment() 실행 : 댓글삭제");
		boardService.deleteComment(commentId, admin);
		return "success";
	}
	
}
