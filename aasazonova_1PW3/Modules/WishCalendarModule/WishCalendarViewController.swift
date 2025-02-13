//
//  WishCalendarViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//


import UIKit

// MARK: - WishCalendarView Protocol
protocol WishCalendarViewProtocol: AnyObject {

}

final class WishCalendarViewController: UIViewController, WishCalendarViewProtocol {
    
    // MARK: - Constants
    enum Constants {
        static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let collectionTop: CGFloat = 20
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
    }
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Variables
    var presenter: WishCalendarPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        navigationController?.navigationBar.tintColor = Constants.darkBlue
        view.backgroundColor = Constants.lightBlue
        loadCells()
        configureCollection()
        configureAddWishButton()
    }
    
    private func loadCells() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = 0
            layout.minimumLineSpacing = 0
            layout.invalidateLayout()
        }
    }
    
    private func configureCollection() {
        collectionView.backgroundColor = Constants.lightBlue
        collectionView.alwaysBounceVertical = true
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInset = Constants.contentInset
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        view.addSubview(collectionView)
        
        collectionView.pinCenterX(to: view)
        collectionView.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor)
        collectionView.pinTop(to: view.safeAreaLayoutGuide.topAnchor)
    }
    
    private func configureAddWishButton() {
        let addEventButton: UIBarButtonItem = UIBarButtonItem(
            barButtonSystemItem: .add,
            target: self,
            action: #selector(addEventButtonTapped)
        )
        addEventButton.tintColor = Constants.darkBlue
        navigationItem.rightBarButtonItem = addEventButton
    }

    
    @objc 
    private func addEventButtonTapped() {
        present(WishEventCreationModuleBuilder.build(), animated: true)
    }
}
