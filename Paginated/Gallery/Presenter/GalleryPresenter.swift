//
//  GalleryPresenter.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

class GalleryPresenter: GalleryPresenterProtocol {
    var wireFrame: GalleryViewWireFrameProtocol?
    weak var view: GalleryViewProtocol?
    var interactor: GalleryViewInteractorInputProtocol?
    
    func viewDidLoad() {
        view?.showLoading()
        interactor?.retrievePostsList()
    }
    
}

extension GalleryPresenter: GalleryViewInteractorOutputProtocol {
    func didRetrieveMoviewPosts(_ posts: Array<MoviesPost>, with newIndexPathsToReload: [IndexPath]?) {
        view?.hideLoading()
        view?.showMoviewPosts(with: posts,with: nil)
    }
    
    func onError() {
        view?.hideLoading()
        view?.showError()
    }
    
}


