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
        static let tableOffset: CGFloat = 10
    }
    
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    // MARK: - Variables
    var presenter: WishCalendarPresenter?
    private var events: [EventEntity] = []
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchEvents()
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
        collectionView.dataSource = self
        collectionView.delegate = self

        view.addSubview(collectionView)
        
        collectionView.pin(to: view, Constants.tableOffset)
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
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
    
    private func fetchEvents() {
        events = CoreDataStack.shared.fetchEvents()
        collectionView.reloadData()
    }

    
    @objc 
    private func addEventButtonTapped() {
        let wishEventCreationVC = WishEventCreationModuleBuilder.build()
        
        wishEventCreationVC.onEventAdded = { [weak self] in
            self?.fetchEvents()
        }
        
        present(wishEventCreationVC, animated: true)
    }
}

extension WishCalendarViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return events.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: WishEventCell.reuseIdentifier, for: indexPath) as? WishEventCell else {
            return UICollectionViewCell()
        }
        let event = events[indexPath.item]
        cell.configure(with: event)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - 20
        return CGSize(width: width, height: 100)
    }
    
    
}
