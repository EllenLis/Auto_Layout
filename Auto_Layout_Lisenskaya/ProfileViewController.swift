//
//  ProfileViewController.swift
//  Auto_Layout_Lisenskaya
//
//  Created by ElenaL on 17.10.2022.
//

import UIKit

class ProfileViewController: UIViewController {
    
    private lazy var profileHeaderView: ProfileHeaderView = {
            let view = ProfileHeaderView(frame: .zero)
            view.translatesAutoresizingMaskIntoConstraints = false
            return view
        }()

        private var heightConstraint: NSLayoutConstraint?
        
        private lazy var titleStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fill
            stackView.spacing = 10
            return stackView
        }()

        private lazy var titleTextField: UITextField = {
            let textField = UITextField()
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.backgroundColor = .white
            textField.textColor = .black
            textField.font = UIFont.systemFont(ofSize: 15.0)
            textField.layer.borderWidth = 1.0
            textField.layer.borderColor = UIColor.black.cgColor
            textField.layer.cornerRadius = 12.0
            let leftView = UIView(frame: CGRect(x: 0.0, y: 0.0, width: 20.0, height: 2.0))
            textField.leftView = leftView
            textField.leftViewMode = .always
            textField.clipsToBounds = true
            textField.placeholder = "Введите заголовок"
            return textField
        }()

        private lazy var titleButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemPink
            button.layer.cornerRadius = 12
            button.setTitle("Сменить заголовок", for: .normal)
            button.setTitleColor(.lightGray, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            button.addTarget(self, action: #selector(titleButtonAction), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupNavigationBar()
            self.view.addSubview(self.profileHeaderView)
            setupView()
            tapGesturt()
            setTitleStackView()
        }

        private func setupNavigationBar() {
               self.navigationItem.title = "Профиль"
           }

        private func setupView() {
            self.view.backgroundColor = .lightGray
            
            let viewTopConstraint = self.profileHeaderView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor)
            let viewLeadingConstraint = self.profileHeaderView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor)
            let viewTrailingConstraint = self.profileHeaderView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor)
            self.heightConstraint = self.profileHeaderView.heightAnchor.constraint(equalToConstant: 220)
            NSLayoutConstraint.activate([
                viewTopConstraint, viewLeadingConstraint, viewTrailingConstraint, self.heightConstraint
            ].compactMap( {$0} ))
        }

        func tapGesturt() {
            let tapGesture = UITapGestureRecognizer(target: self.view, action: #selector(view.endEditing))
            self.view.addGestureRecognizer(tapGesture)
        }

        func setTitleStackView() {
            self.view.addSubview(self.titleStackView)
            self.titleStackView.addArrangedSubview(titleTextField)
            self.titleStackView.addArrangedSubview(titleButton)

            let titleStackViewCenterY = self.titleStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            let titleStackViewLeadingConstraint = self.titleStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
            let titleStackViewTrailingConstraint = self.titleStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)

            let titleTextFieldHeightAnchor = self.titleTextField.heightAnchor.constraint(equalToConstant: 40)
            let titleButtonHeightAnchor = self.titleButton.heightAnchor.constraint(equalToConstant: 50)
            NSLayoutConstraint.activate([
                titleStackViewCenterY, titleStackViewLeadingConstraint, titleStackViewTrailingConstraint, titleTextFieldHeightAnchor, titleButtonHeightAnchor
                                        ].compactMap( {$0} ))
        }

        @objc private func titleButtonAction() {
            self.navigationItem.title = titleTextField.text!
            titleTextField.text = nil
        }

}
