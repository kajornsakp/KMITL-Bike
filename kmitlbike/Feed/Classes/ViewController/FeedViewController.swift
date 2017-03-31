//
//  FeedViewController.swift
//  kmitlbike
//
//  Created by Kajornsak Peerapathananont on 3/30/2560 BE.
//  Copyright © 2560 Kajornsak Peerapathananont. All rights reserved.
//

import UIKit

enum FeedSectionType : Int {
    case mapFeed = 0,statsFeed
}

class FeedViewController: BaseViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    fileprivate let itemsPerRow: CGFloat = 2
    fileprivate let statsSectionInsets = UIEdgeInsets(top: 16.0, left: 20.0, bottom: 32.0, right: 20.0)
    fileprivate let mapSectionInsets = UIEdgeInsets(top: 32.0, left: 20.0, bottom: 0.0, right: 20.0)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.registerNib()
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.setupTitle(title: "Home")
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func registerNib(){
        self.collectionView.register(UINib(nibName: FeedCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: FeedCollectionViewCell.className)
        self.collectionView.register(UINib(nibName: MapFeedCollectionViewCell.className, bundle: nil), forCellWithReuseIdentifier: MapFeedCollectionViewCell.className)
    }

}


extension FeedViewController : UICollectionViewDataSource{

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let sectionType = FeedSectionType(rawValue: section){
            switch sectionType {
            case .mapFeed:
                return 1
            case .statsFeed:
                return 4
            }
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let sectionType = FeedSectionType(rawValue: indexPath.section){
            switch sectionType {
            case .mapFeed:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MapFeedCollectionViewCell.className, for: indexPath) as! MapFeedCollectionViewCell
                return cell
            case .statsFeed:
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FeedCollectionViewCell.className, for: indexPath) as! FeedCollectionViewCell
                return cell
            }
        }
        return UICollectionViewCell(frame: CGRect.zero)
        
    }
    
    
}

extension FeedViewController : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        if let sectionType = FeedSectionType(rawValue: indexPath.section){
            switch sectionType {
            case .mapFeed:
                let paddingSpace = mapSectionInsets.left * (1 + 1)
                let availableWidth = view.frame.width - paddingSpace
                let widthPerItem = availableWidth / 1
                
                return CGSize(width: widthPerItem, height: widthPerItem/2)
            case .statsFeed:
                let paddingSpace = statsSectionInsets.left * (itemsPerRow + 1)
                let availableWidth = view.frame.width - paddingSpace
                let widthPerItem = availableWidth / itemsPerRow
                
                return CGSize(width: widthPerItem, height: widthPerItem)
            }
        }
        return CGSize.zero
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        if let sectionType = FeedSectionType(rawValue: section){
            switch sectionType {
            case .mapFeed:
                return mapSectionInsets
            case .statsFeed:
                return statsSectionInsets
            }
        }
        return UIEdgeInsets.zero
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if let sectionType = FeedSectionType(rawValue: section){
            switch sectionType {
            case .mapFeed:
                return mapSectionInsets.left
            case .statsFeed:
                return statsSectionInsets.left
            }
        }
        return UIEdgeInsets.zero.left
    }
}
