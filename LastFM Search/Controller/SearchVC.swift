//
//  SearchVC.swift
//  LastFM Search
//
//  Created by Tony Merritt on 13/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import UIKit
import SDWebImage

var choiceSearch: String!
var artistSearch: String!
var albumSearch: String!


class SearchVC: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
	
	@IBOutlet weak var tableView: UITableView!
	@IBOutlet weak var searchBar: UISearchBar!	
	@IBOutlet weak var noSearchedText: UILabel!
	@IBOutlet weak var greyLoaderView: UIView!	
	@IBOutlet weak var activitySpinner: UIActivityIndicatorView!
	
	var keysArray = [String]()
	var imageURL: String?
	var imageToPass: UIImage!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		tableView.delegate = self
		tableView.dataSource = self
		searchBar.delegate = self
		tableView.tableFooterView = UIView()
		
		// I added this becuase in future I may want to impliment choice between Album and Artist
		choiceSearch = "album"
		
		
		//
		//		getData(completion: { (complete) in
		//			DispatchQueue.main.async {
		//				self.tableView.reloadData()
		//			}
		//		})
	}
	
	
	func getData(completion: @escaping (_ finished: Bool) -> ()) {
		AlbumDataService().getAlbumData(completion: { (complete) in
			completion(true)
			
		})
	}
	
	func getDataFull(completion: @escaping (_ finished: Bool) -> ()) {
		AlbumDataService().getAlbumDataFull(completion: { (complete) in
			print(ALBUM_ADDRESS)
			completion(true)
		})
	}
	
	func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
		albumSearch = searchBar.text
		greyLoaderView.isHidden = false
		activitySpinner.startAnimating()
		albumInfo = []
		searchBar.text = ""
		SEARCH_RESULTS_ADDRESS = "\(BASE_URL)\(choiceSearch!).search&\(choiceSearch!)=\(albumSearch!)&api_key=\(API_KEY)&format=json"
		getData(completion: { (complete) in
			DispatchQueue.main.async {
				self.tableView.reloadData()
				self.activitySpinner.startAnimating()
				self.greyLoaderView.isHidden = true

				print("Tony: Finished editing \(albumSearch!)")
			}
		})
	}
	
	func numberOfSections(in tableView: UITableView) -> Int {
		return 1
	}
	
	func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		let albumAmount = albumInfo.count
		if albumAmount != 0 {
			noSearchedText.isHidden = true
			return albumAmount
		}else {
			noSearchedText.isHidden = false
			return 0
		}
	}
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		
		let selectedCell:UITableViewCell = tableView.cellForRow(at: indexPath)!
		selectedCell.contentView.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
		
		let cell = tableView.cellForRow(at: indexPath) as! searchCell
		
		albumSearch = cell.albumLabel.text
		artistSearch = cell.artistLabel.text
		imageToPass = cell.imageThumb.image
		
		
		ALBUM_ADDRESS = "\(BASE_URL)\(choiceSearch!).getinfo&api_key=\(API_KEY)&artist=\(artistSearch!)&album=\(albumSearch!)&format=json".replacingOccurrences(of: " ", with: "%20")
		
		self.performSegue(withIdentifier: "toAlbum", sender: nil)
		
		tableView.deselectRow(at: indexPath, animated: true)
	}
	
	
	override func prepare(for segue: UIStoryboardSegue, sender: Any?)
	{
		let vc = segue.destination as? AlbumVC
		vc?.imagePassed = imageToPass
	}
	
	
	func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
		return "Albums"
	}
	
	func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		if let cell = tableView.dequeueReusableCell(withIdentifier: "searchCell", for: indexPath) as? searchCell {
			
			let news = albumInfo[indexPath.row]
			let imageDict = news["imgUrl"] as? [Images]
			imageURL = imageDict?.last?.text
			
			if imageURL == "" || imageURL == nil {
				cell.imageThumb.image = #imageLiteral(resourceName: "NoAlbumImage")
			}else {
				cell.imageThumb.sd_setImage(with: URL(string: "\(imageURL!)"))
			}
			
			cell.artistLabel?.text = news["artist"] as? String
			cell.albumLabel?.text = news["name"] as? String
			
			return cell
		}else {
			return UITableViewCell()
		}
	}
}
