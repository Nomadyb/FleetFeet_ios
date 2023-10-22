//
//  AnasayfaVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 15.10.2023.
//
import UIKit
import RxSwift
import Kingfisher

class AnasayfaVC: UIViewController {

	// MARK: - UI Elements
	@IBOutlet weak var urunlerCollectionView: UICollectionView!
	@IBOutlet weak var aramaCubugu: UISearchBar!

	
	private var gradientLayer: CAGradientLayer!
	
	
	
	
	
	func setupGradient() {
		
			let backgroundImage = UIImage(named: "stream")
			let backgroundImageView = UIImageView(frame: urunlerCollectionView.bounds)
			backgroundImageView.image = backgroundImage
			backgroundImageView.contentMode = .scaleAspectFill
			
			urunlerCollectionView.backgroundView = UIView()
			urunlerCollectionView.backgroundView?.insertSubview(backgroundImageView, at: 0)
			

			let gradientLayer = CAGradientLayer()
			gradientLayer.frame = urunlerCollectionView.bounds
			gradientLayer.colors = [
				//UIColor.yellow.cgColor,
				UIColor.white.withAlphaComponent(0.2).cgColor,
				UIColor.gray.withAlphaComponent(0.2).cgColor,
				UIColor.black.withAlphaComponent(0.2).cgColor
			]
			gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
			gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
			
			urunlerCollectionView.backgroundView?.layer.addSublayer(gradientLayer)
	}

	
	
	var urunlerListesi: [Urun] = []
	private let disposeBag = DisposeBag()
	private var viewModel = UrunlerViewModel()
	
	
	var tumUrunler: [Urun] = []

	
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		setupGradient()
		searchController.searchBar.delegate = self

		aramaCubugu.delegate = self
		urunlerCollectionView.delegate = self
		urunlerCollectionView.dataSource = self
		
		viewModel.urunleriYukle()
		
		// Görünüm özellikleri
		let style = UICollectionViewFlowLayout()
		style.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
		style.minimumInteritemSpacing = 10
		style.minimumLineSpacing = 10
		let viewWidth = UIScreen.main.bounds.width
		let itemWidth = (viewWidth - 30) / 2
		style.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.6)
		urunlerCollectionView.collectionViewLayout = style
		
		
		let arkaPlanGorseli = UIImage(named: "stream")
			let arkaPlanImageView = UIImageView(frame: self.view.bounds)
			arkaPlanImageView.image = arkaPlanGorseli
			arkaPlanImageView.contentMode = .scaleAspectFill
			self.view.addSubview(arkaPlanImageView)
			self.view.sendSubviewToBack(arkaPlanImageView)
		


		viewModel.urunlerListesi.subscribe(onNext: { [weak self] urunler in
				   self?.tumUrunler = urunler
				   self?.urunlerListesi = urunler
				   self?.urunlerCollectionView.reloadData()
			   }).disposed(by: disposeBag)
	}
	
	private let searchController: UISearchController = {
			let controller = UISearchController(searchResultsController: nil)
			controller.obscuresBackgroundDuringPresentation = false
			controller.searchBar.placeholder = "Write what you are looking for"
			controller.searchBar.searchBarStyle = .minimal
			return controller
		}()
	
	
	func filtreleVeListele(yemekler: [Urun], arananKelime: String) -> [Urun] {
		return yemekler.filter { $0.yemek_adi?.lowercased().contains(arananKelime.lowercased()) ?? false }
	}

	
}

extension AnasayfaVC: UICollectionViewDelegate, UICollectionViewDataSource, UrunlerHucreProtokol {
	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return urunlerListesi.count
	}
	
	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		
		let urun = urunlerListesi[indexPath.row]
		let hucre = collectionView.dequeueReusableCell(withReuseIdentifier: "UrunlerHucre", for: indexPath) as! UrunlerHucre
		
		if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(urun.yemek_resim_adi!)") {
			hucre.resimView.kf.setImage(with: url)
		}

		hucre.fiyatEtiketi.text = "\(urun.yemek_fiyat!) $"
		
		hucre.layer.borderColor = UIColor.lightGray.cgColor
		hucre.layer.borderWidth = 0.5
		hucre.layer.cornerRadius = 12.0
		hucre.configure(with: urun)
		hucre.hucreProtokolu = self
		hucre.indexPath = indexPath
		
		return hucre
	}
	
	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let urun = urunlerListesi[indexPath.row]
		print("\(urun.yemek_adi!) tıklandı!")
		performSegue(withIdentifier: "goToDetailSegue", sender: urun)
	}

	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		if segue.identifier == "goToDetailSegue" {
			let detayVC = segue.destination as! DetayVC
			if let secilenUrun = sender as? Urun {
				detayVC.urun = secilenUrun
			}
		}
	}

	func eklemeButonuTiklandi(indexPath: IndexPath) {

		
		
		
	}
}


/*
extension AnasayfaVC: UISearchBarDelegate {

	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print("Arama metni: \(searchText)")
		if !searchText.isEmpty {
			viewModel.arama(kelime: searchText)
		} else {
			viewModel.urunleriYukle()
		}
	}
	
	
	
	
}
*/





extension AnasayfaVC: UISearchBarDelegate {
	func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
		print("çalıştı")
		if !searchText.isEmpty {
			urunlerListesi = filtreleVeListele(yemekler: tumUrunler, arananKelime: searchText)
		} else {
			
			urunlerListesi = tumUrunler
		}
		urunlerCollectionView.reloadData()
	}
}

