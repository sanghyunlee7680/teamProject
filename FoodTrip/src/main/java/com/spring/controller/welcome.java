package com.spring.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

import com.spring.repository.MarkerRepositoryImpl;

@Controller
public class welcome {
/*
	@Autowired
	MarkerRepositoryImpl tt;
*/	
	
	@GetMapping("/")
	public String welcome(){
		
	//	tt.ipChange();		DB에 저장된 ip주소를 바꾸기위해 사용
		
		return "index";
	}
}
