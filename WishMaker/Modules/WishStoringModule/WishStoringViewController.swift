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
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 10
        static let numberOfSections: Int = 2
        static let noSections: Int = 0
        static let oneSection: Int = 1
        
        static let wishesKey = "wishesKey"
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        
        static let backImage: UIImage? = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
        static let backButtonTop: CGFloat = 20
        static let backButtonLeft: CGFloat = 20
    }
    
    // MARK: - Variables
    private let backButton: UIButton = UIButton()
    private let defaults = UserDefaults.standard
    var wishes: [WishEntity] = []
    var table: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = Constants.lightBlue
        loadWishes()
        configureTable()
        configureBackButton()
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureTable() {
        view.addSubview(table)
        table.backgroundColor = Constants.lightBlue
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        table.isUserInteractionEnabled = true
        table.contentInset = .zero
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
    }
    
    private func loadWishes() {
        wishes = CoreDataWishStack.shared.fetchWishes()
        table.reloadData()
    }

    private func saveWishes(_ wishText: String) {
        CoreDataWishStack.shared.addWish(wishText)
        loadWishes()
    }
    
    private func deleteWish(at indexPath: IndexPath) {
        let wishToDelete = wishes[indexPath.row]
        CoreDataWishStack.shared.deleteWish(wishToDelete)
        loadWishes()
    }
    
    // MARK: - Actions
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
            return Constants.numberOfSections
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == Constants.noSections ? Constants.oneSection : wishes.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] newWish in
                self?.saveWishes(newWish)
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: wishes[indexPath.row].text ?? "")

            cell.deleteAction = { [weak self] in
                self?.deleteWish(at: indexPath)
            }
            
            return cell
        }
    }
}

