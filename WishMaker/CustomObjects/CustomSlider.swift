//
//  CustomSlider.swift
//  aasazonova_1PW3
//
//  Created by Анна Сазонова on 04.11.2024.
//

import UIKit

final class CustomSlider: UIView {
    // MARK: - Constants
    enum Constants {
        // Common
        static let initError: String = "init(coder:) has not been implemented"
        static let black: UIColor = UIColor.black
        
        static let titleTop: CGFloat = 10
        static let titleLeading: CGFloat = 20
        
        static let sliderBottom: CGFloat = 10
        static let sliderLeading: CGFloat = 20
    }
    
    // MARK: - Fields
    var valueChanged: ((Double) -> Void)?
    var slider = UISlider()
    var titleView = UILabel()
    var value: CGFloat {
        get { CGFloat(slider.value) }
        set { slider.value = Float(newValue) }
    }
    // MARK: - Lifecycle
    init(title: String, min: Double, max: Double) {
        super.init(frame: .zero)
        titleView.text = title
        slider.minimumValue = Float(min)
        slider.maximumValue = Float(max)
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        configureUI()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError(Constants.initError)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    // MARK: - Private func
    private func configureUI() {
        backgroundColor = .white
        titleView.textColor = Constants.black
        
        for view in [slider, titleView] {
            addSubview(view)
            view.pinCenterX(to: centerXAnchor)
            
        }

        titleView.pinTop(to: topAnchor, Constants.titleTop)
        titleView.pinLeft(to: leadingAnchor, Constants.titleLeading)
        slider.pinTop(to: titleView.bottomAnchor)
        slider.pinBottom(to: bottomAnchor, Constants.sliderBottom)
        slider.pinLeft(to: leadingAnchor, Constants.sliderLeading)
    }
    
    // MARK: - Actions
    @objc
    private func sliderValueChanged() {
        valueChanged?(Double(slider.value))
    }
}
