//
//  InfoViewController.swift
//  Auto_Layout_Lisenskaya
//
//  Created by ElenaL on 17.10.2022.
//

import UIKit

class InfoViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let button = UIButton(frame: CGRect(x: 100, y: 200, width: 200, height: 50))
            button.setTitle("Action Alert", for: .normal)
            button.setTitleColor(.black, for: .normal)
            button.backgroundColor = UIColor.lightGray
            button.addTarget(self, action: #selector(actionAlert), for: .touchUpInside)
            self.view.addSubview(button)

        }
                
    @objc func actionAlert(sender: UIButton!){
        
        let alert = UIAlertController(title: "Sign out?", message: "You can always access your content by signing back in", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { action in
            print("See you!")}))
        alert.addAction(UIAlertAction(title: "No", style: .cancel, handler: { action in
            print("Ok")
        }))
        
        self.present(alert, animated: true)
        
    }

}
