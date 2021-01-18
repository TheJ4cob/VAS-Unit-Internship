//
//  PromotionsProtocols.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import Foundation


protocol PromotionsViewControllerProtocol: class {
    
    // Сообщает View о том, что надо установить title для Header
    func setPromotionsHeaderTitle(_ title: String)
    
    // Сообщает View о том, что надо установить title для кнопки "Выбрать"
    func setChooseButtonTitle(_ title: String)
    
    // Сообщает View о том, что кнопка "Выбрать" была нажата
    func chooseButtonClicked()
    
}

protocol PromotionsInteractorProtocol: class {
    
    // Метод сообщает интерактору о том, что надо загрузить данные
    func loadData()
    
    // Метод сообщает интерактору о том, что надо загрузить данные иконки
    func getIconData(at index: Int) -> Data?
    
    // Метод сообщает интерактору о том, что надо загрузить изображения
    func loadImage(from source: String, complition: @escaping (_ data: Data?) -> Void)
    
    // Метод для подсчета количества promotions
    func promotionsCount() -> Int?
    
    // Метод проверяет, отмечен ли Promotion
    func isPromotionChoosed(at index: Int) -> Bool?
    
    // Метод проверяет, есть ли какой - нибудь отмеченый Promotion
    func isAnyPromotionChoosed() -> Bool
    
    // Метод для отображения только 1 выбранного действия
    func singlePromotionChoose(at index: Int)
    
    // Методы получения данных для каждого Promotion
    func getPromotionIconURL(at index: Int) -> String?
    func getPromotionTitle(at index: Int) -> String?
    func getPromotionDescription(at index: Int) -> String?
    func getPromotionPrice(at index: Int) -> String?
    
    // Метод получения Header
    func getHeaderTitle() -> String?
    
    // Метод получения Title для кнопки выбора, если действие не выбрано
    func getNotChoosedButtonTitle() -> String?

    // Метод получения Title для кнопки, если действие выбрано
    func getChoosedPromotionButton() -> String?
    
    // Метод получения Title от выбранного Promotion
    func getChoosedPromotionTitle() -> String?
    
    // Метод получения Description от выбранного Promotion
    func getChoosedPromotionDescription() -> String?
    
}

protocol PromotionsPresenterProtocol: class {
    
    // Метод получения и настройки элементов для основного View
    func elementsForView()
    
    // Метод для построения cell по модели данных
    func cellForItem(at index: Int, cell: PromotionCell)
    
    // Метод сообщает о выборе элемента по индексу
    func itemDidSelect(at index: Int)
    
    // Метод получения количества элементов модели
    func countOfPromotionsItems() -> Int
    
    // Метод сообщает о том, что кнопка выбора была нажата
    func chooseButtonClicked()
    
    // Метод для обновления Title кнопки выбора
    func updateChooseButtonTitle()
    
}

protocol PromotionsRouterProtocol {
        
    // Метод для отображения Alert
    func showAlert(title: String, actionTitle: String, message: String)
    
}

protocol PromotionsBuilderProtocol: class {
    
    // Метод создания модуля
    func createModule(with: PromotionsViewController)
}




