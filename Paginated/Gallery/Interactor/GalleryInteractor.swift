//
//  GalleryInteractor.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

class GalleryInteractor: GalleryViewInteractorInputProtocol {
    weak var presenter: GalleryViewInteractorOutputProtocol?
    var remoteDatamanager: GalleryDataViewRemoteDataManagerInputProtocol?
    
    func retrievePostsList() {
        debugPrint("FlickrGridInteractor")
        remoteDatamanager?.retrievePostsDataList()
    }
}

extension GalleryInteractor: GalleryDataViewRemoteDataManagerOutputProtocol {
    func onPostsDataRetrieved(_ post: Array<MoviesPost>){
        debugPrint("Data Retrived$$$$$$",post.count)
        presenter?.didRetrieveMoviewPosts(post)
    }
    
    func onError() {
        presenter?.onError()
    }
}
