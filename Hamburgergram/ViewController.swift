//
//  ViewController.swift
//  Hamburgergram
//
//  Created by Kevin Kemp on 8/21/20.
//  Copyright © 2020 Kevin Kemp. All rights reserved.
//

import UIKit

struct Item {
//    var image: UIImage
    var imageName: String
    
}

class ViewController: UIViewController {

    enum Mode {
        case view
        case select
    }
    @IBOutlet weak var collectionView: UICollectionView!
    
    var items: [Item] = [Item(imageName: "bigmac"),
                        Item(imageName: "baconator"),
                        Item(imageName: "whopper"),
                        Item(imageName: "quarter_pounder"),
                        Item(imageName: "hamburger"),
                        Item(imageName: "cheeseburger"),
                        Item(imageName: "bigmac"),
                        Item(imageName: "baconator"),
                        Item(imageName: "whopper"),
                        Item(imageName: "quarter_pounder"),
                        Item(imageName: "hamburger"),
                        Item(imageName: "cheeseburger"),
                        Item(imageName: "bigmac"),
                        Item(imageName: "baconator"),
                        Item(imageName: "whopper"),
                        Item(imageName: "quarter_pounder"),
                        Item(imageName: "hamburger"),
                        Item(imageName: "cheeseburger")
    ]
    // items = [Item]()
    var photoCount = 1
    
    var collectionViewFlowLayout: UICollectionViewFlowLayout!
    var viewImageSegueIdentifier = "viewImageSegueIdentifier"
    let cellIndentifier = "ItemCollectionViewCell"
    let session = URLSession(configuration: .default)
    var dataTask: URLSessionDataTask?
    var currentImage: UIImage?
    var mMode: Mode = .view {
        didSet {
            switch mMode {
                case .view:
                    for (key, value) in dictionarySelectedIndex {
                        if value {
                            collectionView.deselectItem(at: key, animated: true)
                        }
                    }
                    dictionarySelectedIndex.removeAll()
                    selectBarButton.title = "Select"
                    navigationItem.leftBarButtonItem = nil
                    collectionView.allowsMultipleSelection = false
            case .select:
                    selectBarButton.title = "Cancel"
                    navigationItem.leftBarButtonItem = deleteBarButton
                    collectionView.allowsMultipleSelection = true
            }
        }
    }
    
    lazy var selectBarButton: UIBarButtonItem = {
        let barButtomItem = UIBarButtonItem(title: "Select", style: .plain, target: self, action: #selector(didSelectButtonClicked(_:)))
        return barButtomItem
    }()
    
    lazy var deleteBarButton: UIBarButtonItem = {
        let barButtomItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(didDeleteButtonClicked(_:)))
        return barButtomItem
    }()
    
    var dictionarySelectedIndex: [IndexPath: Bool] = [:]
    

    
    override func viewDidLoad() {
        //getImages()
        super.viewDidLoad()
        setupBarButtonItems()
        setupCollectionView()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupCollectionViewItemSize()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let item = sender as! Item
        if segue.identifier == viewImageSegueIdentifier {
            if let vc = segue.destination as? ImageViewer {
                vc.imageName = item.imageName
            }
        }
    }
    
    private func getImages() {
        for i in 1...16 {
            //getImage()
            self.photoCount += 1
        }
    }
//    private func getImage() {
//        if var urlComponents = URLComponents(string: "https://picsum.photos/200") {
//            guard let url = urlComponents.url else {
//                return
//            }
//            dataTask = session.dataTask(with: url) { [weak self] data, response, error in
//                defer {
//                    self?.dataTask = nil
//                }
//                if let err = error {
//                    print("Error: \(err)")
//                } else if
//                    let data = data,
//                    let response = response as? HTTPURLResponse,
//                    response.statusCode == 200 {
//                    let downloadedImage = UIImage(data: data)
//                    self?.items.append(Item(image: downloadedImage as! UIImage, imageName: "photo\(self?.photoCount)"))
//                }
//            }
//
//        }
//    }
    
//    private func getImage() {
//        let url = URL(string: "https://picsum.photos/200")
//        let data = try? Data(contentsOf: url!)
//        if let imageData = data {
//            let downloadedImage = UIImage(data: imageData)
//            self.items.append(Item(image: downloadedImage as! UIImage, imageName: "photo\(self.photoCount)"))
//        }
//    }
    
    private func setupBarButtonItems() {
        navigationItem.rightBarButtonItem = selectBarButton
        
    }

    private func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        let nib = UINib(nibName: cellIndentifier, bundle: nil)
        collectionView.register(nib, forCellWithReuseIdentifier: cellIndentifier)
    }
    
    private func setupCollectionViewItemSize() {
        if collectionViewFlowLayout == nil {
            let numItemPerRow: CGFloat = 3
            let lineSpacing: CGFloat = 5
            let interITemSpacing: CGFloat = 5
            
            let width = (collectionView.frame.width - (numItemPerRow - 1) * interITemSpacing) / numItemPerRow
            let height = width
            
            collectionViewFlowLayout = UICollectionViewFlowLayout()
            collectionViewFlowLayout.itemSize = CGSize(width: width, height: height)
            collectionViewFlowLayout.sectionInset = UIEdgeInsets.zero
            collectionViewFlowLayout.scrollDirection = .vertical
            collectionViewFlowLayout.minimumLineSpacing = lineSpacing
            collectionViewFlowLayout.minimumInteritemSpacing = interITemSpacing
            collectionView.setCollectionViewLayout(collectionViewFlowLayout, animated: true)
        }
    }
    
    @objc func didSelectButtonClicked(_ sender: UIBarButtonItem) {
        mMode = mMode == .view ? .select : .view
    }
    @objc func didDeleteButtonClicked(_ sender: UIBarButtonItem) {
        var deleteNeedIndexPath: [IndexPath] = []
        for (key, value) in dictionarySelectedIndex {
            if value {
                deleteNeedIndexPath.append(key)
            }
        }
        for i in deleteNeedIndexPath.sorted(by: {$0.item > $1.item}) {
            items.remove(at: i.item)
        }
        
        collectionView.deleteItems(at: deleteNeedIndexPath)
        dictionarySelectedIndex.removeAll()
    }

}

extension ViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellIndentifier, for: indexPath) as! ItemCollectionViewCell
        
        //getImage()
//        if let randomImage = currentImage {
        cell.imageView.image = UIImage(named: items[indexPath.row].imageName)
//        }
    
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch mMode {
        case .view:
            collectionView.deselectItem(at: indexPath, animated: true)
            let item = items[indexPath.item]
            performSegue(withIdentifier: viewImageSegueIdentifier, sender: item)
        case .select:
            dictionarySelectedIndex[indexPath] = true
        }
    }
    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        if mMode == .select {
            dictionarySelectedIndex[indexPath] = false
        }
    }
}
