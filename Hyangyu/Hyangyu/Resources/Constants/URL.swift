//
//  URL.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation

extension Const {
    struct URL {
        
        // base url
        static let baseURL = "http://52.79.236.231:8080/api"
        
        // MARK: - Auth -  Auth Service
        
        // 회원가입 (POST)
        static let signUpURL = "/UserApi/signup"
        
        // 로그인 (POST)
        
        static let signInURL = "/AuthController/authenticate"
        
        // 비밀번호 변경 (POST)
        static let passwordURL = "/UserApi/modifyPassword"
        
        // 회원 탈퇴 (DELETE)
        static let deleteUserURL = "/UserApi/user/deleteMyUser"
        
        // MARK: - Saved - My Page Saved Service
        
        // 전시회 조회 (GET), 전시회 저장 (POST)
        static let displayURL = "/display"
        
        
        // MARK: - My Page - User Service
        
        // 닉네임 변경 (POST)
        static let modifyUserNameURL = "/UserApi/user/modifyUsername"
        
        // 유저 조회 (GET)
        static let userViewURL = "/UserApi/user"
        
        // 마이페이지 조회 (GET)
        static let myPageURL = "/myPage"
        
        // 카테고리 조회(GET)
        static let display = "/display"
        
        
    }
}

