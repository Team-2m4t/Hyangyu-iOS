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
        static let baseURL = "http://13.209.87.36:8080/api"
        
        // MARK: - Auth -  Auth Service
        
        // 회원가입 (POST)
        static let signUpURL = "/UserApi/signup"
        
        // 로그인 (GET)
        
        static let signInURL = "/AuthController/authenticate"
        
        // 비밀번호 변경 (POST)
        static let passwordURL = "/UserApi/modifyPassword"
        
        // 회원 탈퇴 (DELETE)
        static let deleteUser = "/UserApi/user/deleteMyUser"
        
    }
}

