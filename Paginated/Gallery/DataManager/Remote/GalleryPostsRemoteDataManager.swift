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
//        if (currentPage <= total){
//             let request = OMDBRequest.from(page: "1")
//        }
        
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
                if let totalNumOfResults = response.totalResults{
                    self.total = Int(totalNumOfResults)!
                }
                DispatchQueue.main.async {
                    self.currentPage += 1
                    self.isFetchInProgress = false
                    if let posts = response.search{
                        if (self.moviePosts.count > 0){
                            self.moviePosts += posts
                            let indexPathsToReload = self.calculateIndexPathsToReload(from: posts)
                            self.remoteRequestHandler?.onPostsDataRetrieved(self.moviePosts, with: indexPathsToReload)
                        }else{
                            self.moviePosts += posts
                            self.remoteRequestHandler?.onPostsDataRetrieved(self.moviePosts, with: nil)
                        }
                    }
                }
            }
        }
    }
    private func calculateIndexPathsToReload(from newMoviePost: [MoviesPost]) -> [IndexPath] {
        let startIndex = moviePosts.count - newMoviePost.count
        let endIndex = startIndex + newMoviePost.count
        return (startIndex..<endIndex).map { IndexPath(row: $0, section: 0) }
    }
}
