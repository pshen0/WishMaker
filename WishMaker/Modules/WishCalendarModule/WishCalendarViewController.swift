//
//  WishCalendarViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit

final class WishCalendarViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        // Common
        static let initError: String = "init(coder:) has not been implemented"
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        
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
    
    // MARK: - Fields
    private let interactor: WishCalendarBusinessLogic
    private let addEventButton: UIButton = UIButton()
    private let backButton: UIButton = UIButton()
    private let collectionView: UICollectionView = UICollectionView(
        frame: .zero,
        collectionViewLayout: UICollectionViewFlowLayout()
    )
    
    var events: [EventEntity] = []
    
    // MARK: - Lifecycle
    init(interactor: WishCalendarBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadEvents(WishCalendarModel.Fetch.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
        interactor.loadController(WishCalendarModel.Load.Request())
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        configureCells()
        configureBackButton()
        configureCollection()
        configureAddWishButton()
    }
    
    private func configureCells() {
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.minimumInteritemSpacing = Constants.collectionSpacing
            layout.minimumLineSpacing = Constants.collectionSpacing
            layout.invalidateLayout()
        }
    }
    
    private func configureCollection() {
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
        
        view.addSubview(addEventButton)
        
        addEventButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.addButtonTop)
        addEventButton.pinRight(to: view.trailingAnchor, Constants.addButtonRight)
        
        addEventButton.addTarget(self, action: #selector(addEventButtonTapped), for: .touchUpInside)
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func updateColors(_ viewModel: WishCalendarModel.Load.ViewModel) {
        view.backgroundColor = viewModel.mainColor
        collectionView.backgroundColor = viewModel.mainColor
        
        addEventButton.tintColor = viewModel.additionalColor
        backButton.tintColor = viewModel.additionalColor
    }
    
    func displayDeleting(_ viewModel: WishCalendarModel.Delete.ViewModel) {
        collectionView.performBatchUpdates({collectionView.deleteItems(at: [viewModel.indexPath])}, completion: nil)
    }
    
    func displayEvents(_ viewModel: WishCalendarModel.Fetch.ViewModel) {
        collectionView.reloadData()
    }
    
    // MARK: - Actions
    @objc
    private func addEventButtonTapped() {
        interactor.addEventButtonTapped(WishCalendarModel.RouteToWishEventCreator.Request())
    }
    
    @objc
    private func backButtonTapped() {
        interactor.backButtonTapped(WishCalendarModel.RouteBack.Request())
    }
}

// MARK: - Extensions
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
            self?.interactor.deleteEvent(WishCalendarModel.Delete.Request(indexPath: index))
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.frame.width - Constants.collectionCellOffset
        return CGSize(width: width, height: Constants.collectionCellHeight)
    }
}
