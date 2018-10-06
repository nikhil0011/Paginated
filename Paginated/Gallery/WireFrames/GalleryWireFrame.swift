//
//  GalleryWireFrame.swift
//  Paginated
//
//  Created by Admin on 10/6/18.
//  Copyright © 2018 Demo. All rights reserved.
//

import UIKit

class GalleryWireFrame: GalleryViewWireFrameProtocol {    
    
    static func createGalleryModule() -> UIViewController {
        let view = GalleryCollectionViewController(collectionViewLayout: UICollectionViewFlowLayout())
        let presenter: GalleryPresenterProtocol & GalleryViewInteractorOutputProtocol = GalleryPresenter()
        let interactor: GalleryViewInteractorInputProtocol & GalleryDataViewRemoteDataManagerOutputProtocol = GalleryInteractor()
        let request = OMDBRequest.from()
        let remoteDataManager: GalleryDataViewRemoteDataManagerInputProtocol = GalleryPostsRemoteDataManager(request: request)
        let wireFrame: GalleryViewWireFrameProtocol = GalleryWireFrame()
        
        view.presenter = presenter
        presenter.view = view
        presenter.wireFrame = wireFrame
        presenter.interactor = interactor
        interactor.presenter = presenter
        interactor.remoteDatamanager = remoteDataManager
        remoteDataManager.remoteRequestHandler = interactor
        debugPrint("view",view)
        return view
    }
}
