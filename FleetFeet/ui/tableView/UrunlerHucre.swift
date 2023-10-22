//
//  CustomCollectionViewCell.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 12.10.2023.
//

import UIKit

protocol UrunlerHucreProtokol {
	func eklemeButonuTiklandi(indexPath: IndexPath)
}

class UrunlerHucre: UICollectionViewCell {
	
	@IBOutlet weak var resimView: UIImageView!
	@IBOutlet weak var fiyatEtiketi: UILabel!
	
	@IBOutlet weak var descriptionLabel: UILabel!
	
	
	
	
	var hucreProtokolu: UrunlerHucreProtokol?
	var indexPath: IndexPath?
	

	func configure(with urun: Urun) {

		if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(urun.yemek_resim_adi!)") {
			self.resimView.kf.setImage(with: url)
		}
		
		
		

		// Fiyat bilgisi
		self.fiyatEtiketi.text = "\(urun.yemek_fiyat ?? "0") $"

		// Açıklama bilgisi
		self.descriptionLabel.text = urun.description
	}
	
	
	
	@IBAction func eklemeButonuAksiyonu(_ sender: UIButton) {
		print("add çalıştı")
		if let ip = indexPath {
			hucreProtokolu?.eklemeButonuTiklandi(indexPath: indexPath!)
			
			
		}
	}
}
