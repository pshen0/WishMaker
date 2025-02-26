//
//  WishEventCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit

final class WishEventCell: UICollectionViewCell {
    // MARK: - Constants
    enum Constants {
        // Common
        static let initError: String = "init(coder:) has not been implemented"
        static let formatterString: String = "dd.MM.yyyy"
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let smallBoldFont: UIFont = .boldSystemFont(ofSize: 12)
        static let smallFont: UIFont = .systemFont(ofSize: 14)
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        static let colorShift: CGFloat = 0.35

        static let wrapCornerRadius: CGFloat = 10
        static let wrapVetical: CGFloat = 3
        static let wrapHorizontal: CGFloat = 10
        static let titleBackHeight: CGFloat = 23
        static let titleBackTop: CGFloat = 10
        static let titleBackOffset: CGFloat = 10
        static let titleBackRadius: CGFloat = 5
        
        static let titleTop: CGFloat = 10
        static let titleFont: UIFont = .boldSystemFont(ofSize: 15)
        static let titleLeading: CGFloat = 10
        
        static let datesStackSpacing: CGFloat = 10
        static let datesStackLeft: CGFloat = 10
        static let calendarTop: CGFloat = 15
        static let calendarLeft: CGFloat = 15
        
        static let discriptionLines: Int = 0
        static let noteLeft: CGFloat = 20
        static let noteWidth: CGFloat = 150
        static let discriptinLeft: CGFloat = 10
        
        static let deleteButtonRight: CGFloat = 10
        
        static let calendarImage: UIImage? = UIImage(
            systemName: "calendar.badge.clock",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
        static let noteImage: UIImage? = UIImage(
            systemName: "pencil.and.list.clipboard",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 25, weight: .medium)
        )
        static let trashImage: UIImage? = UIImage(
            systemName: "trash",
            withConfiguration: UIImage.SymbolConfiguration(pointSize: 20, weight: .light)
        )
    }
    
    // MARK: - Fields
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleBack: UIView = UIView()
    private let calendarView: UIImageView = UIImageView(image: Constants.calendarImage)
    private let noteView: UIImageView = UIImageView(image: Constants.noteImage)
    private let datesStack: UIStackView = UIStackView()
    private let deleteButton: UIButton = UIButton()
    private let titleLabel: UILabel = UILabel()
    private let discriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    
    var deleteCell: (() -> Void)?
    private var datesArray: Array<UILabel> = []
    private var mainColor = Constants.black
    private var additionalColor = Constants.white
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        mainColor = UserDefaults.standard.color(forKey: Constants.mainColorID) ?? Constants.black
        additionalColor = UserDefaults.standard.color(forKey: Constants.additionalColorID) ?? Constants.white
        configureWrap()
        configureTitleLabel()
        configureDatesView()
        configureDescriptionView()
        configureDeleteButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    // MARK: - Private funcs
    private func configureWrap() {
        mainColor = getDarkerColor(mainColor)
        
        wrapView.layer.cornerRadius = Constants.wrapCornerRadius
        wrapView.backgroundColor = Constants.white
        titleBack.backgroundColor = mainColor
        titleBack.layer.cornerRadius = Constants.titleBackRadius
        
        addSubview(wrapView)
        wrapView.addSubview(titleBack)
        
        wrapView.pinVertical(to: self, Constants.wrapVetical)
        wrapView.pinHorizontal(to: self, Constants.wrapHorizontal)
        titleBack.setHeight(Constants.titleBackHeight)
        titleBack.pinTop(to: wrapView.topAnchor, Constants.titleBackTop)
        titleBack.pinCenterX(to: wrapView)
        titleBack.pinHorizontal(to: wrapView, Constants.titleBackOffset)
    }
    
    private func getDarkerColor(_ color: UIColor) -> UIColor {
        var redLevel: CGFloat = 0
        var greenLevel: CGFloat = 0
        var blueLevel: CGFloat = 0
        var alphaLevel: CGFloat = 0
        color.getRed(&redLevel, green: &greenLevel, blue: &blueLevel, alpha: &alphaLevel)
        
        redLevel = redLevel - Constants.colorShift < 0 ? 0 : redLevel - Constants.colorShift
        greenLevel = greenLevel - Constants.colorShift < 0 ? 0 : greenLevel - Constants.colorShift
        blueLevel = blueLevel - Constants.colorShift < 0 ? 0 : blueLevel - Constants.colorShift
        
        return UIColor(red: redLevel, green: greenLevel, blue: blueLevel, alpha: alphaLevel)
    }
    
    private func configureTitleLabel() {
        calendarView.tintColor = mainColor
        
        titleBack.addSubview(titleLabel)
        
        titleLabel.textColor = .white
        titleLabel.pinCenterY(to: titleBack)
        titleLabel.pinLeft(to: titleBack.leadingAnchor, Constants.titleLeading)
        titleLabel.font = Constants.titleFont
    }
    
    private func configureDatesView() {
        datesStack.axis = .vertical
        datesStack.spacing = Constants.datesStackSpacing
        datesArray = [startDateLabel, endDateLabel]
        
        for dateLabel in datesArray {
            datesStack.addArrangedSubview(dateLabel)
            dateLabel.textColor = mainColor
            dateLabel.font = Constants.smallBoldFont
        }
        
        wrapView.addSubview(calendarView)
        wrapView.addSubview(datesStack)
        
        calendarView.pinTop(to: titleBack.bottomAnchor, Constants.calendarTop)
        calendarView.pinLeft(to: wrapView.leadingAnchor, Constants.calendarLeft)
        datesStack.pinCenterY(to: calendarView)
        datesStack.pinLeft(to: calendarView.trailingAnchor, Constants.datesStackLeft)
    }
    
    private func configureDescriptionView() {
        discriptionLabel.numberOfLines = Constants.discriptionLines
        discriptionLabel.lineBreakMode = .byWordWrapping
        discriptionLabel.font = Constants.smallFont
        discriptionLabel.textColor = mainColor
        noteView.tintColor = mainColor
        
        wrapView.addSubview(noteView)
        wrapView.addSubview(discriptionLabel)
        
        noteView.pinCenterY(to: calendarView)
        noteView.pinLeft(to: datesStack.trailingAnchor, Constants.noteLeft)
        discriptionLabel.setWidth(Constants.noteWidth)
        discriptionLabel.pinLeft(to: noteView.trailingAnchor, Constants.discriptinLeft)
        discriptionLabel.pinCenterY(to: noteView)
    }
    
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = mainColor
        
        wrapView.addSubview(deleteButton)
        
        deleteButton.pinCenterY(to: calendarView)
        deleteButton.pinRight(to: wrapView.trailingAnchor, Constants.deleteButtonRight)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func configure(with event: EventEntity) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = Constants.formatterString
        
        titleLabel.text = event.title
        discriptionLabel.text = event.note
        if let startDate = event.startDate, let endDate = event.endDate {
            startDateLabel.text = "\(dateFormatter.string(from: startDate))"
            endDateLabel.text = "\(dateFormatter.string(from: endDate))"
        }
        
        if startDateLabel.text == endDateLabel.text {
            datesArray = [startDateLabel]
        }
    }
    
    func resetAppearance() {
        wrapView.backgroundColor = Constants.white
        titleLabel.font = Constants.titleFont
    }
    
    // MARK: - Actions
    @objc
    private func deleteButtonTapped() {
        deleteCell?()
    }
}
