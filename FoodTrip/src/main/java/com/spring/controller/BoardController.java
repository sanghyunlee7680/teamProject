package com.spring.controller;

import java.io.File;
import java.io.IOException;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
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
import org.springframework.web.multipart.MultipartFile;

import com.spring.domain.Board;
import com.spring.domain.BoardLike;
import com.spring.domain.Member;
import com.spring.service.BoardService;

@Controller
@RequestMapping("/board")
public class BoardController {

	@Autowired
	private BoardService boardService;
	
	// 게시판 게시글 생성 : Create
	@GetMapping("/addBoard")
	public String addBoard(@ModelAttribute("addBrd")Board board,HttpSession session) {// Member member,HttpServletRequest request
		System.out.println("/addBoard()실행 : 게시글 작성 폼 제공");
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
		System.out.println(sessionId.getEmail());
		return "/Board/addBoard";
	}
	
	
	@PostMapping("/addBoard")
	public String submitBoard(@ModelAttribute("addBrd")Board board,HttpSession session, HttpServletRequest request) {
		System.out.println("submitBoard() 실행 : 게시글 생성 시작");
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
        System.out.println("image : " + board.getImage());
        
        MultipartFile image = board.getImage();
        String saveName = image.getOriginalFilename();
        String imageFolder = request.getServletContext().getRealPath("resources/images");
        System.out.println("이미지 : " + imageFolder);
        File f = new File(imageFolder, saveName);
        
        if(image != null && !image.isEmpty()) {
        	try {
				image.transferTo(f);
				board.setFileName(saveName);
			} catch (Exception e) {
				throw new RuntimeException("도서 이미지 업로드가 실패했습ㄴ다");
			} 
        }
        
		// Ip 주소를 저장
        board.setImage(image);
		board.setIp(request.getRemoteAddr());
		// 게시글 작성 시간을 저장
		board.setNickName(sessionId.getNickName());
        board.setCreateTime(new SimpleDateFormat("yyyy-MM-dd HH:mm").format(new Timestamp(System.currentTimeMillis())));
        board.setDepth(1); // 게시글은 depth 1
        boardService.setAddBoard(board);

		return "redirect:/board/boards";
	}
	
