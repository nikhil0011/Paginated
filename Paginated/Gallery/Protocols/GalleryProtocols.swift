//
//  GalleryProtocols.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation
import UIKit

protocol GalleryPresenterProtocol: class {
    var view: GalleryViewProtocol? { get set }
    var interactor: GalleryViewInteractorInputProtocol? { get set }
    var wireFrame: GalleryViewWireFrameProtocol? { get set }
    
    // VIEW -> PRESENTER
    func viewDidLoad()
}

protocol GalleryViewProtocol: class {
    var presenter: GalleryPresenterProtocol? { get set }
    
    // PRESENTER -> VIEW
    func showMoviewPosts(with posts: Array<MoviesPost>)
    
    func showError()
    
    func showLoading()
    
    func hideLoading()
}

protocol GalleryViewInteractorInputProtocol: class {
    var presenter: GalleryViewInteractorOutputProtocol? { get set }
    var remoteDatamanager: GalleryDataViewRemoteDataManagerInputProtocol? { get set }
    
    // PRESENTER -> INTERACTOR
    func retrievePostsList()
}


protocol GalleryViewWireFrameProtocol: class {
    static func createGalleryModule() -> UIViewController
    // PRESENTER -> WIREFRAME
}

protocol GalleryViewInteractorOutputProtocol: class {
    // INTERACTOR -> PRESENTER
    func didRetrieveMoviewPosts(_ posts: Array<MoviesPost>)
    func onError()
}

protocol GalleryDataViewRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: GalleryDataViewRemoteDataManagerOutputProtocol? { get set }
    
    // INTERACTOR -> REMOTEDATAMANAGER
    func retrievePostsDataList()

}


protocol GalleryDataViewRemoteDataManagerOutputProtocol: class {
    // REMOTEDATAMANAGER -> INTERACTOR
    func onPostsDataRetrieved(_ post: Array<MoviesPost>)
    func onError()
}


