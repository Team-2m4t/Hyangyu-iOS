//
//  Font.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/01/23.
//

import UIKit

enum FontType: String {
    case appleSDGothicNeoThin = "AppleSDGothicNeo-Thin"
    case appleSDGothicNeoUltraLight = "AppleSDGothicNeo-UltraLight"
    case appleSDGothicNeoLight = "AppleSDGothicNeo-Light"
    case appleSDGothicNeoRegular = "AppleSDGothicNeo-Regular"
    case appleSDGothicNeoMedium = "AppleSDGothicNeo-Medium"
    case appleSDGothicNeoSemiBold = "AppleSDGothicNeo-SemiBold"
    case appleSDGothicNeoBold = "AppleSDGothicNeo-Bold"
    
    var name: String {
        return self.rawValue
    }
}
