//
//  AlbumDataService.swift
//  LastFM Search
//
//  Created by Tony Merritt on 16/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import UIKit


var albumInfo = [[String: Any]]()
var albumDesc: String!
var albumPlays: String!
var albumUrl: String!

class AlbumDataService {
	
	static let instance = AlbumDataService()
	

	var albumFull = [String:Any]()
	
	
	// This function is for the search screen.
	func getAlbumData(completion: @escaping (_ finished: Bool) -> ()) {
		guard let url = URL(string: SEARCH_RESULTS_ADDRESS) else { return }
		
		URLSession.shared.dataTask(with: url) { (data, response, err) in
			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				let albumDataFull = try decoder.decode(Root.self, from: data)
				albumInfo = []
				for item in albumDataFull.results.albummatches.album {
					let artist = item.artist!
					let name = item.name!
					let imgUrl = item.image
					
					let albumInd = ["name":name, "artist":artist, "url":url, "imgUrl":imgUrl] as [String : Any]
					
					albumInfo.append(albumInd)
				}
				completion(true)
			}catch let jsonErr {
				print("Error seroalizing json", jsonErr)
			}
			}.resume()
	}
	
	// This function is to get the album data for the selected album.
	func getAlbumDataFull(completion: @escaping (_ finished: Bool) -> ()) {
		print("Tony 1")
		print(ALBUM_ADDRESS)
		guard let url = URL(string: ALBUM_ADDRESS) else { return }
		print("Tony 2")
		URLSession.shared.dataTask(with: url) { (data, response, err) in
			guard let data = data else { return }
			do {
				let decoder = JSONDecoder()
				let albumDataMain = try decoder.decode(AlbumMain.self, from: data)
				print("Tony 3")
				albumPlays = albumDataMain.album.playcount
				albumDesc = albumDataMain.album.wiki?.summary
				albumUrl = albumDataMain.album.url
				
				completion(true)
			}catch let jsonErr {
				print("Error seroalizing json", jsonErr)
			}
			}.resume()
	}
}
