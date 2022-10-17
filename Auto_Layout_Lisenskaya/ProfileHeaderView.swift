//
//  ProfileHeaderView.swift
//  Auto_Layout_Lisenskaya
//
//  Created by ElenaL on 17.10.2022.
//

import UIKit

protocol ProfileHeaderViewProtocol: AnyObject {
    func buttonPressed()
}

class ProfileHeaderView: UIView, ProfileHeaderViewProtocol {
    
    var statusText: String? = nil
      
        private lazy var avatarImageView: UIImageView = {
            let imageView = UIImageView(image: UIImage(named: "2-1.jpeg"))
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.borderWidth = 3.0
            imageView.layer.borderColor = UIColor.white.cgColor
            imageView.layer.cornerRadius = 70.0
            imageView.clipsToBounds = true
            return imageView
        }()
    
        private lazy var firstStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .horizontal
            stackView.spacing = 16

            return stackView
        }()
    
        private lazy var secondStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 40
            return stackView
        }()

        private lazy var fullNameLabel: UILabel = {
            let label = UILabel()
            label.text  = "Cute Cat"
            label.textColor = .black
            label.font = UIFont.boldSystemFont(ofSize: 18.0)
            return label
        }()

        private lazy var statusLabel: UILabel = {
            let statusLabel = UILabel()
            statusLabel.text = "Waiting for something..."
            statusLabel.textColor = .gray
            statusLabel.font = UIFont.systemFont(ofSize: 14.0)
            return statusLabel
        }()

        private lazy var statusTextField: UITextField = {
            let textField = UITextField()
            textField.isHidden = true
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.font = UIFont.systemFont(ofSize: 15.0)
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.cornerRadius = 12.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 10.0, height: 2.0))
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.clipsToBounds = true
            textField.placeholder = "Waiting for something..."
            return textField
        }()

        private lazy var setStatusButton: UIButton = {
            let statusButton = UIButton()
            statusButton.setTitle("Set status", for: .normal)
            statusButton.setTitleColor(.white, for: .normal)
            statusButton.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            statusButton.translatesAutoresizingMaskIntoConstraints = false
            statusButton.backgroundColor = .blue
            statusButton.layer.cornerRadius = 4
            statusButton.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            
            statusButton.layer.shadowOffset = CGSize(width: 4.0, height: 4.0)
            statusButton.layer.shadowRadius = 4.0
            statusButton.layer.shadowColor = UIColor.black.cgColor
            statusButton.layer.shadowOpacity = 0.7
            statusButton.layer.shouldRasterize = true

            return statusButton
        }()

        private var buttonTopConstrain: NSLayoutConstraint?
        
        weak var delegate: ProfileHeaderViewProtocol?
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            createSubviews()
        }

        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been")
        }

        func createSubviews() {
            self.addSubview(firstStackView)
            self.addSubview(statusTextField)
            self.addSubview(setStatusButton)
            self.firstStackView.addArrangedSubview(avatarImageView)
            self.firstStackView.addArrangedSubview(secondStackView)
            self.secondStackView.addArrangedSubview(fullNameLabel)
            self.secondStackView.addArrangedSubview(statusLabel)
            setupConstraints()
        }

        func setupConstraints() {
            let firstStackViewTopConstraint = self.firstStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 16)
            let firstStackViewLeadingConstraint = self.firstStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
            let firstStackViewTrailingConstraint = self.firstStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
           
            let avatarImageViewRatioConstraint = self.avatarImageView.heightAnchor.constraint(equalTo: self.avatarImageView.widthAnchor, multiplier: 1.0)
            self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: 16)
            self.buttonTopConstrain?.priority = UILayoutPriority(rawValue: 999)
            let buttonLeadingConstraint = self.setStatusButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16)
            let buttonTrailingConstraint = self.setStatusButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16)
            let buttonHeightConstraint = self.setStatusButton.heightAnchor.constraint(equalToConstant: 50)
            let buttonBottomConstraint = self.setStatusButton.bottomAnchor.constraint(equalTo: self.bottomAnchor)

            NSLayoutConstraint.activate([
                firstStackViewTopConstraint, firstStackViewLeadingConstraint,
                firstStackViewTrailingConstraint, avatarImageViewRatioConstraint,
                self.buttonTopConstrain, buttonLeadingConstraint, buttonTrailingConstraint,
                buttonHeightConstraint, buttonBottomConstraint
            ].compactMap( {$0} ))
        }

    @objc internal func buttonPressed() {
        
        let topConstrain = self.statusTextField.topAnchor.constraint(equalTo: self.firstStackView.bottomAnchor, constant: -10)
        let leadingConstrain = self.statusTextField.leadingAnchor.constraint(equalTo: self.secondStackView.leadingAnchor)
        let trailingConstrain = self.statusTextField.trailingAnchor.constraint(equalTo: self.firstStackView.trailingAnchor)
        let textHeight = self.statusTextField.heightAnchor.constraint(equalToConstant: 40)
        self.buttonTopConstrain = self.setStatusButton.topAnchor.constraint(equalTo: self.statusTextField.bottomAnchor, constant: 16)
        
        if self.statusTextField.isHidden {
            self.addSubview(self.statusTextField)
            statusTextField.text = nil
            
            setStatusButton.setTitle("Set status", for: .normal)
            self.buttonTopConstrain?.isActive = false
            NSLayoutConstraint.activate([topConstrain, leadingConstrain, trailingConstrain, textHeight, buttonTopConstrain].compactMap( {$0} ))
            
        } else {
            statusText = statusTextField.text!
            statusLabel.text = "\(statusText ?? "")"
            setStatusButton.setTitle("Show status", for: .normal)
            
            self.statusTextField.removeFromSuperview()
            NSLayoutConstraint.deactivate([topConstrain, leadingConstrain, trailingConstrain, textHeight].compactMap( {$0} ))
        }
        
        func statusTextChanged(_ textField: UITextField) {
            if let text = textField.text {
                statusText = text
            }
        }
        
    }

}
