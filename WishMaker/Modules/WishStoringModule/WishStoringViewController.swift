//
//  WishStoringViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 06.11.2024.
//

import UIKit

final class WishStoringViewController: UIViewController {
    
    enum Constants {
        // Common
        static let wishesKey = "wishesKey"
        static let emptyString: String = ""
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        
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
    
    private let interactor: WishStoringBusinessLogic
    private let backButton: UIButton = UIButton()
    private let defaults = UserDefaults.standard
    
    var wishes: [WishEntity] = []
    var table: UITableView = UITableView(frame: .zero)
    
    init(interactor: WishStoringBusinessLogic) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        interactor.loadWishes(WishStoringModel.Fetch.Request())
    }
    
    private func configureUI() {
        view.backgroundColor = Constants.lightBlue
        configureTable()
        configureBackButton()
    }
    
    private func configureTable() {
        table.backgroundColor = Constants.lightBlue
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.isUserInteractionEnabled = true
        table.contentInset = .zero
        table.layer.borderColor = UIColor.black.cgColor
        table.layer.borderWidth = 1.0
        table.separatorColor = UIColor.black 
        view.addSubview(table)
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    func displayLoading() {
        table.reloadData()
    }
    
    func displayAdding() {
        table.reloadData()
        print(wishes.count)
        let num = table.numberOfRows(inSection: 0)
        print(num)
    }
    
    func displayDeleting(viewModel: WishStoringModel.Delete.ViewModel) {
        table.deselectRow(at: viewModel.indexPath, animated: true)
        table.reloadData()
        print(wishes.count)
        let num = table.numberOfRows(inSection: 0)
        print(num)
    }
}

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
