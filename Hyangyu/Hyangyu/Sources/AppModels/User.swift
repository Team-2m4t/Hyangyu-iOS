//
//  User.swift
//  Hyangyu
//
//  Created by 배소린 on 2022/02/07.
//

import Foundation
import UIKit

class User {
    static let shared = User()
    
    var email: String?
    var username: String?
    var profileImage: UIImage?
    var password: String?
}
