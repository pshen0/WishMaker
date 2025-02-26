//
//  CustomCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 07.11.2024.
//

import UIKit

final class WrittenWishCell: UITableViewCell {
    // MARK: - Constants
    private enum Constants {
        // Common
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let initError: String = "init(coder:) has not been implemented"
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        static let colorShift: CGFloat = 0.35
        
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 3
        static let wrapOffsetH: CGFloat = 10
        
        static let wishLabelOffset: CGFloat = 8
        static let wishLabelLines: Int = 0
        
        static let trashImage: UIImage? = UIImage(systemName: "trash")
        static let deleteButtonRights: CGFloat = 10
    }
    
    // MARK: - Fields
    static let reuseId: String = "WrittenWishCell"
    private let wishLabel: UILabel = UILabel()
    private let deleteButton: UIButton = UIButton()
    var deleteWish: (() -> Void)?
    var mainColor = Constants.black
    var mainColorDark = Constants.black
    var additionalColor = Constants.white
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainColor = UserDefaults.standard.color(forKey: Constants.mainColorID) ?? Constants.black
        additionalColor = UserDefaults.standard.color(forKey: Constants.additionalColorID) ?? Constants.white
        mainColorDark = getDarkerColor(mainColor)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        backgroundColor = mainColor
        selectionStyle = .none
        configureWrap()
        configureLabel()
        configureDeleteButton()
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
    
    private func configureWrap() {
        contentView.backgroundColor = Constants.wrapColor
        contentView.layer.cornerRadius = Constants.wrapRadius
        
        contentView.pinVertical(to: self, Constants.wrapOffsetV)
        contentView.pinHorizontal(to: self, Constants.wrapOffsetH)
    }
    
    private func configureLabel() {
        wishLabel.textColor = mainColorDark
        wishLabel.numberOfLines = Constants.wishLabelLines
        wishLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(wishLabel)
        
        wishLabel.pin(to: contentView, Constants.wishLabelOffset)
        wishLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        wishLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = mainColorDark
        
        contentView.addSubview(deleteButton)
        
        deleteButton.pinCenterY(to: contentView)
        deleteButton.pinRight(to: contentView.trailingAnchor, Constants.deleteButtonRights)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - Funcs
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wishLabel.preferredMaxLayoutWidth = contentView.bounds.width - Constants.wishLabelOffset * 2
    }
    
    // MARK: - Actions
    @objc
    private func deleteButtonTapped() {
        deleteWish?()
    }
    
}
