//
//  NewsListViewController.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import Foundation
import UIKit
class NewsListViewController : UIViewController {
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var newsTableView: UITableView!
    let newsNetworking : NewsNetworkingProtocol = NewsNetworkingApi()
    var articles : [Article]?
    override func viewDidLoad(){
        super.viewDidLoad()
        searchNews(searchText: "apple")
    }
    func searchNews(searchText: String){
        newsNetworking.searchNews(search: searchText) { (result) in
            switch result{
            case .success(let news):
                print("succes")
                self.articles = news?.articles
                self.newsTableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
}

extension NewsListViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return (articles != nil) ? articles!.count : 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell", for:indexPath) as! NewsTableViewCell
        cell.configureCell(article: articles![indexPath.section])
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnedView = UIView()
        returnedView.backgroundColor = .white
        return returnedView
    }
    
}
extension NewsListViewController :UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.text!.count > 0 {
            searchNews(searchText: textField.text!)
        }
        textField.resignFirstResponder()
        return true
    }
}
