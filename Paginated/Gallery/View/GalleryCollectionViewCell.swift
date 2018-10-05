//
//  GalleryCollectionViewCell.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class GalleryCollectionViewCell: UICollectionViewCell {
    var galleryController: GalleryCollectionViewController?
    let postImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode  = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 12.0
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init decoder has been implemented")
    }
    
    @objc func animate(){
        if let controller = galleryController{
        }
    }
    
    func setupView(){
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        addSubview(postImage)
        let constraint = [postImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),postImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),postImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),postImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8)]
        NSLayoutConstraint.activate(constraint)
        
    }
    
    func set(forPost post: String) {
        let imageUrl = URL(string: post)!
        let placeholderImage = UIImage(named: "placeholder")!
//        postImage.af_setImage(withURL: imageUrl, placeholderImage: placeholderImage)
    }
}
