//
//  NewsNetworking.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import Foundation
import Alamofire
//https://newsapi.org/v2/everything?q=apple&from=2021-07-16&sortBy=publishedAt&apiKey=2914fcb5d1604ac8a9eb6b15d0e29160
var from = "2021-07-17"
var sortBy = "publishedAt"
var apiKey = "2914fcb5d1604ac8a9eb6b15d0e29160"
enum NewsNetworking {
    case search(search: String)
}
extension NewsNetworking :TargetType{
    
    
    var baseURL: String {
        return BaseURL
    }
    
    var path: String {
        switch self {
        case .search:
            return "/everything"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    var task: Task {
        switch self {
        case .search(search: let search):
            return .requestParameters(parameters:
                ["q" : search,
                 "from" : from,
                 "sortBy" : sortBy,
                 "apiKey" : apiKey], encoding:URLEncoding.default)
        }
    }

    var headers: [String : String]?{
        return [:]
    }
    
}
