//
//  WishStoringViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 06.11.2024.
//

import UIKit

// MARK: - UITableViewDataSource
extension WishStoringViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return Constants.numberOfSections
    }


    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        /**if let appDelegate = UIApplication.shared.delegate as? SceneDelegate {
            return section == Constants.noSections ? Constants.oneSection : appDelegate.Array.count
        }
        fatalError("Ошибка исполнения")**/
        return section == Constants.noSections ? Constants.oneSection : Array.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*if let appDelegate = UIApplication.shared.delegate as? SceneDelegate {
            if indexPath.section == 0 {
                let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
                cell.addWish = { [weak self] newWish in
                    appDelegate.Array.append(newWish)
                    self?.saveWishes()
                    appDelegate.table.reloadData()
                }
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
                cell.configure(with: appDelegate.Array[indexPath.row])
                return cell
            }
        }
        fatalError("Ошибка исполнения")*/
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: AddWishCell.reuseId, for: indexPath) as! AddWishCell
            cell.addWish = { [weak self] newWish in
                self?.Array.append(newWish)
                self?.saveWishes()
                self?.table.reloadData()
            }
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: WrittenWishCell.reuseId, for: indexPath) as! WrittenWishCell
            cell.configure(with: Array[indexPath.row])
            return cell
        }
    }
}


final class WishStoringViewController: UIViewController {
    
    // MARK: - Constants
    enum Constants {
        static let buttonHeight: CGFloat = 30
        static let buttonTop: CGFloat = 10
        static let buttonWidth: CGFloat = 100
        static let buttonText: String = "go back"
        static let buttonRadius: CGFloat = 10
        
        static let tableCornerRadius: CGFloat = 10
        static let tableOffset: CGFloat = 10
        static let numberOfSections: Int = 2
        static let noSections: Int = 0
        static let oneSection: Int = 1
        
        static let wishesKey = "wishesKey"
    }
    
    // MARK: - Variables
    private let backButton: UIButton = UIButton(type: .system)
    private let defaults = UserDefaults.standard
    var Array: [String] = []
    var table: UITableView = UITableView(frame: .zero)
    
    override func viewDidLoad() {
        configureUI()
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = .black
        loadWishes()
        configureTable()
        configureBackButton()
    }
    
    private func configureBackButton() {
        view.addSubview(backButton)
        backButton.setHeight(Constants.buttonHeight)
        backButton.pinTop(to: view, Constants.buttonTop)
        backButton.pinCenterX(to: view)
        backButton.setWidth(Constants.buttonWidth)
        
        backButton.backgroundColor = .white
        backButton.setTitleColor(.black, for: .normal)
        backButton.setTitle(Constants.buttonText, for: .normal)
        
        backButton.layer.cornerRadius = Constants.buttonRadius
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
    }
    
    private func configureTable() {
        /*if let appDelegate = UIApplication.shared.delegate as? SceneDelegate {
            view.addSubview(appDelegate.table)
            appDelegate.table.backgroundColor = .black
            appDelegate.table.dataSource = self
            appDelegate.table.separatorStyle = .none
            appDelegate.table.layer.cornerRadius = Constants.tableCornerRadius
            
            appDelegate.table.pin(to: view, Constants.tableOffset)
            
            appDelegate.table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
            appDelegate.table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        }*/
        view.addSubview(table)
        table.backgroundColor = .black
        table.dataSource = self
        table.separatorStyle = .none
        table.layer.cornerRadius = Constants.tableCornerRadius
        
        table.pin(to: view, Constants.tableOffset)
        
        table.register(WrittenWishCell.self, forCellReuseIdentifier: WrittenWishCell.reuseId)
        table.register(AddWishCell.self, forCellReuseIdentifier: AddWishCell.reuseId)
        

    }
    
    private func loadWishes() {
        if let savedWishes = defaults.array(forKey: Constants.wishesKey) as? [String] {
            /*if let appDelegate = UIApplication.shared.delegate as? SceneDelegate {
                appDelegate.Array = savedWishes
            }*/
            Array = savedWishes
        }
    }

    private func saveWishes() {
        /*if let appDelegate = UIApplication.shared.delegate as? SceneDelegate {
            defaults.set(appDelegate.Array, forKey: Constants.wishesKey)
        }*/
        defaults.set(Array, forKey: Constants.wishesKey)
    }
    
    // MARK: - Actions
    @objc
    private func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
}
