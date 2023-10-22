import Foundation
import RxSwift

class DatabaseManager {

	private var db: FMDatabase?
	
	init() {
		
		let fileManager = FileManager.default
		let hedefpath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
		let DB_URL = URL(fileURLWithPath: hedefpath).appendingPathComponent("users.sqlite3")

		if !fileManager.fileExists(atPath: DB_URL.path) {
			if let bundlePath = Bundle.main.path(forResource: "users", ofType: ".sqlite3") {
				do {
					try fileManager.copyItem(atPath: bundlePath, toPath: DB_URL.path)
				} catch {
					print("Veritabanı kopyalanırken hata oluştu: \(error.localizedDescription)")
				}
			} else {
				print("users.sqlite3 bundle içerisinde bulunamadı.")
			}
		}
		
		db = FMDatabase(path: DB_URL.path)


	}
	
	
	
	
	func isDatabaseConnected() -> Bool {
		if db?.open() == true {
			db?.close()
			return true
		} else {
			return false
		}
	}

	
	func addUser(name: String, email: String, password: String) {
		db?.open()
		

		
		if let result = db?.executeQuery("SELECT email FROM users WHERE email = ?", withArgumentsIn: [email]), result.next() {
			print("error ")
			db?.close()
			return
		}
		 
		
		do {
			try db?.executeUpdate("INSERT INTO users (name, email, password) VALUES (?, ?, ?)", values: [name, email, password])
		} catch {
			print("Kullanıcı eklenirken hata: \(error.localizedDescription)")
		}
		
		db?.close()
	}

	func getUser(email: String, password: String) -> FMResultSet? {
		db?.open()
		
		var result: FMResultSet? = nil
		do {
			result = try db?.executeQuery("SELECT * FROM users WHERE email = ? AND password = ?", values: [email, password])
			if result?.next() == false {
				result = nil
			}
		} catch {
			print("Kullanıcı getirilirken hata: \(error.localizedDescription)")
		}
		
		db?.close()
		return result
	}
}
