//
//  TopicCell.swift
//  iQuiz
//
//  Created by stlp on 5/9/22.
//

import UIKit

class TopicCell: UITableViewCell {


    @IBOutlet weak var topicImageView: UIImageView!
    @IBOutlet weak var topicLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
