//
//  WishEventCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 13.02.2025.
//

import UIKit

struct WishEventModel {
    let title: String
    let description: String
    let startDate: String
    let endDate: String
}

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
    }
    
    static let reuseIdentifier: String = "WishEventCell"
    private let wrapView: UIView = UIView()
    private let titleLabel: UILabel = UILabel()
    private let descriptionLabel: UILabel = UILabel()
    private let startDateLabel: UILabel = UILabel()
    private let endDateLabel: UILabel = UILabel()
    private let titleBack: UIView = UIView()
    
    
    // MARK: - Lifecycle
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureWrap()
        configureTitleLabel()
        configureDescriptionLabel()
        configureStartDateLabel()
        configureEndDateLabel()
        
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
        
        wrapView.pin(to: self, Constants.offset)
        titleBack.setHeight(Constants.titleBackHeight)
        titleBack.pinTop(to: wrapView.topAnchor, Constants.titleBackTop)
        titleBack.pinCenterX(to: wrapView)
        titleBack.setWidth(Constants.titleBackWidth)
    }
    
    private func configureTitleLabel() {
        titleBack.addSubview(titleLabel)
        
        titleLabel.textColor = .white
        titleLabel.pinCenterY(to: titleBack)
        titleLabel.pinLeft(to: titleBack.leadingAnchor, 10)
        titleLabel.font = Constants.titleFont
        
        
    }
    
    private func configureDescriptionLabel() {
        
    }
    
    private func configureStartDateLabel() {
        
    }
    
    private func configureEndDateLabel() {
        
    }
    
    // MARK: - Cell Configuration
    func configure(with event: WishEventModel) {
        titleLabel.text = event.title
        descriptionLabel.text = event.description
        startDateLabel.text = "Start Date: \(event.startDate)"
        endDateLabel.text = "End Date: \(event.endDate)"
    }
}
