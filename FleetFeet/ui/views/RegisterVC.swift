//
//  RegisterVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 17.10.2023.
//

import UIKit
import Kingfisher


class RegisterVC: UIViewController {


	
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
	
	
	@IBOutlet weak var emailTextField: UITextField!

	
	@IBOutlet weak var newUsernameTextField: UITextField!

	
	@IBOutlet weak var newPasswordTextField: UITextField!
	@IBOutlet weak var confirmPasswordTextField: UITextField!
	
	
	@IBAction func createButtonTapped(_ sender: UIButton) {
		guard let newUsername = newUsernameTextField.text,
					let newEmail = emailTextField.text,
					let newPassword = newPasswordTextField.text,
					let confirmPassword = confirmPasswordTextField.text,
					newPassword == confirmPassword else {
						print("Passwords do not match or fields are empty!")
						return
		}
		
		DatabaseManager().addUser(name: newUsername, email: newEmail, password: newPassword)
		
		
	}
	
	
	


}
