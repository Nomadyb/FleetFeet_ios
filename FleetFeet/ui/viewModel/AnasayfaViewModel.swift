//
//  AnasayfaViewModel.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 18.10.2023.
//

import Foundation
import RxSwift

class AnasayfaViewModel {
	var urunRepo = UrunDaoRepository()
	var urunlerListesi = BehaviorSubject<[Urun]>(value: [Urun]())
	private var disposeBag = DisposeBag()

	init() {
		bindUrunListesi()
		urunleriYukle()
	}
	
	func bindUrunListesi() {
		urunRepo.urunlerListesi
			.observeOn(MainScheduler.instance)
			.subscribe(onNext: { [weak self] urunler in
				self?.urunlerListesi.onNext(urunler)
			}).disposed(by: disposeBag)
	}
	
	func urunleriYukle() {
		urunRepo.urunleriYukle()
	}
	
	func arama(kelime: String) {
		print("ViewModel içinde arama fonksiyonu çalıştırıldı. Aranan kelime: \(kelime)")
		 urunRepo.arama(searchWord: kelime)
	}
	
}
