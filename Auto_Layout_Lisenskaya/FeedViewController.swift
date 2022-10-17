//
//  ViewController.swift
//  Auto_Layout_Lisenskaya
//
//  Created by ElenaL on 17.10.2022.
//

import UIKit

class FeedViewController: UIViewController {
    
    var post = Post(title: "Мой пост")
    
    private lazy var buttonStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.translatesAutoresizingMaskIntoConstraints = false
            stackView.axis = .vertical
            stackView.distribution = .fillEqually
            stackView.spacing = 10

            return stackView
        }()

        private lazy var firstButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .systemPink
            button.layer.cornerRadius = 12
            button.setTitle("Перейти на пост", for: .normal)
            button.setTitleColor(.purple, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        private lazy var secondButton: UIButton = {
            let button = UIButton()
            button.backgroundColor = .red
            button.layer.cornerRadius = 12
            button.setTitle("Перейти на пост", for: .normal)
            button.setTitleColor(.purple, for: .normal)
            button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 24)
            button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
            button.translatesAutoresizingMaskIntoConstraints = false
            return button
        }()

        override func viewDidLoad() {
            super.viewDidLoad()
            setupNavigationBar()
            setButtonStackView()
        }

        private func setupNavigationBar() {
            view.backgroundColor = .purple
            self.navigationItem.title = "Лента"
           }

        func setButtonStackView() {
            self.view.addSubview(self.buttonStackView)
            self.buttonStackView.addArrangedSubview(firstButton)
            self.buttonStackView.addArrangedSubview(secondButton)

            let buttonStackViewCenterY = self.buttonStackView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
            let buttonStackViewLeadingConstraint = self.buttonStackView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16)
            let buttonStackViewTrailingConstraint = self.buttonStackView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16)
            let firstButtonHeightAnchor = self.firstButton.heightAnchor.constraint(equalToConstant: 50)
            let secondButtonHeightAnchor = self.secondButton.heightAnchor.constraint(equalToConstant: 50)
            NSLayoutConstraint.activate([buttonStackViewCenterY, buttonStackViewLeadingConstraint,
                                         buttonStackViewTrailingConstraint, firstButtonHeightAnchor,
                                         secondButtonHeightAnchor
                                        ].compactMap( {$0} ))
        }

        @objc private func buttonPressed() {
            let postViewController = PostViewController()
            postViewController.titlePost = post.title
            self.navigationController?.pushViewController(postViewController, animated: true)
        }

}

