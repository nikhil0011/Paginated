//
//  GalleryPostsRemoteDataManager.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import Foundation

class GalleryPostsRemoteDataManager: GalleryDataViewRemoteDataManagerInputProtocol {
    
    var remoteRequestHandler: GalleryDataViewRemoteDataManagerOutputProtocol?
    let client = OMDBExchangeClient()
    let request: OMDBRequest
    private var currentPage = 1
    private var total = 0
    private var moviePosts: [MoviesPost] = []
    private var isFetchInProgress = false

    init(request: OMDBRequest) {
        self.request = request
    }

    func retrievePostsDataList() {
        
        client.fetchMoviesPost(with: request, page: currentPage) { result in
            switch result {
            // 3
            case .failure(let error):
                debugPrint("error",error)
                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    self.remoteRequestHandler?.onError()
                }
            // 4
            case .success(let response):
                debugPrint("response",response)

                DispatchQueue.main.async {
                    self.isFetchInProgress = false
                    if let posts = response.search{
                        self.moviePosts += posts
                    }
                    self.remoteRequestHandler?.onPostsDataRetrieved(self.moviePosts)
                }
            }
        }
    }

}
