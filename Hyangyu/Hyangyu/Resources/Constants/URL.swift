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
        static let signUpURL = "/user/signup"
        
        // 로그인 (POST)
        static let signInURL = "/auth"
        
        // 비밀번호 찾기(POST)
        static let findPasswordURL = "/send-email"
        
        // 비밀번호 변경 (POST)
        static let passwordURL = "/user/password"
        
        // MARK: - Saved - My Page Saved Service
        
        // 전시회 저장 (POST), 전시회 취소(DELETE), 전시회 조회 (GET), 카테고리 - 전시회(GET)
        static let displayURL = "/display"
        
        // MARK: - My Page - User Service
        
        // 닉네임 변경 (POST)
        static let modifyUserNameURL = "/user/username"
        
        // 유저 조회 (GET), 유저 조회 이메일로(GET), 회원 탈퇴(DELETE)
        static let userURL = "/user"
        
        // 마이페이지 조회 (GET)
        static let myPageURL = "/myPage"
        
        // 카테고리 조회(GET)
        static let display = "/display"
        
        // 리뷰 조회(GET)
        static let showDisplayReview = "/show/review/display"
        // MARK: - Review
        
        static let displayReviewURL = "/review/display"
        
        // MARK: - Search
        static let searchURL = "/search"
        
        
    }
}

