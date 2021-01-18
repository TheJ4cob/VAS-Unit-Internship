//
//  PromotionsRouter.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit


final class PromotionsRouter{
    
    // MARK: - Public Propeties
    
    var view: PromotionsViewController
    
    // MARK: - Initialization
    
    init(view: PromotionsViewController) {
        self.view = view
    }
    
}

// MARK: - Promotions Router Protocol Realization

extension PromotionsRouter: PromotionsRouterProtocol{
    
    func showAlert(title: String, actionTitle: String, message desription: String) {
        
        let alertController = UIAlertController(title: title, message: desription, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: actionTitle, style: .default, handler: nil))
        
        let subview = (alertController.view.subviews.first?.subviews.first?.subviews.first!)! as UIView
        subview.backgroundColor = #colorLiteral(red: 0.3172673881, green: 0.6727766395, blue: 0.9985052943, alpha: 1)
        alertController.view.tintColor = .white
        
        
        view.present(alertController, animated: true)
    }
    
}
