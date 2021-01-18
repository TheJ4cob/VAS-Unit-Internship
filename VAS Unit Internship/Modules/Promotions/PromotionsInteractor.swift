//
//  PromotionsInteractor.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit


final class PromotionsInteractor{
    
    // MARK: - Public Propeties
    
    weak var presenter: PromotionsPresenterProtocol?
    
    var promotionsLoader: LoadDataProtocol?
    var imageLoader: LoadDataProtocol?
    var parser: PromotionParserProtocol?
    
    // MARK: - Private Propeties
    
    private var promotions: Promotions?
    private var choosedPromotion: Promotion?
    private var iconData: [String:Data?] = [:]
    
    // MARK: - Initialization
    
    init(presenter: PromotionsPresenterProtocol) {
        self.presenter = presenter
    }
    
}

// MARK: - Promotions Interactor Protocol Realization

extension PromotionsInteractor: PromotionsInteractorProtocol{
    
    // Загружает данные, изображения и убирает select у первого элемента
    
    func loadData() {
        promotionsLoader?.loadData(from: "result", complition: { (data) in
            guard let jsonData = data else { return }
            self.promotions = self.parser?.parseData(from: jsonData)
            guard let promotions = self.promotions?.promotions else { return }
            self.choosedPromotion = nil
            
            for promotion in promotions {
                self.loadImage(from: promotion.icon.url) { (data) in
                    self.iconData[promotion.id] = data
                }
            }
            promotions.first?.isSelected = false
        })
        
    }
    
    // Метод загружает данные для icon
    func getIconData(at index: Int) -> Data? {
        guard let promotionId = promotions?.promotions[index].id else { return nil }
        guard let data = iconData[promotionId] else { return nil }
        return data
    }
    
    // Метод загружает изображения
    func loadImage(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        imageLoader?.loadData(from: source, complition: complition)
    }
    
    // Метод для подсчета количества promotions
    func promotionsCount() -> Int? {
        return promotions?.promotions.count
    }
    
    // Метод проверяет, отмечен ли Promotion
    func isPromotionChoosed(at index: Int) -> Bool? {
        return promotions?.promotions[index].isSelected
    }
    
    // Метод проверяет, есть ли какой - нибудь отмеченый Promotion
    func isAnyPromotionChoosed() -> Bool {
        return choosedPromotion != nil
    }
    
    // Метод для отображения только 1 выбранного действия
    func singlePromotionChoose(at index: Int) {
        
        guard let promotion = promotions?.promotions[index] else { return }
        
        promotion.isSelected = !promotion.isSelected
        
        if let promotion = choosedPromotion {
            promotion.isSelected = false
        }
        if promotion.isSelected {
            choosedPromotion = promotion
        } else {
            choosedPromotion = nil
        }
    }
    
    // Метод получения URL для иконки по индксу
    func getPromotionIconURL(at index: Int) -> String? {
        return promotions?.promotions[index].icon.url
    }
    
    // Метод получения Title по индексу
    func getPromotionTitle(at index: Int) -> String? {
        return promotions?.promotions[index].title
    }
    
    // Метод получения Description по индексу
    func getPromotionDescription(at index: Int) -> String? {
        return promotions?.promotions[index].description
    }
    
    // Метод получения Price по индексу
    func getPromotionPrice(at index: Int) -> String? {
        return promotions?.promotions[index].price
    }
    
    // Метод получения Header основного View
    func getHeaderTitle() -> String? {
        return promotions?.title
    }
    
    // Метод получения Title для кнопки выбора, если действие не выбрано
    func getNotChoosedButtonTitle() -> String? {
        return promotions?.actionTitle
    }
    
    // Метод получения Title для кнопки, если действие выбрано
    func getChoosedPromotionButton() -> String? {
        return promotions?.selectedActionTitle
    }
    
    // Метод получения Title от выбранного Promotion
    func getChoosedPromotionTitle() -> String? {
        return choosedPromotion?.title
    }
    
    // Метод получения Description от выбранного Promotion
    func getChoosedPromotionDescription() -> String? {
        return choosedPromotion?.description
    }
    
}
