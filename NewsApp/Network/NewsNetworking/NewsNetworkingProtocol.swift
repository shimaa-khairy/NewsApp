//
//  NewsListProtocol.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import Foundation
protocol NewsNetworkingProtocol{
    func searchNews(search:String,page:Int,completion : @escaping(Result<NewsResponse?,NSError>)->Void )
}
class NewsNetworkingApi : BaseAPI<NewsNetworking> ,NewsNetworkingProtocol{
    func searchNews(search: String,page:Int, completion: @escaping (Result<NewsResponse?, NSError>) -> Void) {
        fetchData(target: .search(search: search,page:page), responseClass: NewsResponse.self) { (result) in
            completion(result)
        }
    }
    
    
}
