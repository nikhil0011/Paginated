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
    let postImage: CachedImageView = {
        let placeholder = UIImage(named: "placeholder")
        
        let imageView = CachedImageView(cornerRadius: 0.0, emptyImage: placeholder)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let movieTitle: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "LALALALLALALLAALALALLAALALLAALLA"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieYear: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.text = "2015"
        label.textColor = .red
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
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
            debugPrint("Before Clicking Frame is",postImage.frame)
            controller.animateImageView(imageView: postImage,title: movieTitle,year: movieYear)
        }
    }
    
    func setupView(){
        layer.cornerRadius = 12.0
        backgroundColor = .white
        postImage.isUserInteractionEnabled = true
        postImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(animate)))
        addSubview(movieYear)
        addSubview(movieTitle)
        addSubview(postImage)

//        let constraint = [postImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8.0),postImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),postImage.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),postImage.topAnchor.constraint(equalTo: movieYear.bottomAnchor, constant: 8.0),movieTitle.topAnchor.constraint(equalTo: topAnchor, constant: 8.0),movieTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),movieTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),movieYear.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8.0),movieYear.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8.0),
//            movieYear.topAnchor.constraint(equalTo: movieTitle.bottomAnchor, constant: 8.0)]
//        NSLayoutConstraint.activate(constraint)
        /**
         *MARK:- Setting Layout constraints using Extension Method
         */
        movieTitle.anchor(self.topAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        movieYear.anchor(movieTitle.bottomAnchor, left: self.leftAnchor, bottom: nil, right: self.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 0, rightConstant: 8, widthConstant: 0, heightConstant: 0)
        postImage.anchor(movieYear.bottomAnchor, left: self.leftAnchor, bottom: self.bottomAnchor, right: self.rightAnchor, topConstant: 8, leftConstant: 8, bottomConstant: 8, rightConstant: 8, widthConstant: 0, heightConstant: 0)
    }
    
    func set(forPost post: MoviesPost) {
        if let poster = post.posterUrl{
                postImage.contentMode = .scaleAspectFit
                postImage.loadImage(urlString: poster)
//                (from: imageUrl)
        }
        if let title = post.title{
            movieTitle.text = title
        }
        if let year = post.year{
            movieYear.text = "Released on : \(year)"
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
extension UIView{
    public func anchor(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false

        _ = anchorWithReturnAnchors(top, left: left, bottom: bottom, right: right, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: bottomConstant, rightConstant: rightConstant, widthConstant: widthConstant, heightConstant: heightConstant)
    }
    public func anchorWithReturnAnchors(_ top: NSLayoutYAxisAnchor? = nil, left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil, topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false

        var anchors = [NSLayoutConstraint]()

        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }

        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }

        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }

        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }

        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }

        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }

        anchors.forEach({$0.isActive = true})

        return anchors
    }
}
