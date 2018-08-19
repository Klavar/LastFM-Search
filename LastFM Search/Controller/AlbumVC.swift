//
//  AlbumVC.swift
//  LastFM Search
//
//  Created by Tony Merritt on 19/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import UIKit
import SDWebImage

class AlbumVC: UIViewController {
	
	@IBOutlet weak var artistLabel: UILabel!
	@IBOutlet weak var albumLabel: UILabel!
	
	@IBOutlet weak var descriptionLabel: UITextView!
	@IBOutlet weak var playsLabel: UILabel!
	@IBOutlet weak var albumImage: UIImageView!
	
	var imagePassed: UIImage!
	
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		getDataFull(completion: { (complete) in
			DispatchQueue.main.async {
				
				self.artistLabel.text = artistSearch
				self.albumLabel.text = albumSearch
				self.descriptionLabel.text = albumDesc
				self.albumImage.image = self.imagePassed
				if let plays = albumPlays {
					self.playsLabel.text = "Album Plays: \(plays)"
				}
			}
		})
	}
	
	func getDataFull(completion: @escaping (_ finished: Bool) -> ()) {
		AlbumDataService().getAlbumDataFull(completion: { (complete) in
			print(ALBUM_ADDRESS)
			completion(true)
		})
	}
	
	
	@IBAction func onClosePressed(_ sender: Any) {
		dismiss(animated: true, completion: nil)
	}
	
	@IBAction func onGoToPressed(_ sender: Any) {
		if let url = URL(string: "\(albumUrl!)"),
			UIApplication.shared.canOpenURL(url) {
			UIApplication.shared.open(url, options: [:])
		}
	}
}
