//
//  WishEventCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit



final class WishEventCell: UICollectionViewCell {
    
    enum Constants {
        static let offset: Double = 10.0
        static let cornerRadius: CGFloat = 10
        static let backgroundColor: UIColor = .white
        static let titleTop: CGFloat = 10
        static let titleFont: UIFont = .boldSystemFont(ofSize: 15)
        static let titleLeading: CGFloat = 40
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let titleBackHeight: CGFloat = 23
        static let titleBackTop: CGFloat = 10
        static let titleBackWidth: CGFloat = 340
        static let titleBackRadius: CGFloat = 5
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let smallBoldFont: UIFont = .boldSystemFont(ofSize: 12)
        static let smallFont: UIFont = .systemFont(ofSize: 14)
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
    
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let discriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    private let titleBack: UIView = UIView()
    private let calendarView: UIImageView = UIImageView(image: Constants.calendarImage)
    private let noteView: UIImageView = UIImageView(image: Constants.noteImage)
    private let datesStack: UIStackView = UIStackView()
    private let deleteButton: UIButton = UIButton()
    
    var deleteCell: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDatesView()
        configureDescriptionView()
        configureDeleteButton()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureWrap() {
        wrapView.layer.cornerRadius = Constants.cornerRadius
        wrapView.backgroundColor = Constants.backgroundColor
        titleBack.backgroundColor = Constants.darkBlue
        titleBack.layer.cornerRadius = Constants.titleBackRadius
        
        addSubview(wrapView)
        wrapView.addSubview(titleBack)
        
        wrapView.pinVertical(to: self, 3)
        wrapView.pinHorizontal(to: self, 10)
        titleBack.setHeight(Constants.titleBackHeight)
        titleBack.pinTop(to: wrapView.topAnchor, Constants.titleBackTop)
        titleBack.pinCenterX(to: wrapView)
        titleBack.setWidth(Constants.titleBackWidth)
    }
    
    private func configureTitleLabel() {
        calendarView.tintColor = Constants.darkBlue
        
        titleBack.addSubview(titleLabel)
        
        titleLabel.textColor = .white
        titleLabel.pinCenterY(to: titleBack)
        titleLabel.pinLeft(to: titleBack.leadingAnchor, 10)
        titleLabel.font = Constants.titleFont
    }
    
    private func configureDatesView() {
        datesStack.axis = .vertical
        datesStack.spacing = 10
        let datesArray: Array<UILabel> = [startDateLabel, endDateLabel]
        
        
        
        for dateLabel in datesArray {
            datesStack.addArrangedSubview(dateLabel)
            dateLabel.textColor = Constants.darkBlue
            dateLabel.font = Constants.smallBoldFont
        }
        
        wrapView.addSubview(calendarView)
        wrapView.addSubview(datesStack)
        
        calendarView.pinTop(to: titleBack.bottomAnchor, 15)
        calendarView.pinLeft(to: wrapView.leadingAnchor, 15)
        datesStack.pinCenterY(to: calendarView)
        datesStack.pinLeft(to: calendarView.trailingAnchor, 10)
    }
    
    private func configureDescriptionView() {
        discriptionLabel.numberOfLines = 0
        discriptionLabel.lineBreakMode = .byWordWrapping
        discriptionLabel.font = Constants.smallFont
        discriptionLabel.textColor = Constants.darkBlue
        noteView.tintColor = Constants.darkBlue
        
        wrapView.addSubview(noteView)
        wrapView.addSubview(discriptionLabel)
        
        noteView.pinCenterY(to: calendarView)
        noteView.pinLeft(to: datesStack.trailingAnchor, 20)
        discriptionLabel.setWidth(150)
        discriptionLabel.pinLeft(to: noteView.trailingAnchor, 10)
        discriptionLabel.pinCenterY(to: noteView)
    }
    
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = Constants.darkBlue
        
        wrapView.addSubview(deleteButton)
        
        deleteButton.pinCenterY(to: calendarView)
        deleteButton.pinRight(to: wrapView.trailingAnchor, 10)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Cell Configuration
    func configure(with event: EventEntity) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        titleLabel.text = event.title
        discriptionLabel.text = event.note
        if let startDate = event.startDate, let endDate = event.endDate {
            startDateLabel.text = "\(dateFormatter.string(from: startDate))"
            endDateLabel.text = "\(dateFormatter.string(from: endDate))"
        }
    }
    
    @objc
    private func deleteButtonTapped() {
        deleteCell?()
    }
}
