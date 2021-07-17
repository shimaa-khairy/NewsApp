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
    var page = 1
    var resultCount = 0
    var searchText = "apple"
    override func viewDidLoad(){
        super.viewDidLoad()
        searchNews(searchText: "apple")
    }
    func searchNews(searchText: String){
        newsNetworking.searchNews(search: searchText,page:page) { (result) in
            switch result{
            case .success(let news):
                print("succes")
                if self.page == 1{
                   self.articles = news?.articles
                }else{
                    self.articles?.append(contentsOf: news?.articles ?? [])
                }
                self.resultCount = news?.totalResults ?? 0
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
        let vc = UIStoryboard(name: "NewsDetailsViewController", bundle: nil).instantiateViewController(withIdentifier: "NewsDetailsViewController") as! NewsDetailsViewController
        vc.article = articles![indexPath.section]
        self.navigationController?.pushViewController(vc, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let returnedView = UIView()
        returnedView.backgroundColor = .white
        return returnedView
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.section == articles!.count - 1 {
                      loadMoreData()
                  }
              }
              func loadMoreData(){
                      if resultCount > articles!.count{
                          page += 1
                        searchNews(searchText: searchText)
                        print("loading page\(page)")
                      }
              }
}
extension NewsListViewController :UITextFieldDelegate{

    func textFieldShouldReturn(_ textField: UITextField) -> Bool
    {
        if textField.text!.count > 0 {
            page = 1
            searchText = textField.text!
            searchNews(searchText: searchText)
        }
        textField.resignFirstResponder()
        return true
    }
}
