//
//  NewsDetailsViewController.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import UIKit
import Kingfisher
class NewsDetailsViewController: UIViewController {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var author: UILabel!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var newsDescription: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    @IBOutlet weak var sourceButton: UIButton!
    var article : Article?
    override func viewDidLoad() {
        super.viewDidLoad()
        initUI()
    }
    
    func initUI(){
        image.kf.setImage(with: URL(string: article!.urlToImage ?? ""))
        newsTitle.text = article!.title
        newsDescription.text = article!.articleDescription
        author.text = article!.author
        date.text = article!.publishedAt?.components(separatedBy: ["T"])[0]
        newsContent.text = article!.content
        sourceButton.setTitle(article!.source.name, for: .normal)
    }

    @IBAction func openSource(_ sender: UIButton) {
        guard let url = URL(string: article!.url ?? "") else { return }
        UIApplication.shared.open(url)
    }

}
