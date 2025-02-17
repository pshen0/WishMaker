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
        static let backButtonTop: CGFloat = 20
        static let backButtonLeft: CGFloat = 20
        
        static let titleText: String = "New event"
        static let titleSize: CGFloat = 32
        static let creationTitleTop: CGFloat = 60
        
        static let fieldRadius: CGFloat = 5
        static let fieldsStackSpacing: CGFloat = 30
        static let fieldsPadding: CGFloat = 10
        static let fieldsLabels = ["Event", "Discription", "Start of the event", "End of event"]
        static let fieldHeight: CGFloat = 40
        static let fieldsStackTop: CGFloat = 40
        static let fieldWidth: CGFloat = 350
        static let fieldsAttribute: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .font: UIFont.systemFont(ofSize: 14)
        ]
        
        static let addEventButtonTop: CGFloat = 15
        static let addEventButtonBottom: CGFloat = 8
        static let addEventButtonWidth: CGFloat = 100
        static let addEventButtonHeight: CGFloat = 30
        static let addEventButtonTitle: String = "Add event"
        static let addEventButtonRadius: CGFloat = 10
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        
        static let creationRuleText: String = """
        All fields must be filled in and the end date must be
        no earlier than the start date.
        """
        static let creationRuleFont: UIFont = .systemFont(ofSize: 13)
        static let creationRuleTop: CGFloat = 15
        
        static let dateFormat: String = "dd.MM.yyyy"
        static let emptyString: String = ""
    }
    
    
    private let backButton: UIButton = UIButton()
    private let creationTitle: UILabel = UILabel()
    private let titleTextField = UITextField()
    private let noteTextField = UITextField()
    private let dateStartTextField = UITextField()
    private let dateEndTextField = UITextField()
    private let dateStartPicker = UIDatePicker()
    private let dateEndPicker = UIDatePicker()
    private let addEventButton = UIButton()
    private let creationRule = UILabel()
    
    // MARK: - Variables
    var fieldsStack: UIStackView = UIStackView()
    var presenter: WishEventCreationPresenter?
    var onEventAdded: (() -> Void)?
    
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
        configureAddEventButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
    
    private func configureBackButton() {
        backButton.setImage(Constants.backImage, for: .normal)
        backButton.tintColor = Constants.darkBlue
        
        view.addSubview(backButton)
        
        backButton.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.backButtonTop)
        backButton.pinLeft(to: view.leadingAnchor, Constants.backButtonLeft)
        
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
        fieldsStack.spacing = Constants.fieldsStackSpacing
        
        view.addSubview(fieldsStack)
        
        var i = 0
        for field in [titleTextField, noteTextField, dateStartTextField, dateEndTextField] {
            field.backgroundColor = .white
            field.textColor = Constants.darkBlue
            field.layer.cornerRadius = Constants.fieldRadius
            field.setLeftPaddingPoints(Constants.fieldsPadding)
            field.attributedPlaceholder = NSAttributedString(string: Constants.fieldsLabels[i], attributes: Constants.fieldsAttribute)
            
            fieldsStack.addArrangedSubview(field)
            
            field.setHeight(Constants.fieldHeight)
            field.setWidth(Constants.fieldWidth)
            
            i += 1
        }
        
        fieldsStack.pinCenterX(to: view)
        fieldsStack.pinTop(to: creationTitle.bottomAnchor, Constants.fieldsStackTop)
        
    }
    
    private func configureAddEventButton() {
        addEventButton.setTitle(Constants.addEventButtonTitle, for: .normal)
        addEventButton.backgroundColor = Constants.darkBlue
        addEventButton.setTitleColor(.white, for: .normal)
        addEventButton.titleLabel?.font = Constants.buttonFont
        addEventButton.layer.cornerRadius = Constants.addEventButtonRadius
        creationRule.text = Constants.creationRuleText
        creationRule.numberOfLines = 0
        creationRule.lineBreakMode = .byWordWrapping
        creationRule.textColor = Constants.darkBlue
        creationRule.font = Constants.creationRuleFont
        creationRule.textAlignment = .center
        creationRule.isHidden = true
        
        view.addSubview(addEventButton)
        view.addSubview(creationRule)
        
        creationRule.pinCenterX(to: view)
        creationRule.pinTop(to: fieldsStack.bottomAnchor, Constants.creationRuleTop)
        addEventButton.setWidth(Constants.addEventButtonWidth)
        addEventButton.setHeight(Constants.addEventButtonHeight)
        addEventButton.pinTop(to: creationRule.bottomAnchor, Constants.addEventButtonTop)
        addEventButton.pinCenterX(to: view)
        
        addEventButton.addTarget(self, action: #selector(addEventTapped), for: .touchUpInside)
    }
    
    private func checkDates(start: String, end: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.dateFormat
        if let firstDate = dateFormatter.date(from: start), let secondDate = dateFormatter.date(from: end) {
            return firstDate <= secondDate
        } else {
            return false
        }
    }
    
    @objc
    private func backButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func dateStartChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        dateStartTextField.text = formatter.string(from: sender.date)
    }
    
    @objc private func dateEndChanged(_ sender: UIDatePicker) {
        let formatter = DateFormatter()
        formatter.dateFormat = Constants.dateFormat
        dateEndTextField.text = formatter.string(from: sender.date)
    }
    
    @objc private func dismissKeyboard() {
        for field in [titleTextField, noteTextField, dateStartTextField, dateEndTextField] {
            field.resignFirstResponder()
        }
    }
    
    @objc private func addEventTapped() {
        guard let title = titleTextField.text, !title.isEmpty,
              let note = noteTextField.text, !note.isEmpty,
              let startText = dateStartTextField.text, let endText = dateEndTextField.text,
              checkDates(start: startText, end: endText)
        else {
            creationRule.isHidden = false
            return
        }
        
        dismissKeyboard()
        creationRule.isHidden = true
        
        let isCreated = presenter?.createEvent(title: title, note: note, startDate: dateStartPicker.date, endDate: dateEndPicker.date) ?? false
        
        if isCreated {
            for field in [titleTextField, noteTextField, dateStartTextField, dateEndTextField] {
                field.text = Constants.emptyString
            }
            onEventAdded?()
        }
    }
}

extension UITextField {
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }
}


