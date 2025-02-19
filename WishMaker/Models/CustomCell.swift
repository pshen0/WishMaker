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
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let initError: String = "init(coder:) has not been implemented"
        
        static let wrapColor: UIColor = .white
        static let wrapRadius: CGFloat = 16
        static let wrapOffsetV: CGFloat = 3
        static let wrapOffsetH: CGFloat = 10
        
        static let wishLabelOffset: CGFloat = 8
        static let wishLabelLines: Int = 0
        
        static let trashImage: UIImage? = UIImage(systemName: "trash")
        static let deleteButtonRights: CGFloat = 10
    }
    
    static let reuseId: String = "WrittenWishCell"
    private let wishLabel: UILabel = UILabel()
    private let deleteButton: UIButton = UIButton()
    
    var deleteWish: (() -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = Constants.lightBlue
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    // MARK: - Funcs
    func configure(with wish: String) {
        wishLabel.text = wish
    }
    
    private func configureUI() {
        selectionStyle = .none
        configureWrap()
        configureLabel()
        configureDeleteButton()
    }
    
    private func configureWrap() {
        contentView.backgroundColor = Constants.wrapColor
        contentView.layer.cornerRadius = Constants.wrapRadius
        
        contentView.pinVertical(to: self, Constants.wrapOffsetV)
        contentView.pinHorizontal(to: self, Constants.wrapOffsetH)
    }
    
    private func configureLabel() {
        wishLabel.textColor = Constants.darkBlue
        wishLabel.numberOfLines = Constants.wishLabelLines
        wishLabel.lineBreakMode = .byWordWrapping
        
        contentView.addSubview(wishLabel)
        
        wishLabel.pin(to: contentView, Constants.wishLabelOffset)
        wishLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        wishLabel.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }
    
    private func configureDeleteButton() {
        deleteButton.setImage(Constants.trashImage, for: .normal)
        deleteButton.tintColor = Constants.darkBlue
        
        contentView.addSubview(deleteButton)
        
        deleteButton.pinCenterY(to: contentView)
        deleteButton.pinRight(to: contentView.trailingAnchor, Constants.deleteButtonRights)
        
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        wishLabel.preferredMaxLayoutWidth = contentView.bounds.width - Constants.wishLabelOffset * 2
    }
    
    @objc
    private func deleteButtonTapped() {
        deleteWish?()
    }
    
}
