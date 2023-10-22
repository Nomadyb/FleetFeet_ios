//
//  Urun.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 14.10.2023.
//

import Foundation

class Urun : Codable {
	var yemek_id: String?
	var yemek_adi: String?
	var yemek_resim_adi: String?
	var yemek_fiyat: String?
	
	// Eklenen özellikler
	var puan: Int?
	var kcal: Int?
	var delivery:Int?
	var description: String?

	init() {

	}

	init(yemek_id: String, yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: String) {
		 self.yemek_id = yemek_id
		 self.yemek_adi = yemek_adi
		 self.yemek_resim_adi = yemek_resim_adi
		 self.yemek_fiyat = yemek_fiyat
	}
}
