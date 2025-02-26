//
//  AddWishCell.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 07.11.2024.
//

import UIKit

final class AddWishCell: UITableViewCell {
    // MARK: - Constants
    enum Constants {
        // Common constants
        static let white: UIColor = UIColor.white
        static let black: UIColor = UIColor.black
        static let initError: String = "init(coder:) has not been implemented"
        static let emptyString: String = ""
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        static let mainColorID: String = "mainColor"
        static let additionalColorID: String = "additionalColor"
        
        static let wishTitleText: String = "Enter your wish"
        static let wishTitleSize: CGFloat = 32
        static let wishTitleTop: CGFloat = 60
        
        static let wishTextViewRadius: CGFloat = 10
        static let wishTextViewBorderWidth: CGFloat = 1
        static let wishTextViewFontSize: CGFloat = 18
        static let wishTextViewLeading: CGFloat = 16
        static let wishTextViewTrailing: CGFloat = 16
        static let wishTextViewTop: CGFloat = 150
        static let wishTextViewHeight: CGFloat = 40
        
        static let addButtonTop: CGFloat = 8
        static let addButtonBottom: CGFloat = 8
        static let addButtonWidth: CGFloat = 100
        static let addButtonTitle: String = "Add wish"
        static let addButtonRadius: CGFloat = 10
        }
    
    // MARK: - Fields
    static let reuseId: String = "AddWishCell"
    private let wishTitle: UILabel = UILabel()
    private let wishTextView: UITextView = UITextView()
    private let addButton: UIButton = UIButton(type: .system)
    private var mainColor = Constants.black
    private var additionalColor = Constants.white
    var addWish: ((String) -> Void)?
    
    // MARK: - Lifecycle
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        mainColor = UserDefaults.standard.color(forKey: Constants.mainColorID) ?? Constants.black
        additionalColor = UserDefaults.standard.color(forKey: Constants.additionalColorID) ?? Constants.white
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    // MARK: - Private funcs
    private func configureUI() {
        contentView.backgroundColor = mainColor
        configureTitle()
        configureWishTextView()
        configureAddButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    private func configureTitle() {
        wishTitle.text = Constants.wishTitleText
        wishTitle.font = UIFont.boldSystemFont(ofSize: Constants.wishTitleSize)
        wishTitle.textColor = additionalColor
        
        addSubview(wishTitle)
        
        wishTitle.pinCenterX(to: self)
        wishTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor, Constants.wishTitleTop)
    }
    
    private func configureWishTextView() {
        wishTextView.layer.cornerRadius = Constants.wishTextViewRadius
        wishTextView.layer.borderWidth = Constants.wishTextViewBorderWidth
        wishTextView.layer.borderColor = UIColor.lightGray.cgColor
        wishTextView.textColor = .gray
        wishTextView.tintColor = mainColor
        wishTextView.backgroundColor = Constants.white
        wishTextView.font = UIFont.systemFont(ofSize: Constants.wishTextViewFontSize)
        wishTextView.delegate = self
        
        contentView.addSubview(wishTextView)
        
        wishTextView.pinLeft(to: contentView, Constants.wishTextViewLeading)
        wishTextView.pinRight(to: contentView, Constants.wishTextViewTrailing)
        wishTextView.pinTop(to: contentView, Constants.wishTextViewTop)
        wishTextView.setHeight(Constants.wishTextViewHeight)
    }
    
    private func configureAddButton() {
        addButton.setTitle(Constants.addButtonTitle, for: .normal)
        addButton.backgroundColor = additionalColor
        addButton.setTitleColor(mainColor, for: .normal)
        addButton.titleLabel?.font = Constants.buttonFont
        addButton.layer.cornerRadius = Constants.addButtonRadius
        
        contentView.addSubview(addButton)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonTop)
        addButton.pinCenterX(to: contentView)
        addButton.pinBottom(to: contentView, Constants.addButtonBottom)
        addButton.setWidth(Constants.addButtonWidth)
        
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
    }
    
    // MARK: - Actions
    @objc
    private func dismissKeyboard() {
        wishTextView.resignFirstResponder()
    }
    
    @objc
    private func addWishTapped() {
        guard let text = wishTextView.text, !text.isEmpty && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }
        addWish?(text)
        wishTextView.text = Constants.emptyString
        wishTextView.resignFirstResponder()
    }
}

// MARK: - Extension
extension AddWishCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
