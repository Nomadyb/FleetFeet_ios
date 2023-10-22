//
//  SepetVC.swift
//  FleetFeet
//
//  Created by Ahmet Emin Yalçınkaya on 20.10.2023.
//

import UIKit
import Kingfisher
import RxSwift

class SepetVC: UIViewController {
	
	private let disposeBag = DisposeBag()
	
	@IBOutlet weak var sepetTableView: UITableView!
	
	var viewModel = SepetViewModel(kullaniciAdi: "ahmet_yalcinkaya")
	var sepetList = [Sepet]()
		
		override func viewDidLoad() {
			super.viewDidLoad()
			
			
			
			
			sepetTableView.delegate = self
			sepetTableView.dataSource = self
			
			sepetTableView.separatorColor = UIColor(white: 0.96, alpha: 1)
			
			_ = viewModel.sepetUrunler.subscribe(onNext: { list in
				print("Gelen Sepet Ürün Sayısı: \(list.count)")
				self.sepetList = list
				DispatchQueue.main.async {
					self.sepetTableView.reloadData()
				}
			}).disposed(by: disposeBag)
		}
		
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		viewModel.sepetiYukle()
		print("sepetiYukle metodu çağrıldı.")
	}

	}

	extension SepetVC: UITableViewDelegate, UITableViewDataSource {
		
		func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
			print("TableView satır sayısı: \(sepetList.count)")
			return sepetList.count
		}

		
		func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
			print("\(indexPath.row). hücre oluşturuldu.")
			let sepetItem = sepetList[indexPath.row]
			let cell = tableView.dequeueReusableCell(withIdentifier: "SepetHucre") as! SepetHucre // Celle isimlerini uygun hale getirin.
			cell.urunSayisiLabel.text = sepetItem.yemek_siparis_adet
			cell.yemekAdiLabel.text = sepetItem.yemek_adi
			cell.yemekFiyatiLabel.text = sepetItem.yemek_fiyat
			
			if let url = URL(string: "http://kasimadalan.pe.hu/yemekler/resimler/\(sepetItem.yemek_resim_adi!)") {
				DispatchQueue.main.async {
					cell.imageViewSepet.kf.setImage(with: url)
				}
			}
			
			cell.backgroundColor = UIColor(white: 0.95, alpha: 1)
			cell.HucreView.layer.cornerRadius = 10.0 // isimleri uygula
			cell.selectionStyle = .none
			return cell
		}
		

		
		func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
			let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { contextualAction, view, bool in
				let product = self.sepetList[indexPath.row]
				
				let alert = UIAlertController(title: "Delete", message: "\(product.yemek_adi!) should it be deleted", preferredStyle: UIAlertController.Style.alert)
				
				let cancelAction = UIAlertAction(title: "cancel", style: .cancel)
				alert.addAction(cancelAction)
				
				let yesAction = UIAlertAction(title: "Yes", style: UIAlertAction.Style.destructive) { action in
					self.viewModel.sil(sepet_yemek_id: Int(product.sepet_yemek_id!)!)
				}
				alert.addAction(yesAction)
				self.present(alert, animated: true)
			}
			return UISwipeActionsConfiguration(actions: [deleteAction])
		}
	}
