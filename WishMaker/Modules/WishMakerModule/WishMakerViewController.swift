//
//  ViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

// MARK: - WishMakerView Protocol
protocol WishMakerViewProtocol: AnyObject {
    func updateBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class WishMakerViewController: UIViewController, WishMakerViewProtocol {
    
    // MARK: - Constants
    enum Constants {
        // Common
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let colorIntensity: CGFloat = 0.0
        static let colorSaturation: CGFloat = 1.0
        static let numberLines: Int = 0
        static let brightnessLevel: Double = 1.5
        
        static let titleText: String = "WishMaker"
        static let titleSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        static let discriptionText: String = """
        This app will bring you joy and will fulfill three of your wishes!
          • The first wish is to change the background
            color.
          • The second is to write all your wishes.
          • The third and the last is to schedule wishes
          grantins.
        """
        static let discriptionSize: CGFloat = 16
        static let discriptionLeading: CGFloat = 30
        static let discriptionTop: CGFloat = 52
        
        static let colorStackRadius: CGFloat = 20
        static let colorStackWidth: CGFloat = 350
        static let colorStackTop: CGFloat = 105
        
        static let addWishButtonText: String = "Add wishes"
        static let scheduleWishButtonText: String = "Schedule wishes granting"
        
        static let buttonHeight: CGFloat = 50
        static let buttonWidth: CGFloat = 350
        static let buttonRadius: CGFloat = 20
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let actionStackSpacing: CGFloat = 10
        static let actionStackTop: CGFloat = 105
    }
    
    // MARK: - Variables
    private let titleView = UILabel()
    private let discriptionView = UILabel()
    private let sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishButton: UIButton = UIButton(type: .system)
    private let sliderStack = UIStackView()
    private let actionStack = UIStackView()
    private let calendarViewController = WishCalendarModuleBuilder.build()
    
    private var redLevel = Constants.colorIntensity
    private var blueLevel = Constants.colorIntensity
    private var greenLevel = Constants.colorIntensity
    
    
    var presenter: WishMakerPresenterProtocol?
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        view.backgroundColor = .black

        configureTitle()
        configureDiscription()
        configureSlidersStack()
        configureActionStack()
    }
    
    private func configureTitle() {
        titleView.text = Constants.titleText
        discriptionView.numberOfLines = Constants.numberLines
        discriptionView.lineBreakMode = .byWordWrapping
        titleView.textColor = .white
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleSize)
        
        view.addSubview(titleView)
        
        titleView.pinCenterX(to: view)
        titleView.pinTop(to: view.safeAreaLayoutGuide.topAnchor, Constants.titleTop)
    }
    
    private func configureDiscription() {
        discriptionView.text = Constants.discriptionText
        discriptionView.numberOfLines = Constants.numberLines
        discriptionView.lineBreakMode = .byWordWrapping
        discriptionView.textColor = .white
        discriptionView.font = UIFont.systemFont(ofSize: Constants.discriptionSize)
        
        view.addSubview(discriptionView)
        
        discriptionView.pinCenterX(to: view)
        discriptionView.pinLeft(to: view, Constants.discriptionLeading)
        discriptionView.pinTop(to: titleView, Constants.discriptionTop)
    }
    
    private func configureSlidersStack() {
        sliderStack.axis = .vertical
        sliderStack.layer.cornerRadius = Constants.colorStackRadius
        sliderStack.clipsToBounds = true
        
        view.addSubview(sliderStack)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            sliderStack.addArrangedSubview(slider)
        }

        sliderStack.pinCenterX(to: view)
        sliderStack.setWidth(Constants.colorStackWidth)
        sliderStack.pinTop(to: discriptionView.bottomAnchor, Constants.colorStackTop)
        
        sliderRed.valueChanged = { [weak self] value in
            self!.redLevel = Double(value)
            self?.presenter?.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self!.greenLevel = Double(value)
            self?.presenter?.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self!.blueLevel = Double(value)
            self?.presenter?.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
    }
    
    private func configureActionStack() {
        actionStack.axis = .vertical
        actionStack.spacing = Constants.actionStackSpacing
        
        view.addSubview(actionStack)
        
        for button in [addWishButton, scheduleWishButton] {
            actionStack.addArrangedSubview(button)
            button.setHeight(Constants.buttonHeight)
            button.setWidth(Constants.buttonWidth)
            button.backgroundColor = .white
            button.setTitleColor(.black, for: .normal)
            button.layer.cornerRadius = Constants.buttonRadius
        }
        
        configureAddWishButton()
        configureScheduleWishButton()

        actionStack.pinTop(to: sliderStack.bottomAnchor, Constants.actionStackTop)
        actionStack.pinCenterX(to: view)
    }
    
    private func configureAddWishButton(){
        addWishButton.setTitle(Constants.addWishButtonText, for: .normal)
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)

    }
    
    private func configureScheduleWishButton() {
        scheduleWishButton.setTitle(Constants.scheduleWishButtonText, for: .normal)
        scheduleWishButton.addTarget(self, action: #selector(scheduleWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Func
    func updateBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.colorSaturation)
        print(Double(red + green + blue))
        if Double(red + green + blue) > Constants.brightnessLevel {
            titleView.textColor = .black
            discriptionView.textColor = .black
        } else {
            titleView.textColor = .white
            discriptionView.textColor = .white
        }
    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
    
    @objc
    private func scheduleWishButtonPressed() {
        navigationController?.pushViewController(calendarViewController, animated: true)
    }
    
}

