//
//  ViewController.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit



final class WishMakerViewController: UIViewController {
    // MARK: - Constants
    enum Constants {
        // Common
        static let initError: String = "init(coder:) has not been implemented"
        static let redText: String = "Red"
        static let greenText: String = "Green"
        static let blueText: String = "Blue"
        static let colorIntensity: CGFloat = 0.0
        static let colorSaturation: CGFloat = 1.0
        static let numberLines: Int = 0
        static let brightnessLevel: Double = 1.8
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let red: UIColor = UIColor.red
        static let green: UIColor = UIColor.green
        static let blue: UIColor = UIColor.blue
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        
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
        static let actionStackBottom: CGFloat = 25
    }
    
    // MARK: - Fields
    private let interactor: WishMakerBusinessLogic
    private let titleView = UILabel()
    private let discriptionView = UILabel()
    private let sliderRed = CustomSlider(title: Constants.redText, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderBlue = CustomSlider(title: Constants.blueText, min: Constants.sliderMin, max: Constants.sliderMax)
    private let sliderGreen = CustomSlider(title: Constants.greenText, min: Constants.sliderMin, max: Constants.sliderMax)
    private let addWishButton: UIButton = UIButton(type: .system)
    private let scheduleWishButton: UIButton = UIButton(type: .system)
    private let sliderStack = UIStackView()
    private let actionStack = UIStackView()
    private let calendarViewController = WishCalendarBuilder.build()
    
    private var redLevel = Constants.colorIntensity
    private var blueLevel = Constants.colorIntensity
    private var greenLevel = Constants.colorIntensity
    
    // MARK: - Lifecycle
    init(interactor: WishMakerBusinessLogic) {
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
    }
    
    override func viewWillAppear(_ animated: Bool) {
        interactor.loadController(WishMakerModel.Load.Request())
    }
    
    // MARK: - Private funcs
    private func configureUI() {
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
        
        for (slider, color) in zip([sliderRed, sliderBlue, sliderGreen], [Constants.red, Constants.blue, Constants.green]) {
            sliderStack.addArrangedSubview(slider)
            slider.slider.minimumTrackTintColor = color
        }

        sliderStack.pinCenterX(to: view)
        sliderStack.setWidth(Constants.colorStackWidth)
        sliderStack.pinTop(to: discriptionView.bottomAnchor, Constants.colorStackTop)
        
        sliderRed.valueChanged = { [weak self] value in self?.sliderChanged() }
        sliderGreen.valueChanged = { [weak self] value in self?.sliderChanged() }
        sliderBlue.valueChanged = { [weak self] value in self?.sliderChanged() }
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

        actionStack.pinBottom(to: view.safeAreaLayoutGuide.bottomAnchor, Constants.actionStackBottom)
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
    
    private func sliderChanged() {
        let request = WishMakerModel.ColorChange.Request(
            red: sliderRed.value,
            green: sliderGreen.value,
            blue: sliderBlue.value
        )
        interactor.changedSliderPosition(request)
    }
    
    // MARK: - Funcs
    func updateColors(_ viewModel: WishMakerModel.ColorChange.ViewModel) {
        view.backgroundColor = viewModel.mainColor
        addWishButton.setTitleColor(viewModel.mainColor, for: .normal)
        scheduleWishButton.setTitleColor(viewModel.mainColor, for: .normal)
        sliderRed.titleView.textColor = viewModel.mainColor
        sliderGreen.titleView.textColor = viewModel.mainColor
        sliderBlue.titleView.textColor = viewModel.mainColor
        
        titleView.textColor = viewModel.additionalColor
        discriptionView.textColor = viewModel.additionalColor
        addWishButton.backgroundColor = viewModel.additionalColor
        scheduleWishButton.backgroundColor = viewModel.additionalColor
        sliderRed.backgroundColor = viewModel.additionalColor
        sliderBlue.backgroundColor = viewModel.additionalColor
        sliderGreen.backgroundColor = viewModel.additionalColor
    }
    
    // MARK: - Actions
    @objc
    private func addWishButtonPressed() {
        interactor.addWishButtonPressed(WishMakerModel.RouteToWishStoring.Request())
    }
    
    @objc
    private func scheduleWishButtonPressed() {
        interactor.scheduleWishButtonPressed(WishMakerModel.RouteToWishCalendar.Request())
    }
}

// MARK: - Extensions
extension UserDefaults {
    func setColor(_ color: UIColor?, forKey key: String) {
        guard let color = color else { return }
        let data = try? NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false)
        set(data, forKey: key)
    }
    
    func color(forKey key: String) -> UIColor? {
        guard let data = data(forKey: key) else { return nil }
        do {
            return try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
        } catch {
            return nil
        }
    }
}
