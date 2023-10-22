//  GirisVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 19.10.2023.
// food_loading_animation.riv

import UIKit
import Lottie

class GirisVC: UIViewController {

	var animationView: LottieAnimationView?
	
	override func viewDidLoad() {
		super.viewDidLoad()
		

		//let backgroundImage = UIImage(named: "steam")

		
		animationView = .init(name: "foxanime")
		animationView?.frame = view.bounds
		animationView?.loopMode = .loop
		view.addSubview(animationView!)
		animationView?.play()
		
		animationView?.loopMode = .playOnce
		animationView?.play { (finished) in
			if finished {
				self.navigateToLoginScreen()
			}
		}
	}
	
	func navigateToLoginScreen() {
		performSegue(withIdentifier: "toLogin", sender: nil)
	}
}
