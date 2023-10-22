//
//  File.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 16.10.2023.
//

import Foundation
import RxSwift
import Alamofire


class UrunDaoRepository {
	private let baseURL = "http://kasimadalan.pe.hu/yemekler/"
	var urunlerListesi = BehaviorSubject<[Urun]>(value: [Urun]())

	func urunleriYukle() -> Observable<[Urun]?> {
		return Observable.create { observer in
			AF.request(self.baseURL + "tumYemekleriGetir.php", method: .get).response { response in
				if let data = response.data {
					do {
						let answer = try JSONDecoder().decode(UrunlerResponse.self, from: data)
						if let list = answer.yemekler {
							observer.onNext(list)
							observer.onCompleted()
						}
					} catch {
						print(error.localizedDescription)
						observer.onError(error)
					}
				}
			}

			return Disposables.create()
		}
	}

	func arama(searchWord: String) -> Observable<[Urun]?> {
		print("Arama başlatıldı. Kelime: \(searchWord)")
		return Observable.create { observer in
			let params: Parameters = ["yemek_adi": searchWord]
			print("hello")
			AF.request(self.baseURL + "tumYemekleriGetir.php", method: .post, parameters: params).response { response in
				if let data = response.data {
					do {
						let answer = try JSONDecoder().decode(UrunlerResponse.self, from: data)
						if let list = answer.yemekler {
							print("Arama sonucu: \(list.count) ürün bulundu.")
							observer.onNext(list)
							observer.onCompleted()
						}
					} catch {
						print(error.localizedDescription)
						observer.onError(error)
					}
				}
			}

			return Disposables.create()
		}
	}
	
	
}