	// 게시판 게시글 전체 조회 : ReadAll
	@GetMapping("/boards")     //파라미터가 필수요소가 아님을 설정, 기본값 1 설정
	public String getAllBoards(@RequestParam(value = "pageNum", required = false, defaultValue = "1")int pageNum,
								Model model, HttpSession session) {
		System.out.println("getAllBoards()실행 : 게시글 조회");
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) { 
            return "redirect:/member/login";
        }
		
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
							Model model, HttpServletRequest request, HttpServletResponse response) 
	{	
		System.out.println("boardView() 실행 : 게시글 상세 조회");
		Board board = boardService.getOneBoard(brdNum);
	    if (board == null) {
	        return "redirect:/board/boards"; // 게시글이 없는 경우 목록으로 리다이렉트
	    }
	    Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
        
    // 이미지 저장폴더 경로
    String imageFolder = request.getServletContext().getRealPath("resources/images/");
    model.addAttribute("imageFolder", imageFolder);
    
    
    // 댓글 조회
    List<Board> comments = boardService.getCommentsByBoardId(brdNum);
    System.out.println("코멘츠 : " + comments);
    for(int i=0; i<comments.size(); i++) {
    	int depth = comments.get(i).getDepth();
    	//System.out.println("조회뎁스" + depth);
    }
    
    // 로그인한 유저의 게시글 좋아요 확인하기 : Read
    String nick = sessionId.getNickName();
    BoardLike boardLike = boardService.getCheckLikes(brdNum, nick);
    
    model.addAttribute("board", board);
    model.addAttribute("comments", comments);
    
    // 조회 수 증가
    viewCountUp(brdNum, request, response);
    model.addAttribute("boardLike",boardLike);
    // 좋아요 확인
    return "Board/BoardView";
	
		
		
	}
	
	// 조회 수 증가
	private void viewCountUp(long brdNum, HttpServletRequest request, HttpServletResponse response) {
		System.out.println("viewCountUp()실행 : 조회수 증가");
		Cookie oldCookie = null;
		Cookie[] cookies = request.getCookies();
		System.out.println("쿠키들 : " + cookies);
		if(cookies != null) {
			for(int i=0; i<cookies.length; i++){
				Cookie cookie = cookies[i];
				System.out.println("쿠키 : " + cookie);
				if(cookie.getName().equals("boardView")) {
					oldCookie = cookie;
				}
			}
		}
		System.out.println("오래된 쿠키 존재 : " + oldCookie);
		
		if(oldCookie != null) {
			if(!oldCookie.getValue().contains("["+ brdNum+ "]")) {
				boardService.setViews(brdNum);
				oldCookie.setValue(oldCookie.getValue() + "_["+brdNum+"]");
				oldCookie.setPath("/");
				oldCookie.setMaxAge(60*60*24);
				System.out.println("오래된 쿠키 : " + oldCookie);
				response.addCookie(oldCookie);
			}
		}
		else {
				boardService.setViews(brdNum);
				Cookie newCookie = new Cookie("boardView","["+brdNum+"]");
				newCookie.setPath("/");
				newCookie.setMaxAge(60*60*24);
				System.out.println("새로운 쿠키 : " + newCookie);
				response.addCookie(newCookie);
			 }
		
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
	public String submitUpdateBoard(@ModelAttribute("uptBrd") Board board,@RequestParam("num")long BrdNum, HttpSession session, HttpServletRequest request) { 
		System.out.println("submitUpdateBoard() 실행 : 게시글 수정 시작");
		Member sessionId = (Member) session.getAttribute("sessionId");
		if (sessionId == null || !board.getNickName().equals(sessionId.getNickName())) {
	           return "redirect:/member/login";
		}
		MultipartFile image = board.getImage();
        String saveName = image.getOriginalFilename();
        String imageFolder = request.getServletContext().getRealPath("resources/images");
        System.out.println("이미지 : " + imageFolder);
        File f = new File(imageFolder, saveName);
        
        if(image != null && !image.isEmpty()) {
        	try {
				image.transferTo(f);
				board.setFileName(saveName);
			} catch (Exception e) {
				throw new RuntimeException("도서 이미지 업로드가 실패했습ㄴ다");
			} 
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
	@DeleteMapping("/comment/{id}")
	public String deleteComment(@PathVariable("id") long commentId) {
		System.out.println("deleteComment() 실행 : 댓글삭제");
		boardService.deleteComment(commentId);
		return "success";
	}
	
	// 좋아요 클릭, 좋아요 활성화 ( 증가 )
	@ResponseBody
	@PostMapping("/addLike")
	public String addLike(@RequestBody HashMap<String, Object> map, HttpSession session) {
		System.out.println("addLike() 실행 : 좋아요 활성화 " );
		System.out.println("해쉬맵 : " + map);
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
		
		Board board = new Board();
		
		board.setBrdNum(Long.parseLong(map.get("brdNum").toString()));
		board.setNickName(map.get("nickName").toString());
		System.out.println("게시글 번호 : " + board.getBrdNum());
		System.out.println("좋아요 누른 유저 닉 : " + board.getNickName());
		
		boardService.addLike(board);
		
		return "success";
	}
	
	// 좋아요 클릭, 좋아요 비활성화 ( 감소 )
	@ResponseBody
	@PostMapping("/cancelLike")
	public String cancelLike(@RequestBody HashMap<String, Object> map, HttpSession session) {
		System.out.println("cancelLike() 실행 : 좋아요 비활성화");
		System.out.println("취소해쉬맵 : " + map);
		
		Member sessionId = (Member) session.getAttribute("sessionId");
        if (sessionId == null) {
            return "redirect:/member/login";
        }
		
		Board board = new Board();
		
		board.setBrdNum(Long.parseLong(map.get("brdNum").toString()));
		board.setNickName(map.get("nickName").toString());
		System.out.println("게시글 번호 : " + board.getBrdNum());
		System.out.println("좋아요 취소한 유저 닉 : " + board.getNickName());
		
		boardService.cancelLike(board);
		
		return "success";
	}
}
