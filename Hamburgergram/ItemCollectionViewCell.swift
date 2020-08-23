//
//  ItemCollectionViewCell.swift
//  Hamburgergram
//
//  Created by Kevin Kemp on 8/21/20.
//  Copyright © 2020 Kevin Kemp. All rights reserved.
//

import UIKit

class ItemCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var highlightIndicator: UIView!
    @IBOutlet weak var selectIndicator: UIImageView!
    
    override var isHighlighted: Bool {
        didSet {
            highlightIndicator.isHidden = !isHighlighted
        }
    }
    
    override var isSelected: Bool {
        didSet {
            highlightIndicator.isHidden = !isSelected
            selectIndicator.isHidden = !isSelected
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
