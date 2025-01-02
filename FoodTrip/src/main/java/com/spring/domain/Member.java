package com.spring.domain;

import java.sql.Timestamp;
import java.util.Date;

import org.springframework.web.multipart.MultipartFile;

public class Member {

   private String email;   
   private String password;         // 비밀번호
   private String nickName;         // 닉네임
   private String gender;            // 성별
   private int age;               // 나이
   private String badgeName;         // 뱃지이름
   private Timestamp joinDay;         // 가입날짜
   


   public Member() {}
   
   // Getter & Setter
   public String getEmail() {
      return email;
   }
   
   public void setEmail(String email) {
      this.email = email;
   }

   public String getPassword() {
      return password;
   }

   public void setPassword(String password) {
      this.password = password;
   }
   public String getNickName() {
      return nickName;
   }
   public void setNickName(String nickName) {
      this.nickName = nickName;
   }
   public String getGender() {
      return gender;
   }
   public void setGender(String gender) {
      this.gender = gender;
   }
   public int getAge() {
      return age;
   }
   public void setAge(int age) {
      this.age = age;
   }
   public String getBadgeName() {
      return badgeName;
   }
   
   public void setBadgeName(String badgeName) {
      this.badgeName = badgeName;
   }

   public Timestamp getJoinDay() {
       return joinDay;
   }

   public void setJoinDay(Timestamp joinDay) {
       this.joinDay = joinDay;
   }
   
   
   
}
