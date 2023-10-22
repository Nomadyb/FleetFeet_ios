//
//  SepetHucre.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 21.10.2023.
//

import UIKit
import Kingfisher

class SepetHucre: UITableViewCell {
	
	
	
	// Sepet öğesinin resmini gösteren bir UIImageView
	@IBOutlet weak var imageViewSepet: UIImageView!
	
	// Sepet öğesinin adını gösteren bir UILabel
	@IBOutlet weak var yemekAdiLabel: UILabel!
	
	// Sepet öğesinin fiyatını gösteren bir UILabel
	@IBOutlet weak var yemekFiyatiLabel: UILabel!
	
	// Sepet öğesinin sipariş adedini gösteren bir UILabel
	@IBOutlet weak var urunSayisiLabel: UILabel!
	
	// Arka plan için bir UIView
	@IBOutlet weak var HucreView: UIView!

	override func awakeFromNib() {
		super.awakeFromNib()
		
		// Hücre başlatıldığında
		HucreView.layer.cornerRadius = 10.0
		HucreView.backgroundColor = UIColor(white: 0.95, alpha: 1)
		selectionStyle = .none
	}
	
	
	
}
