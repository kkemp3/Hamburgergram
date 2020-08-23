//
//  ImageViewer.swift
//  Hamburgergram
//
//  Created by Kevin Kemp on 8/21/20.
//  Copyright © 2020 Kevin Kemp. All rights reserved.
//

import UIKit

class ImageViewer: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    var imageName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupImageView()
        // Do any additional setup after loading the view.
    }
    
    private func setupImageView() {
        guard let name = imageName else { return }
        
        if let image = UIImage(named: name) {
            imageView.image = image
        }
    }
    
}
