//
//  ResultTableViewCell.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import UIKit

class ResultTableViewCell: UITableViewCell {
    @IBOutlet var artistImage: UIImageView?
    @IBOutlet var artistName: UILabel?
    @IBOutlet var trackName: UILabel?

    var result: ResultRow? {
        didSet {
            artistImage?.loadFromUrlString(from: result?.artworkUrl100 ?? "", contentMode: .scaleAspectFill)
            artistName?.text = result?.artistName
            trackName?.text = result?.trackName
            if result?.previewUrl != nil {
                accessoryType = .detailButton
            } else {
                accessoryType = .none
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        artistImage?.image = nil
        artistName?.text = nil
        trackName?.text = nil
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        artistImage?.image = nil
        artistName?.text = nil
        trackName?.text = nil
    }

    
}
