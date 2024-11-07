//
//  ViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

// MARK: - ColorView Protocol
protocol ColorView: AnyObject {
    func updateBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class WishMakerViewController: UIViewController, ColorView {
    
    // MARK: - Constants
    enum Constants {
        static let titleText: String = "WishMaker"
        static let titleSize: CGFloat = 32
        static let titleTop: CGFloat = 30
        
        static let discriptionText: String = """
        This app will bring you joy and will fulfill three of your wishes!
            • The first wish is to change the background color.
        """
        static let discriptionSize: CGFloat = 16
        static let discriptionLeading: CGFloat = 15
        static let discriptionTop: CGFloat = 52
        
        static let stackRadius: CGFloat = 20
        static let stackLeading: CGFloat = 20
        static let stackBottom: CGFloat = 90
        
        static let buttonHeight: CGFloat = 50
        static let buttonBottom: CGFloat = 40
        static let buttonSide: CGFloat = 20
        static let buttonText: String = "My wishes"
        static let buttonRadius: CGFloat = 20
        
        static let red: String = "Red"
        static let green: String = "Green"
        static let blue: String = "Blue"
        static let colorIntensity: CGFloat = 0.0
        static let colorSaturation: CGFloat = 1.0
        
        static let sliderMin: Double = 0
        static let sliderMax: Double = 1
        
        static let numberLines: Int = 0
    }
    
    // MARK: - Variables
    private var titleView = UILabel()
    private var discriptionView = UILabel()
    private var sliderRed = CustomSlider()
    private var sliderBlue = CustomSlider()
    private var sliderGreen = CustomSlider()
    private let addWishButton: UIButton = UIButton(type: .system)
    private var redLevel = Constants.colorIntensity
    private var blueLevel = Constants.colorIntensity
    private var greenLevel = Constants.colorIntensity
    var presenter: ColorPresenter!
    
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
        configureAddWishButton()
        configureSliders()
    }
    
    private func configureTitle() {
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.text = Constants.titleText
        discriptionView.numberOfLines = Constants.numberLines
        discriptionView.lineBreakMode = .byWordWrapping
        titleView.textColor = .white
        titleView.font = UIFont.boldSystemFont(ofSize: Constants.titleSize)
        view.addSubview(titleView)
        NSLayoutConstraint.activate([
            titleView.pinCenterX(to: view),
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: Constants.titleTop)
        ])
    }
    
    private func configureDiscription() {
        discriptionView.translatesAutoresizingMaskIntoConstraints = false
        discriptionView.text = Constants.discriptionText
        discriptionView.numberOfLines = Constants.numberLines
        discriptionView.lineBreakMode = .byWordWrapping
        discriptionView.textColor = .white
        discriptionView.font = UIFont.systemFont(ofSize: Constants.discriptionSize)
        view.addSubview(discriptionView)
        NSLayoutConstraint.activate([
            discriptionView.pinCenterX(to: view),
            discriptionView.pinLeft(to: view, Constants.discriptionLeading),
            discriptionView.pinTop(to: titleView, Constants.discriptionTop),
        ])
    }
    
    private func configureSliders() {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        view.addSubview(stack)
        stack.layer.cornerRadius = Constants.stackRadius
        stack.clipsToBounds = true
        
        sliderRed = CustomSlider(title: Constants.red, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderBlue = CustomSlider(title: Constants.blue, min: Constants.sliderMin, max: Constants.sliderMax)
        sliderGreen = CustomSlider(title: Constants.green, min: Constants.sliderMin, max: Constants.sliderMax)
        
        for slider in [sliderRed, sliderBlue, sliderGreen] {
            stack.addArrangedSubview(slider)
        }

        NSLayoutConstraint.activate([
            stack.pinCenterX(to: view),
            stack.pinLeft(to: view, Constants.stackLeading),
            stack.pinBottom(to: addWishButton, Constants.stackBottom),
        ])
        
        sliderRed.valueChanged = { [weak self] value in
            self!.redLevel = Double(value)
            self?.presenter.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
        
        sliderGreen.valueChanged = { [weak self] value in
            self!.greenLevel = Double(value)
            self?.presenter.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
        
        sliderBlue.valueChanged = { [weak self] value in
            self!.blueLevel = Double(value)
            self?.presenter.slidersValueDidChange(red: self?.redLevel ?? 0, green: self?.greenLevel ?? 0, blue: self?.blueLevel ?? 0)
        }
    }
    
    private func configureAddWishButton() {
        view.addSubview(addWishButton)
        addWishButton.setHeight(Constants.buttonHeight)
        addWishButton.pinBottom(to: view, Constants.buttonBottom)
        addWishButton.pinHorizontal(to: view, Constants.buttonSide)
        
        addWishButton.backgroundColor = .white
        addWishButton.setTitleColor(.black, for: .normal)
        addWishButton.setTitle(Constants.buttonText, for: .normal)
        
        addWishButton.layer.cornerRadius = Constants.buttonRadius
        addWishButton.addTarget(self, action: #selector(addWishButtonPressed), for: .touchUpInside)
    }
    
    // MARK: - Func
    func updateBackgroundColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: Constants.colorSaturation)
    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        present(WishStoringViewController(), animated: true)
    }
}

