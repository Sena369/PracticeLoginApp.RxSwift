//
//  ModelError.swift
//  LoginApp.RxSwift
//
//  Created by 澤田世那 on 2022/05/05.
//

import Foundation

enum Result<T> {
    case success(T)
    case failure(Error)
}

enum ModelError: Error {
    case invalidId
    case invalidPassword
    case invalidIdAndPassword
    var errorText: String {
        switch self {
        case .invalidIdAndPassword: return "IDとPasswordが未入力です。"
        case .invalidId: return "IDが未入力です。"
        case .invalidPassword: return "Passwordが未入力です。"
        }
    }
}














