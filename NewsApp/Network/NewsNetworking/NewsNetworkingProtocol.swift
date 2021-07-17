//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import Foundation
protocol NewsNetworkingProtocol{
    func searchNews(search:String,completion : @escaping(Result<NewsResponse?,NSError>)->Void )
}
class NewsNetworkingApi : BaseAPI<NewsNetworking> ,NewsNetworkingProtocol{
    func searchNews(search: String, completion: @escaping (Result<NewsResponse?, NSError>) -> Void) {
        fetchData(target: .search(search: search), responseClass: NewsResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
