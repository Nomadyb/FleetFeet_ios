//
//  DetayVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 13.10.2023.
//

import UIKit
import Kingfisher

class DetayVC: UIViewController {

	// MARK: - UI Elements
	
	@IBOutlet weak var urunAdLabel: UILabel!
	@IBOutlet weak var urunImageView: UIImageView!
	@IBOutlet weak var puanLabel: UILabel!
	@IBOutlet weak var kcalLabel: UILabel!
	@IBOutlet weak var minLabel: UILabel!
	@IBOutlet weak var fiyatLabel: UILabel!
	@IBOutlet weak var fiyatDetayLabel: UILabel!
	@IBOutlet weak var urunAdediLabel: UILabel!
	@IBOutlet weak var sepeteEkleButton: UIButton!

	
	//var viewModel = UrunlerViewModel()
	var viewModel = SepetViewModel(kullaniciAdi: "kullanici_adi")	
	var urun: Urun?
	var urunAdedi = 1

	override func viewDidLoad() {
		super.viewDidLoad()
		
		if let fiyat = urun?.yemek_fiyat {
			fiyatDetayLabel.text = "\(fiyat) $"
		} else {
			fiyatDetayLabel.text = "Fiyat Bilgisi Yok"
		}
		
		/*
		fiyatDetayLabel.backgroundColor = UIColor(white: 1.0, alpha: 0.2) // yarı şeffaf beyaz
		fiyatDetayLabel.clipsToBounds = true
		fiyatDetayLabel.layer.cornerRadius = 25
		*/
		
		urunImageView.backgroundColor = UIColor(white: 1.0, alpha: 0.1)
		urunImageView.clipsToBounds = true
		urunImageView.layer.cornerRadius = 45
		
		
		
		
		//streambackground

		let arkaPlanGorseli = UIImage(named: "streamlast")
			let arkaPlanImageView = UIImageView(frame: self.view.bounds)
			arkaPlanImageView.image = arkaPlanGorseli
			arkaPlanImageView.contentMode = .scaleAspectFill
			self.view.addSubview(arkaPlanImageView)
			self.view.sendSubviewToBack(arkaPlanImageView)

		
		
		
		updateUI()
	}
	
	//guncelleme eklemeliyim
	func updateUI() {
		guard let urun = urun else { return }

		urunAdLabel.text = urun.yemek_adi

		if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(urun.yemek_resim_adi!)") {
			urunImageView.kf.setImage(with: url)
		}

		fiyatDetayLabel.text = "\(urun.yemek_fiyat!) $"
		urunAdediLabel.text = "\(urunAdedi)"

		// Puan ve kcal bilgilerini güncelleme
		//puanLabel.text = "\(urun.puan ?? 0)"
		//kcalLabel.text = "\(urun.kcal ?? 0) kcal"
		
		//add star
		
		// Yıldız ikonu için
		let starAttachment = NSTextAttachment()
		starAttachment.image = UIImage(named: "star")?.withRenderingMode(.alwaysOriginal)

		let starFontCapHeight = puanLabel.font.capHeight
		let yildizIconSize = CGRect(x: 0, y: (starFontCapHeight - starFontCapHeight).rounded() / 2, width: starFontCapHeight, height: starFontCapHeight)
		starAttachment.bounds = yildizIconSize

		let starAttachmentString = NSAttributedString(attachment: starAttachment)
		let starString = NSMutableAttributedString(string: "\(urun.puan ?? 0) ")
		starString.append(starAttachmentString)
		puanLabel.attributedText = starString

		// Kalori ikonu için
		let kcalAttachment = NSTextAttachment()
		kcalAttachment.image = UIImage(named: "calories")?.withRenderingMode(.alwaysOriginal)

		let kcalFontCapHeight = kcalLabel.font.capHeight
		let kcalIconSize = CGRect(x: 0, y: (kcalFontCapHeight - (kcalFontCapHeight * 2)).rounded() / 2, width: kcalFontCapHeight * 2, height: kcalFontCapHeight * 2)
		kcalAttachment.bounds = kcalIconSize

		let kcalAttachmentString = NSAttributedString(attachment: kcalAttachment)
		let kcalString = NSMutableAttributedString(string: "\(urun.kcal ?? 0) ")
		kcalString.append(kcalAttachmentString)
		kcalString.append(NSAttributedString())
		kcalLabel.attributedText = kcalString
		
		
		//delivery
		let deliveryAttachment = NSTextAttachment()
		deliveryAttachment.image = UIImage(named: "take-away")?.withRenderingMode(.alwaysOriginal)

		let deliveryFontCapHeight = minLabel.font.capHeight
		let deliveryIconSize = CGRect(x: 0, y: (deliveryFontCapHeight - deliveryFontCapHeight).rounded() / 2, width: deliveryFontCapHeight * 2 , height: deliveryFontCapHeight)
		deliveryAttachment.bounds = deliveryIconSize

		let deliveryAttachmentString = NSAttributedString(attachment: deliveryAttachment)
		let deliveryString = NSMutableAttributedString(attributedString: deliveryAttachmentString)
		deliveryString.append(NSAttributedString(string: "\(urun.delivery ?? 0) min"))

		minLabel.attributedText = deliveryString



		
		
		
		
	}

	// MARK: - Actions
	
	@IBAction func minusButtonPressed(_ sender: Any) {
		if urunAdedi > 1 {
			urunAdedi -= 1
			urunAdediLabel.text = "\(urunAdedi)"
			updatePrice()
		}
	}

	@IBAction func plusButtonPressed(_ sender: Any) {
		urunAdedi += 1
		urunAdediLabel.text = "\(urunAdedi)"
		updatePrice()
	}

	@IBAction func sepeteEkleButtonPressed(_ sender: Any) {
		print("sepeeklebutonu tıklandı")
		if let urun = urun, let priceString = urun.yemek_fiyat, let price = Int(priceString) {
				let totalPrice = urunAdedi * price
				viewModel.sepeteEkle(yemek_adi: urun.yemek_adi!, yemek_resim_adi: urun.yemek_resim_adi!, yemek_fiyat: totalPrice, yemek_siparis_adet: urunAdedi)
				self.tabBarController?.selectedIndex = 1
			}
		
		
	}

	func updatePrice() {
		if let priceString = urun?.yemek_fiyat, let price = Double(priceString) {
			let totalPrice = Double(urunAdedi) * price
			fiyatDetayLabel.text = "\(totalPrice) $"
		}
	}
}
