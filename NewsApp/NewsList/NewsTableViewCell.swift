//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by shimaa_khairy on 7/17/21.
//

import UIKit
import Kingfisher
class NewsTableViewCell: UITableViewCell {

    @IBOutlet weak var newsImage: UIImageView!
    @IBOutlet weak var newsDescription: UITextView!
    
    func configureCell(article :Article){
    
        newsImage.kf.setImage(with: URL(string:article.urlToImage ?? ""))
        newsDescription.text = article.title
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
