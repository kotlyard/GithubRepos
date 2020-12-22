//
//  RepoTableViewCell.swift
//  GithubReposMVVM
//
//  Created by kotl on 22.12.2020.
//

import UIKit

class RepoTableViewCell: UITableViewCell {

    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var ownerLoginLabel: UILabel!
    @IBOutlet private weak var starsCountLabel: UILabel!


    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }

    func configurate(with repo: RepoDispalayable) {
        nameLabel.text = repo.name
        ownerLoginLabel.text = repo.ownerLogin
        starsCountLabel.text = "\(repo.starsCount)"
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        
        backgroundColor = .white
    }

}
