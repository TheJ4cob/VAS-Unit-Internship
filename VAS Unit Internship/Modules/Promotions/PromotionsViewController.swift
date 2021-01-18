//
//  PromotionsViewController.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit


final class PromotionsViewController: UIViewController {
    
    // MARK: - Public Propeties
    
    var presenter: PromotionsPresenterProtocol?
    var builder: PromotionsBuilderProtocol = PromotionsBuilder()
    
    // MARK: - Private Properties
    
    private var closeButton = UIButton()
    private var promotionsHeaderLabel = UILabel()
    private var chooseButton = UIButton()
    private var collectionViewLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        
        return flowLayout
    }()
    
    // MARK: - Public Propeties
    
    var promotionsCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = .white
        collectionView.register(PromotionCell.self, forCellWithReuseIdentifier: "PromotionCell")
        
        return collectionView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.configure()
        self.setupLayout()
        builder.createModule(with: self)
        
    }
    
}



// MARK: - Promotions View Controller Protocol Realization

extension PromotionsViewController: PromotionsViewControllerProtocol{
    
    // MARK: - Public Methods
    
    func setPromotionsHeaderTitle(_ title: String) {
        self.promotionsHeaderLabel.text = title
    }
    
    func setChooseButtonTitle(_ title: String) {
        self.chooseButton.setTitle(title, for: .normal)
    }
    
    @objc
    func chooseButtonClicked() {
        presenter?.chooseButtonClicked()
        self.animateView(chooseButton)
    }
    
}

// MARK: - Configure, Layout, Animation

extension PromotionsViewController{
    
    // Настройка элементов основного View
    func configure(){
        
        // Добавление элементов к основному view
        self.view.addSubviews(closeButton, promotionsHeaderLabel, promotionsCollectionView, chooseButton)
        
        // Настройка Close Image
        let closeIconImage = UIImage(named: "CloseIconTemplate.pdf")
        closeButton.setImage(closeIconImage, for: .normal)
        closeButton.isUserInteractionEnabled = false
        
        // Настройка для Header
        promotionsHeaderLabel.textAlignment = .left
        promotionsHeaderLabel.font = .systemFont(ofSize: 28, weight: .bold)
        promotionsHeaderLabel.numberOfLines = .max
        
        // Настройка CollectionView
        promotionsCollectionView.collectionViewLayout = collectionViewLayout
        promotionsCollectionView.showsVerticalScrollIndicator = false
        promotionsCollectionView.delegate = self
        promotionsCollectionView.dataSource = self
        
        // Настройка для кнопки выбора
        chooseButton.titleLabel?.textColor = .white
        chooseButton.addTarget(self, action: #selector(chooseButtonClicked), for: .touchUpInside)
        chooseButton.layer.cornerRadius = 10
        chooseButton.backgroundColor = UIColor(red: 80.0 / 255.0,
                                               green: 172.0 / 255.0,
                                               blue: 1.0,
                                               alpha: 1.0)
    }
    
    // Настройка Layout, constaint и анимаций
    func setupLayout(){
        
        
        self.view.backgroundColor = .white
        
        // Безопасная зона по краям экрана
        let safeArea = view.safeAreaLayoutGuide
        
        // Constraints и Item Size для Collection View
        collectionViewLayout.estimatedItemSize = CGSize(width: safeArea.layoutFrame.width - 40, height: 0)
        NSLayoutConstraint.activate([
            promotionsCollectionView.topAnchor.constraint(equalTo: self.promotionsHeaderLabel.bottomAnchor, constant: 20),
        promotionsCollectionView.bottomAnchor.constraint(equalTo: self.chooseButton.topAnchor, constant: -20),
        promotionsCollectionView.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15),
        promotionsCollectionView.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
        
        
        // Constraints для Close Button
        closeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
        closeButton.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor, constant: 15),
        closeButton.widthAnchor.constraint(equalToConstant: 30),
        closeButton.heightAnchor.constraint(equalToConstant: 30),
        
        // Constraints для Header
        promotionsHeaderLabel.topAnchor.constraint(equalTo: self.closeButton.bottomAnchor, constant: 10),
        promotionsHeaderLabel.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15),
        promotionsHeaderLabel.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
        
        // Constraints для Choose Button
        chooseButton.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -10),
        chooseButton.leftAnchor.constraint(equalTo: safeArea.leftAnchor, constant: 15),
        chooseButton.rightAnchor.constraint(equalTo: safeArea.rightAnchor, constant: -15),
        chooseButton.heightAnchor.constraint(equalToConstant: 50)
        ])
        
    }
    
    // Анимация кнопки
        func animateView(_ viewToAnimate: UIView) {
            UIView.animate(withDuration: 0.17, delay: 0, usingSpringWithDamping: 0.2, initialSpringVelocity: 5, options: .curveEaseIn) {
                viewToAnimate.transform = CGAffineTransform(scaleX: 0.90, y: 0.90)
            } completion: { (_) in
                UIView.animate(withDuration: 0.17, delay: 0, usingSpringWithDamping: 5, initialSpringVelocity: 1, options: .curveEaseIn) {
                    viewToAnimate.transform = CGAffineTransform(scaleX: 1, y: 1)
                } completion: { (_) in }
            }

    }
}


// MARK: - UICollectionViewDelegate

extension PromotionsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.itemDidSelect(at: indexPath.row)
    }
}

// MARK: - UICollectionViewDataSource


extension PromotionsViewController: UICollectionViewDataSource {
    
    // Количество ячеек
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if let presenter = presenter {
            return presenter.countOfPromotionsItems()
        }
        return 0
    }
    
    // Ячейка по модели
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromotionCell", for: indexPath)
        if let promotionCell = cell as? PromotionCell {
            presenter?.cellForItem(at: indexPath.row, cell: promotionCell)
            return promotionCell
        }
        return cell
    }
}
