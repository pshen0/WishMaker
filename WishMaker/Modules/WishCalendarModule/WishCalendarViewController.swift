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
        // Common
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        
        static let collectionSpacing: CGFloat = 0
        static let collectionTop: CGFloat = 40
        static let collectionBottom: CGFloat = 20
        static let collectionHorizontal: CGFloat = 10
        static let collectionCellOffset: CGFloat = 20
        static let collectionCellHeight: CGFloat = 100

        static let tableOffset: CGFloat = 10
        
        static let backButtonTop: CGFloat = 20
        static let backButtonLeft: CGFloat = 20
        
        static let addButtonTop: CGFloat = 20
        static let addButtonRight: CGFloat = 20
        
        static let addImage: UIImage? = UIImage(
            systemName: "plus",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
        static let backImage: UIImage? = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
    }
    
    private let addEventButton: UIButton = UIButton()
    private let backButton: UIButton = UIButton()
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        fetchEvents()
    }

    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = Constants.lightBlue
        loadCells()
        configureBackButton()
        configureCollection()
        configureAddWishButton()
    }
    
    private func loadCells() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.collectionSpacing
            layout.minimumLineSpacing = Constants.collectionSpacing
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
        
        collectionView.pinTop(to: backButton.topAnchor, Constants.collectionTop)
        collectionView.pinBottom(to: view.bottomAnchor, Constants.collectionBottom)
        collectionView.pinHorizontal(to: view, Constants.collectionHorizontal)
        collectionView.register(WishEventCell.self, forCellWithReuseIdentifier: WishEventCell.reuseIdentifier)
    }
    
    private func configureAddWishButton() {
        addEventButton.setImage(Constants.addImage, for: .normal)
        addEventButton.tintColor = Constants.darkBlue
        
        view.addSubview(addEventButton)
        
        addEventButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.addButtonTop)
        addEventButton.pinRight(to: view.trailingAnchor, Constants.addButtonRight)
        
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func fetchEvents() {
        events = CoreDataEventStack.shared.fetchEvents()
        collectionView.reloadData()
    }
    
    private func deleteEvent(at indexPath: IndexPath) {
        let eventToDelete = events[indexPath.item]
        CoreDataEventStack.shared.deleteEvent(eventToDelete)
        events.remove(at: indexPath.item)
        collectionView.performBatchUpdates({
            collectionView.deleteItems(at: [indexPath])
        }, completion: nil)
    }
    
    @objc 
    private func addEventButtonTapped() {
        let wishEventCreationVC = WishEventCreationModuleBuilder.build()
        
        wishEventCreationVC.onEventAdded = { [weak self] in
            self?.fetchEvents()
        }
        
        present(wishEventCreationVC, animated: true)
    }
    
    @objc
    private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
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
        
        cell.deleteCell = { [weak self, weak collectionView] in
            guard let index = collectionView?.indexPath(for: cell) else { return }
            self?.deleteEvent(at: index)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - Constants.collectionCellOffset
        return CGSize(width: width, height: Constants.collectionCellHeight)
    }
    
}
