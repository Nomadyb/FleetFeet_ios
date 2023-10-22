
//  SepetViewModel.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 16.10.2023.
//

import Foundation
import RxSwift

class SepetViewModel {
	var sepetRepo = SepetDaoRepository()
	var sepetUrunler = BehaviorSubject<[Sepet]>(value: [Sepet]())

	private let kullanici_adi: String

	init(kullaniciAdi: String) {
		self.kullanici_adi = kullaniciAdi
		sepetiYukle()
	}

	func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int) {
		sepetRepo.sepeteEkle(yemek_adi: yemek_adi, yemek_resim_adi: yemek_resim_adi, yemek_fiyat: yemek_fiyat, yemek_siparis_adet: yemek_siparis_adet, kullanici_adi: kullanici_adi)
		sepetiYukle()
	}

	func sepetiYukle() {
		sepetRepo.sepetiYukle(kullanici_adi: "emin")
	}

	func sil(sepet_yemek_id: Int) {
		sepetRepo.sepettenSil(sepet_yemek_id: sepet_yemek_id, kullanici_adi: kullanici_adi)
		sepetiYukle()
	}
}
