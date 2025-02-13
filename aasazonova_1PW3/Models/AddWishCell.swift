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
        
        static let lightBlue: UIColor = UIColor(red: 201/255.0, green: 231/255.0, blue: 255/255.0, alpha: 1.0)
        static let darkBlue: UIColor = UIColor(red: 41/255.0, green: 69/255.0, blue: 140/255.0, alpha: 1.0)
        static let white: UIColor = UIColor(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        static let buttonFont: UIFont = .boldSystemFont(ofSize: 15)
        }
    
    // MARK: - Variables
    var addWish: ((String) -> Void)?
    private let wishTitle: UILabel = UILabel()
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
    
    // MARK: - Private funcs
    private func configureUI() {
        contentView.backgroundColor = Constants.lightBlue
        configureLabel()
        configureWishTextView()
        configureAddButton()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        contentView.addGestureRecognizer(tapGesture)
    }
    
    private func configureLabel() {
        wishTitle.text = Constants.wishTitleText
        wishTitle.font = UIFont.boldSystemFont(ofSize: Constants.wishTitleSize)
        wishTitle.textColor = Constants.darkBlue
        
        addSubview(wishTitle)
        
        wishTitle.pinCenterX(to: self)
        wishTitle.pinTop(to: self.safeAreaLayoutGuide.topAnchor, Constants.wishTitleTop)
    }
    
    private func configureWishTextView() {
        wishTextView.layer.cornerRadius = Constants.wishTextViewRadius
        wishTextView.layer.borderWidth = Constants.wishTextViewBorderWidth
        wishTextView.layer.borderColor = UIColor.lightGray.cgColor
        wishTextView.textColor = .gray
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
        addButton.backgroundColor = Constants.darkBlue
        addButton.setTitleColor(.white, for: .normal)
        addButton.titleLabel?.font = Constants.buttonFont
        addButton.layer.cornerRadius = Constants.addButtonRadius
        
        contentView.addSubview(addButton)
        
        addButton.pinTop(to: wishTextView.bottomAnchor, Constants.addButtonTop)
        addButton.pinCenterX(to: contentView)
        addButton.pinBottom(to: contentView, Constants.addButtonBottom)
        addButton.setWidth(Constants.addButtonWidth)
        
        addButton.addTarget(self, action: #selector(addWishTapped), for: .touchUpInside)
    }
    
    @objc private func dismissKeyboard() {
        wishTextView.resignFirstResponder()
    }
    
    @objc private func addWishTapped() {
        guard let text = wishTextView.text, !text.isEmpty && !text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        else { return }
        addWish?(text)
        wishTextView.text = ""
        wishTextView.resignFirstResponder()
    }
}

extension AddWishCell: UITextViewDelegate {
    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        return true
    }
}
