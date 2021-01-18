//
//  PromotionCell.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit


// Ячейки для отображения вариантов продвижения объявления
final class PromotionCell: UICollectionViewCell {
    
    // MARK: - Private propeties
    
    private var promotionsTitleLabel = UILabel()
    private var descriptionLabel = UILabel()
    private var priceLabel = UILabel()
    private var iconImageView = UIImageView()
    private var chooseIconImageView = UIImageView()
    
    // MARK: - Public propeties
    
    lazy var width: NSLayoutConstraint = {
        let width = contentView.widthAnchor.constraint(equalToConstant: safeAreaLayoutGuide.layoutFrame.width)
        width.isActive = true
        return width
    }()
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.configure()
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Override
    
    override func systemLayoutSizeFitting(_ targetSize: CGSize, withHorizontalFittingPriority horizontalFittingPriority: UILayoutPriority, verticalFittingPriority: UILayoutPriority) -> CGSize {
        width.constant = safeAreaLayoutGuide.layoutFrame.width
        return contentView.systemLayoutSizeFitting(CGSize(width: targetSize.width, height: 0))
    }
    
    // MARK: - Public methods
    
    func setTitleText(_ title: String) {
        promotionsTitleLabel.text = title
    }
    
    func setDescriptionText(_ description: String) {
        descriptionLabel.text = description
    }
    
    func setPriceText(_ price: String) {
        priceLabel.text = price
    }
    
    func setIcon(_ image: UIImage?) {
        iconImageView.image = image
    }
    
    func setChoosedImage(_ image: UIImage?) {
        chooseIconImageView.image = image
    }
    
    func setIsHidenValue(_ isHidden: Bool) {
        chooseIconImageView.isHidden = isHidden
    }
    
    
}

// MARK: - Configure, layout

private extension PromotionCell{
    
    // Настройка элементов ячейки
    
    func configure(){
        
        // Backgroundcolor для ячеек
        self.backgroundColor = UIColor(red: 248.0 / 255,
                                       green: 248.0 / 255,
                                       blue: 248.0 / 255,
                                       alpha: 1.0)
        
     
        // Настройка Label
        promotionsTitleLabel.numberOfLines = .max
        promotionsTitleLabel.font = .systemFont(ofSize: 27, weight: .bold)
        
        // Настройка description с переносом строк по размеру слова
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = .systemFont(ofSize: 14, weight: .regular)
        descriptionLabel.textColor = #colorLiteral(red: 0.03935233504, green: 0.03935233504, blue: 0.03935233504, alpha: 1)
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        
        // Настройка price
        priceLabel.font = .systemFont(ofSize: 19, weight: .bold)
        
        // Настройка header
        promotionsTitleLabel.font = .systemFont(ofSize: 20, weight: .bold)
        
        /*
         Добавление всех View,
         автоматически translatesAutoresizingMaskIntoConstraints = false
         Метод реализован через extension к UIView
         */
        
        contentView.addSubviews(promotionsTitleLabel, descriptionLabel, priceLabel, chooseIconImageView, iconImageView)
        
    }
    
    // Настройка layout и constraints
    func setupLayout(){
        
        // Округленные углы у cell
        self.layer.cornerRadius = 10
        
        contentView.translatesAutoresizingMaskIntoConstraints = false

        // Настройка constaints
        NSLayoutConstraint.activate([
            
            // Constraints для Title
            promotionsTitleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            promotionsTitleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            promotionsTitleLabel.rightAnchor.constraint(equalTo: chooseIconImageView.leftAnchor, constant: -10),
            
            // Constraints для Description
            descriptionLabel.topAnchor.constraint(equalTo: promotionsTitleLabel.bottomAnchor, constant: 10),
            descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            descriptionLabel.rightAnchor.constraint(equalTo: chooseIconImageView.leftAnchor, constant: -10),
            
            // Constraints для Price
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 10),
            priceLabel.rightAnchor.constraint(equalTo: chooseIconImageView.leftAnchor, constant: -10),
            
            // Constraints для иконки продвижения
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 55),
            iconImageView.heightAnchor.constraint(equalToConstant: 55),
            
            
            // Constraints для иконки выделения
            chooseIconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 25),
            chooseIconImageView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -15),
            chooseIconImageView.widthAnchor.constraint(equalToConstant: 25),
            chooseIconImageView.heightAnchor.constraint(equalToConstant: 25),
            
            // Отступ от Price до низа ячейки
            contentView.bottomAnchor.constraint(equalTo: priceLabel.bottomAnchor, constant: 10)
            

        ])
        
    }
}
