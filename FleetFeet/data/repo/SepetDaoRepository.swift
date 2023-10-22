//
//  SepetDaoRepository.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 18.10.2023.
//

import Foundation
import Alamofire
import RxSwift

class SepetDaoRepository {
	private let baseURL = "http://kasimadalan.pe.hu/yemekler/"
	var sepetList = BehaviorSubject<[Sepet]>(value: [Sepet]())

	func sepeteEkle(yemek_adi: String, yemek_resim_adi: String, yemek_fiyat: Int, yemek_siparis_adet: Int, kullanici_adi: String) {
		let params: Parameters = [
			"yemek_adi": yemek_adi,
			"yemek_resim_adi": yemek_resim_adi,
			"yemek_fiyat": yemek_fiyat,
			"yemek_siparis_adet": yemek_siparis_adet,
			"kullanici_adi": kullanici_adi
		]

		AF.request(self.baseURL + "sepeteYemekEkle.php", method: .post, parameters: params).response { response in
			if let data = response.data {
				do {
					let answer = try JSONDecoder().decode(CRUD.self, from: data)
					print("success: \(answer.success!)")
					print("message: \(answer.message!)")
				} catch {
					print(error.localizedDescription)
				}
			}
		}
	}

	func sepetiYukle(kullanici_adi: String) {
		let params: Parameters = ["kullanici_adi": kullanici_adi]

		AF.request(self.baseURL + "sepettekiYemekleriGetir.php", method: .post, parameters: params).response { response in
			if let data = response.data {
				do {
					let answer = try JSONDecoder().decode(SepetResponse.self, from: data)
					if let list = answer.sepet_yemekler {
						self.sepetList.onNext(list)
					}
				} catch {
					print(error.localizedDescription)
				}
			}
		}
	}

	func sepettenSil(sepet_yemek_id: Int, kullanici_adi: String) {
		let params: Parameters = ["sepet_yemek_id": sepet_yemek_id, "kullanici_adi": kullanici_adi]

		AF.request(self.baseURL + "sepettenYemekSil.php", method: .post, parameters: params).response { response in
			if let data = response.data {
				do {
					let answer = try JSONDecoder().decode(CRUD.self, from: data)
					print("success: \(answer.success!)")
					print("message: \(answer.message!)")
					self.sepetiYukle(kullanici_adi: kullanici_adi) // Sepeti güncelleyelim.
				} catch {
					print(error.localizedDescription)
				}
			}
		}
	}
}
