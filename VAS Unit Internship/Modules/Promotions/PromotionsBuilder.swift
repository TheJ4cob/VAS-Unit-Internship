//
//  PromotionsBuilder.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//


import UIKit

class PromotionsBuilder: PromotionsBuilderProtocol {
    
    func createModule(with viewController: PromotionsViewController) {
        
        let presenter = PromotionsPresenter(view: viewController)
        let interactor = PromotionsInteractor(presenter: presenter)
        let router = PromotionsRouter(view: viewController)
        
        // ViewController Builder
        viewController.presenter = presenter
        
        // Interactor builder
        interactor.presenter = presenter
        interactor.parser = PromotionsParser()
        interactor.promotionsLoader = DataLoader()
        interactor.imageLoader = ImageLoader()

        // Presenter builder
        presenter.interactor = interactor
        presenter.router = router
        
        interactor.loadData()
        presenter.elementsForView()
        
    }
    
}
