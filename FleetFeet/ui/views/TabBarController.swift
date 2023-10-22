//
//  CustomTabBarController.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 17.10.2023.
//


import UIKit

class TabBarController: UITabBarController {

	// Ellipse için bir UIView referansı oluşturma
	private var ellipseView: UIView!
	private var backgroundImageView: UIImageView!

	override func viewDidLoad() {
		super.viewDidLoad()

		setupBackgroundImage()
		setupEllipseView()
	}

	private func setupBackgroundImage() {
		// Arka plan için bir UIImageView oluşturma
		backgroundImageView = UIImageView(frame: tabBar.bounds)
		backgroundImageView.image = UIImage(named: "stream")
		backgroundImageView.contentMode = .scaleAspectFill
		backgroundImageView.clipsToBounds = true

		// backgroundImageView'ı tabBar'ın en alt katmanına ekleme
		tabBar.insertSubview(backgroundImageView, at: 0)

		// Auto Layout kullanarak backgroundImageView'ın konumunu ve boyutunu ayarlama
		backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			backgroundImageView.topAnchor.constraint(equalTo: tabBar.topAnchor),
			backgroundImageView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
			backgroundImageView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			backgroundImageView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
		])
	}

	private func setupEllipseView() {
		ellipseView = UIView()



		// Elipsin köşelerini yuvarlama
		ellipseView.layer.cornerRadius = 25

		// ellipseView'ı tabBar'ın üzerine ekleme
		tabBar.insertSubview(ellipseView, aboveSubview: backgroundImageView)

		// Auto Layout kullanarak ellipseView'ın konumunu ve boyutunu ayarlama
		ellipseView.translatesAutoresizingMaskIntoConstraints = false
		NSLayoutConstraint.activate([
			ellipseView.topAnchor.constraint(equalTo: tabBar.topAnchor),
			ellipseView.bottomAnchor.constraint(equalTo: tabBar.bottomAnchor),
			ellipseView.leadingAnchor.constraint(equalTo: tabBar.leadingAnchor),
			ellipseView.trailingAnchor.constraint(equalTo: tabBar.trailingAnchor)
		])
	}
}
