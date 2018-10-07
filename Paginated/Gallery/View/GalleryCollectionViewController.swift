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
        self.collectionView.prefetchDataSource = self
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
    
    var tempImageview: UIImageView?
    let blackBackground = UIView()
    var cellImageView = UIImageView()
    let navbarCoverView = UIView()
    
    func animateImageView(imageView: UIImageView,title: UILabel,year: UILabel){
        self.tempImageview = imageView
        
        self.blackBackground.frame = view.frame
        self.blackBackground.backgroundColor = .black
        self.blackBackground.alpha = 0
        view.addSubview(self.blackBackground)
        
        /*
         *Setting up nav bar black cover
         */
        if let navController = self.navigationController{
            navbarCoverView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: navController.navigationBar.frame.height + 20)
        }else{
            navbarCoverView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: 44.0 + 20.0)
        }
        navbarCoverView.backgroundColor = .black
        navbarCoverView.alpha = 0
        /*
         *We can use add subview to add subview on to view
         but above it on nav controller it's to be done via key window
         */
        if let keywindow = UIApplication.shared.keyWindow{
            keywindow.addSubview(navbarCoverView)
        }
        if let startFrame = imageView.superview?.convert(imageView.frame, to: nil){

            cellImageView.frame = startFrame
            cellImageView.image = imageView.image
            cellImageView.isUserInteractionEnabled = true
            cellImageView.contentMode = .scaleAspectFill
//            cellImageView.addSubview(title)
//            cellImageView.addSubview(year)
            view.addSubview(cellImageView)
            

            cellImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutImageview)))
            
            let newHeight = self.view.frame.width * startFrame.height / self.view.frame.width
            let y = self.view.frame.height / 2 - newHeight/2

            UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
                self.cellImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: newHeight)
                self.blackBackground.alpha = 1
                self.navbarCoverView.alpha = 1
            }, completion: { (didComplete) -> Void in
            })
        }
    }
    
    @objc fileprivate func zoomOutImageview(){
        if let startFrame = tempImageview?.superview?.convert((tempImageview?.frame)!, to: nil){
            UIView.animate(withDuration: 0.75, animations: {
                self.cellImageView.frame = startFrame
                self.blackBackground.alpha = 0
                self.navbarCoverView.alpha = 0
            }, completion: {(didComplete) -> Void in
                self.cellImageView.removeFromSuperview()
                self.blackBackground.removeFromSuperview()
                self.navbarCoverView.removeFromSuperview()
                self.tempImageview?.alpha = 1
            })
        }
    }
    
}
extension GalleryCollectionViewController: GalleryViewProtocol {
    func showMoviewPosts(with posts: Array<MoviesPost>, with newIndexPathsToReload: [IndexPath]?) {
        guard let indexes = newIndexPathsToReload else{
            self.galleryPosts = posts
            collectionView?.reloadData()
            return
        }
        let indexPathsToReload = visibleIndexPathsToReload(intersecting: indexes)
        collectionView.reloadItems(at: indexPathsToReload)
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
        return CGSize(width: collectionViewSize/2, height: 300)
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
        return galleryPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        cell.set(forPost: galleryPosts[indexPath.row])
        cell.galleryController = self
        return cell
    }
    
    
    //   override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    //        let row = indexPath.row
    //        let post = flickrPosts[row]
    //        presenter?.showPostDetail(forPost: post)
    //    }
}
extension GalleryCollectionViewController: UICollectionViewDataSourcePrefetching{
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        //    Returns a Boolean value indicating whether the sequence contains an
        //    element that satisfies the given predicate.
        debugPrint("Pagination")
        if indexPaths.contains(where: isLoadingCell) {
            presenter?.viewDidLoad()
        }
    }
    
    
}
extension GalleryCollectionViewController{
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        debugPrint("indexPath.row",indexPath.row)
        debugPrint("galleryPosts.count",galleryPosts.count)

//        return indexPath.row >= presenter.currentCount
        return indexPath.row >= galleryPosts.count - 1
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = collectionView.indexPathsForVisibleItems ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
    
}
