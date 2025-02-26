//
//  WishStoringViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 06.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    // MARK: - Constants
    enum Constants {
        // Common
        static let wishesKey = "wishesKey"
        static let emptyString: String = ""
        static let initError: String = "init(coder:) has not been implemented"
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 10
        static let tableSections: Int = 2
        static let tableNoSections: Int = 0
        static let tableOneSection: Int = 1
        
        static let backButtonTop: CGFloat = 20
        static let backButtonLeft: CGFloat = 20
        
        static let backImage: UIImage? = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
    }
    
    // MARK: - Fields
    private let interactor: WishStoringBusinessLogic
    private let backButton: UIButton = UIButton()
    private let defaults = UserDefaults.standard
    
    var wishes: [WishEntity] = []
    var table: UITableView = UITableView(frame: .zero)
    
    // MARK: - Lifecycle
    init(interactor: WishStoringBusinessLogic) {
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
        interactor.loadWishes(WishStoringModel.Fetch.Request())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.loadController(WishStoringModel.Load.Request())
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = Constants.black
        configureTable()
        configureBackButton()
    }
    
    private func configureTable() {
        table.backgroundColor = Constants.black
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.isUserInteractionEnabled = true
        table.contentInset = .zero
        view.addSubview(table)
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func updateColors(_ viewModel: WishStoringModel.Load.ViewModel) {
        view.backgroundColor = viewModel.mainColor
        table.backgroundColor = viewModel.mainColor
        backButton.tintColor = viewModel.additionalColor
    }
    
    func displayLoading(_ viewModel: WishStoringModel.Fetch.ViewModel) {
        table.reloadData()
    }
    
    func displayAdding(_ viewModel: WishStoringModel.Add.ViewModel) {
        table.reloadData()
    }
    
    func displayDeleting(_ viewModel: WishStoringModel.Delete.ViewModel) {
        table.deselectRow(at: viewModel.indexPath, animated: true)
        table.reloadData()
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        interactor.backButtonTapped(WishStoringModel.RouteBack.Request())
    }
}

// MARK: - Extensions
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return Constants.tableSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.tableNoSections ? Constants.tableOneSection : wishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] newWish in
                self?.interactor.addWish(WishStoringModel.Add.Request(text: newWish))
                self?.interactor.loadWishes(WishStoringModel.Fetch.Request())
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishes[indexPath.row].text ?? Constants.emptyString)

            cell.deleteWish = { [weak self] in
                self?.interactor.deleteWish(WishStoringModel.Delete.Request(indexPath: indexPath))
                self?.interactor.loadWishes(WishStoringModel.Fetch.Request())
            }
            return cell
        }
    }
}
