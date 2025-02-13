//
//  AddWishCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 07.11.2024.
//

import UIKit


final class AddWishCell: UITableViewCell {
    
    
    static let reuseId: String = "AddWishCell"
    
    // MARK: - Constants
    enum Constants {
        static let wishTextViewRadius: CGFloat = 10
        static let wishTextViewBorderWidth: CGFloat = 1
        static let wishTextViewFontSize: CGFloat = 18
        
        static let wishTextViewLeading: CGFloat = 16
        static let wishTextViewTrailing: CGFloat = 16
        static let wishTextViewTop: CGFloat = 40
        static let wishTextViewHeight: CGFloat = 50
        
        static let addButtonTop: CGFloat = 8
        static let addButtonBottom: CGFloat = 8
        static let addButtonWidth: CGFloat = 100
        static let addButtonTitle: String = "Add wish"
        static let addButtonRadius: CGFloat = 10
        
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        }
    
    // MARK: - Variables
    var addWish: ((String) -> Void)?
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton = UIButton(type: .system)
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func addWishTapped() {
        guard let text = wishTextView.text, !text.isEmpty && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }
        addWish?(text)
        wishTextView.text = ""
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        contentView.backgroundColor = Constants.lightBlue
        wishTextView.layer.cornerRadius = Constants.wishTextViewRadius
        wishTextView.layer.borderWidth = Constants.wishTextViewBorderWidth
        wishTextView.layer.borderColor = UIColor.lightGray.cgColor
        wishTextView.textColor = .gray
        wishTextView.font = UIFont.systemFont(ofSize: Constants.wishTextViewFontSize)
        
        addButton.setTitle(Constants.addButtonTitle, for: .normal)
        addButton.backgroundColor = Constants.darkBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = Constants.buttonFont
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
        
        contentView.addSubview(wishTextView)
        contentView.addSubview(addButton)
        
        wishTextView.pinLeft(to: contentView, Constants.wishTextViewLeading)
        wishTextView.pinRight(to: contentView, Constants.wishTextViewTrailing)
        wishTextView.pinTop(to: contentView, Constants.wishTextViewTop)
        wishTextView.setHeight(Constants.wishTextViewHeight)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonTop)
        addButton.pinCenterX(to: contentView)
        addButton.pinBottom(to: contentView, Constants.addButtonBottom)
        addButton.setWidth(Constants.addButtonWidth)
        addButton.layer.cornerRadius = Constants.addButtonRadius
    }
}
