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
    
    var tempImageview: UIImageView?
    let blackBackground = UIView()
    var cellImageView = UIImageView()
    let navbarCoverView = UIView()
    let tabbarCoverView = UIView()
    
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
            //            let heightOfTabbar = self.tabBarItem.accessibilityFrame.height
            let heightOfTabbar = 49.0
            
            tabbarCoverView.frame = CGRect(x: 0, y: keywindow.frame.height - 49 , width: keywindow.frame.width, height: 49)
            tabbarCoverView.backgroundColor = .black
            tabbarCoverView.alpha = 0
            keywindow.addSubview(tabbarCoverView)
        }
        
        if let startFrame = imageView.superview?.convert(imageView.frame, to: nil){
            
            cellImageView.frame = startFrame
            cellImageView.image = imageView.image
            cellImageView.isUserInteractionEnabled = true
            cellImageView.contentMode = .scaleAspectFill
            cellImageView.addSubview(title)
            cellImageView.addSubview(year)
            view.addSubview(cellImageView)
            
            
            cellImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(zoomOutImageview)))
            
            let newHeight = self.view.frame.width * startFrame.height / self.view.frame.width
            let y = self.view.frame.height / 2 - newHeight/2
            
            UIView.animate(withDuration: 0.75, delay: 0, options: .curveEaseOut, animations: {
                self.cellImageView.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: newHeight)
                self.blackBackground.alpha = 1
                self.navbarCoverView.alpha = 1
                self.tabbarCoverView.alpha = 1
            }, completion: nil)
        }
    }
    
    @objc fileprivate func zoomOutImageview(){
        if let startFrame = tempImageview?.superview?.convert((tempImageview?.frame)!, to: nil){
            UIView.animate(withDuration: 0.75, animations: {
                self.cellImageView.frame = startFrame
                self.blackBackground.alpha = 0
                self.navbarCoverView.alpha = 0
                self.tabbarCoverView.alpha = 0
            }, completion: {(didComplete) -> Void in
                self.cellImageView.removeFromSuperview()
                self.blackBackground.removeFromSuperview()
                self.navbarCoverView.removeFromSuperview()
                self.tabbarCoverView.removeFromSuperview()
                self.tempImageview?.alpha = 1
            })
        }
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
        return galleryPosts.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: GalleryCollectionViewCell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! GalleryCollectionViewCell
        debugPrint("GAllery Post")
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
