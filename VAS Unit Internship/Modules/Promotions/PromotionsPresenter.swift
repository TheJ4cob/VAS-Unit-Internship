//
//  PromotionsPresenter.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit

final class PromotionsPresenter{
    
    // MARK: - Public Propeties
    
    weak var view: PromotionsViewController?
    var interactor: PromotionsInteractorProtocol?
    var router: PromotionsRouterProtocol?
    
    // MARK: - Initialization

    init(view: PromotionsViewController) {
        self.view = view
        self.elementsForView()
    }
    
}

// MARK: - PromotionsPresenterProtocolRealization

extension PromotionsPresenter: PromotionsPresenterProtocol{
    
    // MARK: - Public methods
    
    // Title для Header и настройка кнопки
    func elementsForView() {
        guard let headerTitle = self.interactor?.getHeaderTitle() else { return }
        updateChooseButtonTitle()
        self.view?.setPromotionsHeaderTitle(headerTitle)
    }
    
    // Метод для построения cell по модели данных
    func cellForItem(at index: Int, cell: PromotionCell) {
        
        guard let title = interactor?.getPromotionTitle(at: index) else { return }
        
        var description = ""
        
        if let descriptionData = interactor?.getPromotionDescription(at: index)  {
            description = descriptionData
        }
        
        guard let isSelected = interactor?.isPromotionChoosed(at: index) else { return }
        
        guard let price = interactor?.getPromotionPrice(at: index) else { return }
        
        let iconImage: UIImage?
        if let imageData = interactor?.getIconData(at: index) {
            iconImage = UIImage(data: imageData)
        } else {
            iconImage = nil
        }
        
        DispatchQueue.main.async {
            cell.setIcon(iconImage)
        }
        
        cell.setTitleText(title)
        cell.setDescriptionText(description)
        cell.setPriceText(price)
        cell.setChoosedImage(UIImage(named: "checkmark.pdf"))
        cell.setIsHidenValue(!isSelected)
        
    }
    
    // Метод сообщает о выборе элемента по индексу
    func itemDidSelect(at index: Int) {
        
        updateChooseButtonTitle()
        interactor?.singlePromotionChoose(at: index)
        guard let offset = view?.promotionsCollectionView.contentOffset else { return }
        view?.promotionsCollectionView.setContentOffset(offset, animated: false)
        view?.promotionsCollectionView.reloadData()
        view?.promotionsCollectionView.layoutIfNeeded()
        
    }
    
    // Метод получения количества элементов модели
    func countOfPromotionsItems() -> Int {
        if let countResult = interactor?.promotionsCount() {
            return countResult
        }
        return 0
    }
    
    // Метод сообщает о том, что кнопка выбора была нажата и показывает alert
    func chooseButtonClicked() {
        
        var alertTitle = "Услуга продвижения не выбрана"
        var alertMessage = " "
        
        if let choosedPromotionTitle = interactor?.getChoosedPromotionTitle() {
            alertTitle = choosedPromotionTitle
        }
        if let description = interactor?.getChoosedPromotionDescription(){
            alertMessage = description
        }
        
        router?.showAlert(title: alertTitle, actionTitle: "OK", message: alertMessage)
        
    }
    
    // Метод для обновления Title кнопки выбора
    func updateChooseButtonTitle() {
        
        guard let interactor = interactor else { return }
        let chooseButtonTitle: String
        
        if interactor.isAnyPromotionChoosed() {
            guard let choosedTitle = interactor.getNotChoosedButtonTitle() else { return }
            chooseButtonTitle = choosedTitle
        } else {
            guard let notChoosedTitle = interactor.getChoosedPromotionButton()else { return }
            chooseButtonTitle = notChoosedTitle
        }
        
        self.view?.setChooseButtonTitle(chooseButtonTitle)
        
    }
    
}
