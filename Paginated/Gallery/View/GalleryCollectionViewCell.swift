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
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "LALALALLALALLAALALALLAALALLAALLA"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
            controller.animateImageView(imageView: postImage)
        }
    }
    
    func setupView(){
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        addSubview(postImage)
        addSubview(movieTitle)
        let constraint = [postImage.topAnchor.constraint(equalTo: topAnchor, constant: 8),postImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),postImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8),postImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8),movieTitle.bottomAnchor.constraint(equalTo: postImage.bottomAnchor, constant: 20),movieTitle.leadingAnchor.constraint(equalTo: postImage.leadingAnchor, constant: 12),movieTitle.trailingAnchor.constraint(equalTo: postImage.trailingAnchor, constant: -12)]
        NSLayoutConstraint.activate(constraint)
        
    }
    
    func set(forPost post: MoviesPost) {
//        let placeholderImage = UIImage(named: "placeholder")!
        if let poster = post.posterUrl{
            if  let imageUrl = URL(string: poster) {
                postImage.contentMode = .scaleAspectFit
                postImage.downloaded(from: imageUrl)
            }
        }
        if let title = post.title{
            movieTitle.text = title
        }
    }
}
extension UIImageView {
    func downloaded(from url: URL, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        contentMode = mode
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard
                let httpURLResponse = response as? HTTPURLResponse, httpURLResponse.statusCode == 200,
                let mimeType = response?.mimeType, mimeType.hasPrefix("image"),
                let data = data, error == nil,
                let image = UIImage(data: data)
                else { return }
            DispatchQueue.main.async() {
                self.image = image
            }
            }.resume()
    }
    func downloaded(from link: String, contentMode mode: UIView.ContentMode = .scaleAspectFit) {
        guard let url = URL(string: link) else { return }
        downloaded(from: url, contentMode: mode)
    }
}
