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
        
        static let titleText: String = "New event"
        static let titleSize: CGFloat = 32
        static let creationTitleTop: CGFloat = 60
        
        static let fieldRadius: CGFloat = 5
        static let stackSpacing: CGFloat = 20
        
    }
    
    
    private let backButton: UIButton = UIButton()
    private let creationTitle: UILabel = UILabel()
    private let titleTextField = UITextField()
    private let noteTextField = UITextField()
    private let dateStartTextField = UITextField()
    private let dateEndTextField = UITextField()
    private let dateStartPicker = UIDatePicker()
    private let dateEndPicker = UIDatePicker()
    
    // MARK: - Variables
    var fieldsStack: UIStackView = UIStackView()
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
        configureViewTitle()
        configuredateStartField()
        configuredateEndField()
        configureStack()
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, 20)
        backButton.pinLeft(to: view.leadingAnchor, 20)
        
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    private func configureViewTitle() {
        creationTitle.text = Constants.titleText
        creationTitle.font = UIFont.boldSystemFont(ofSize: Constants.titleSize)
        creationTitle.textColor = Constants.darkBlue
        
        view.addSubview(creationTitle)
        
        creationTitle.pinCenterX(to: view)
        creationTitle.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.creationTitleTop)
    }
    
    private func configuredateStartField() {
        dateStartPicker.datePickerMode = .date
        dateStartPicker.preferredDatePickerStyle = .wheels
        dateStartTextField.inputView = dateStartPicker
        dateStartPicker.addTarget(self, action: #selector(dateStartChanged(_:)), for: .valueChanged)
    }
    
    private func configuredateEndField() {
        dateEndPicker.datePickerMode = .date
        dateEndPicker.preferredDatePickerStyle = .wheels
        dateEndTextField.inputView = dateEndPicker
        dateEndPicker.addTarget(self, action: #selector(dateEndChanged(_:)), for: .valueChanged)
    }
    
    private func configureStack() {
        fieldsStack.translatesAutoresizingMaskIntoConstraints = false
        fieldsStack.axis = .vertical
        fieldsStack.clipsToBounds = true
        fieldsStack.spacing = Constants.stackSpacing
        
        view.addSubview(fieldsStack)
        
        for field in [titleTextField, noteTextField, dateStartTextField, dateEndTextField] {
            field.backgroundColor = .white
            field.textColor = Constants.darkBlue
            field.layer.cornerRadius = Constants.fieldRadius

            fieldsStack.addArrangedSubview(field)
            
            field.setHeight(40)
            field.setWidth(350)
        }
        
        fieldsStack.pinCenterX(to: view)
        fieldsStack.pinTop(to: creationTitle.bottomAnchor, 40)

    }
    
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }

    @objc private func dateStartChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateStartTextField.text = formatter.string(from: sender.date)
    }
    
    @objc private func dateEndChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        dateEndTextField.text = formatter.string(from: sender.date)
    }
}
