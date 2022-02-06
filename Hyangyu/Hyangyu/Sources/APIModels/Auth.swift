//
//  Auth.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/26.
//

import Foundation

// 로그인, 회원가입, 비밀번호 찾기

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

// MARK: - SignIn
struct SignIn: Codable {
    let token: String
}

// 이메일 인증

// MARK: - DataClass
struct CodeData: Codable {
    let number: Int
}

// MARK: - message
struct EmailCheckData: Codable {
    let message: String
}


