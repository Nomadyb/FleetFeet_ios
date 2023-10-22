//
//  LoginVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 17.10.2023.
//

import UIKit
import Kingfisher



class LoginVC: UIViewController {


	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passwordTextField: UITextField!

	
	@IBAction func loginButtonTapped(_ sender: UIButton) {
		guard let email = usernameTextField.text,
					let password = passwordTextField.text else {
						print("Please enter your email and password!")
						return
			}

		if let _ = DatabaseManager().getUser(email: email, password: password) {
					// Doğru kullanıcı bilgisi
					self.performSegue(withIdentifier: "toTabBar", sender: nil)
				} else {
					// Yanlış kullanıcı bilgisi
					print("Invalid email or password")
				}
		
		self.performSegue(withIdentifier: "toTabBar", sender: nil)
		}
		
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		let backgroundImage = UIImage(named: "stream")
		
		let backgroundImageView = UIImageView(frame: self.view.bounds)
		backgroundImageView.image = backgroundImage
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.alpha = 0.70
		self.view.addSubview(backgroundImageView)
		self.view.sendSubviewToBack(backgroundImageView)
		
		
	}
	
	
	@IBAction func registerButtonTapped(_ sender: UIButton) {

		
		
	}
	


}
