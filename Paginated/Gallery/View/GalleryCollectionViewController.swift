//
//  GalleryCollectionViewController.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class GalleryCollectionViewController: UICollectionViewController {
    var presenter: GalleryPresenterProtocol?
    var galleryPosts = Array<MoviesPost>()
    var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Register cell classes
        navigationItem.title = "OMDB Feed"
        collectionView?.backgroundColor = UIColor(white: 0.95, alpha: 1)
        self.navigationController?.navigationBar.prefersLargeTitles = false
        self.navigationController?.navigationBar.barTintColor = UIColor.rgb(red: 246, green: 246, blue: 246)
        self.navigationController?.navigationBar.titleTextAttributes   = [NSAttributedString.Key.foregroundColor: UIColor.black]
        
        self.collectionView!.register(GalleryCollectionViewCell.self, forCellWithReuseIdentifier: reuseIdentifier)
        setupIndicator()
        presenter?.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    fileprivate func setupIndicator(){
        self.indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        self.indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.indicator.center = view.center
        self.view.addSubview(self.indicator)
        self.view.bringSubviewToFront(self.indicator)
    }
    
    fileprivate func showLoader(){
        self.indicator.startAnimating()
    }
    fileprivate func hideLoader(){
        self.indicator.stopAnimating()
    }

}
extension GalleryCollectionViewController: GalleryViewProtocol {
    func showMoviewPosts(with posts: Array<MoviesPost>){
        self.galleryPosts = posts
        collectionView?.reloadData()
    }
    
    func showError() {
        self.hideLoader()
        //Show Error Loader
    }
    
    func showLoading() {
        self.showLoader()
        //Show Loader
    }
    
    func hideLoading() {
        self.hideLoader()
        //Hide Loader
    }
}

extension GalleryCollectionViewController: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  16
        let collectionViewSize = collectionView.frame.size.width - padding
        return CGSize(width: collectionViewSize/2, height: collectionViewSize/2)
    }
}

extension GalleryCollectionViewController{
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        debugPrint("Count in numberOfItemsInSection",self.galleryPosts.count)
        return galleryPosts.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        debugPrint("GAllery Post")
        if let url = galleryPosts[indexPath.row].posterUrl{
            cell.set(forPost: url)
            cell.galleryController = self
        }
        return cell
    }
    
    
    //   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let row = indexPath.row
    //        let post = flickrPosts[row]
    //        presenter?.showPostDetail(forPost: post)
    //    }
}
