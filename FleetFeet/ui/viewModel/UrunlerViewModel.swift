//
//  UrunlerViewModel.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 18.10.2023.
//
import Foundation
import RxSwift
import UIKit

class UrunlerViewModel {
	var urunRepo = UrunDaoRepository()
	var urunlerListesi = BehaviorSubject<[Urun]>(value: [Urun]())
	private let disposeBag = DisposeBag()

	init() {
		urunleriYukle()
	}
	
	
	let yemekBilgisi: [String: (puan: Int, kcal: Int, delivery: Int, description: String)] = [
		"Ayran": (puan: 5, kcal: 100, delivery: 30, description: "Türk mutfağının vazgeçilmezi, ferahlatıcı bir içecek olan Ayran, yoğurtla suyun karıştırılmasıyla hazırlanır."),
		"Baklava": (puan: 4, kcal: 500, delivery: 30, description: "Kat kat yufka, fındık ve cevizle buluşarak ortaya mükemmel bir tatlı çıkarır. Şerbetiyle lezzeti ikiye katlanır."),
		"Fanta": (puan: 4, kcal: 897, delivery: 30, description: "Tatlı portakalın asidik ferahlatıcılığını içinde barındıran Fanta, sıcak yaz günlerinin kurtarıcısıdır."),
		"Izgara Somon": (puan: 5, kcal: 500, delivery: 30, description: "Denizin taptaze somonları, ızgarada altın sarısına dönüşerek enfes bir lezzet sunar."),
		"Izgara Tavuk": (puan: 5, kcal: 180, delivery: 30, description: "Marine edilmiş tavuk, ızgarada mükemmel bir aroma ile buluşarak damağınızda iz bırakır."),
		"Kadayıf": (puan: 4, kcal: 267, delivery: 30, description: "İnce tel kadayıfın, tatlı şerbet ve dövülmüş cevizle buluşmasıyla meydana gelen tatlı krallığı."),
		"Kahve": (puan: 3, kcal: 247, delivery: 30, description: "Sıcak ya da soğuk, kahve her haliyle güne enerji katar. Günün her saatinde tüketebileceğiniz bir keyif."),
		"Köfte": (puan: 5, kcal: 255, delivery: 30, description: "Baharatlarla zenginleşen kıyma, ızgarada ya da tavada pişirilerek masalara gelen mükemmel bir ana yemektir."),
		"Lazanya": (puan: 4, kcal: 1000, delivery: 30, description: "İtalyan mutfağının sevilen yemeği, kat kat hamur arasına saklanan malzemeleriyle büyüleyici bir lezzete sahip."),
		"Makarna": (puan: 4, kcal: 555, delivery: 30, description: "Farklı soslarla zenginleşen makarna, hızlı ve doyurucu bir öğün seçeneğidir."),
		"Pizza": (puan: 5, kcal: 526, delivery: 30, description: "İnce hamurun üzerine serilen malzemelerle hazırlanan pizza, herkesin favori yemeği olmuştur."),
		"Su": (puan: 3, kcal: 123, delivery: 30, description: "Hayatın kaynağı, vücudumuz için en gerekli sıvı. Her an yanınızda olması gereken bir içecek."),
		"Sütlaç": (puan: 5, kcal: 643, delivery: 30, description: "Süt, pirinç ve şekerin mükemmel birleşimiyle ortaya çıkan bu tatlı, serinletici bir lezzete sahip."),
		"Tiramisu": (puan: 4, kcal: 732, delivery: 30, description: "Kahve aroması, krema ve kakaonun buluşmasıyla oluşan İtalyan tatlısı, hafifliğiyle bilinir.")
	]
	
	func urunleriYukle() {
		urunRepo.urunleriYukle()
			.subscribe(onNext: { [weak self] urunler in
				if let fetchedUrunler = urunler {
					fetchedUrunler.forEach { urun in
						if let details = self?.yemekBilgisi[urun.yemek_adi ?? ""] {
							urun.puan = details.puan
							urun.kcal = details.kcal
							urun.delivery = details.delivery
							urun.description = details.description
						}
					}
					self?.urunlerListesi.onNext(fetchedUrunler)
				}
			}, onError: { error in
				print("Error loading products: \(error)")
			})
			.disposed(by: disposeBag)
	}
	
	
	
		func arama(kelime: String) {
			urunRepo.arama(searchWord: kelime)
				.subscribe(onNext: { [weak self] urunler in
					if let urunler = urunler {
						self?.urunlerListesi.onNext(urunler)
					}
				}, onError: { error in
					print("Error during the search: \(error)")
				})
				.disposed(by: disposeBag)
		}
	}
