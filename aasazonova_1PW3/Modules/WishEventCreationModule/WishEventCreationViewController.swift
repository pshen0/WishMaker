//
//  WishEventCreationViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit

// MARK: - WishEventCreationView Protocol
protocol WishEventCreationViewProtocol: AnyObject {

}

final class WishEventCreationViewController: UIViewController, WishEventCreationViewProtocol {
    
    // MARK: - Constants
    enum Constants {
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let backImage: UIImage? = UIImage(
            systemName: "chevron.backward",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .bold)
        )
    }
    
    
    private let backButton: UIButton = UIButton()
    
    // MARK: - Variables
    var presenter: WishEventCreationPresenter?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = Constants.lightBlue
        configureBackButton()
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        backButton.pinLeft(to: view.leadingAnchor, 20)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
}
