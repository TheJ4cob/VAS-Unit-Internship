//
//  UIViewExtension.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit

/*
 Позволяет не писать каждый раз .addSubView и translatesAutoresizingMaskIntoConstraints = false
 */
extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
