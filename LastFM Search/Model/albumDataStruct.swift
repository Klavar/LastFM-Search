//
//  albumDataStruct.swift
//  LastFM Search
//
//  Created by Tony Merritt on 17/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import Foundation

struct Root: Decodable {
	let results: AlbumMatches
}

struct AlbumMatches: Decodable {
	let albummatches: Albums
}

struct Albums: Decodable {
	let album: [AlbumInfo]
}

struct AlbumInfo: Decodable {
	let name: String?
	let artist: String?
	let url: URL?
	let image: [Images]
}

struct Images: Decodable {
	let text: String
	let size: String
	
	enum CodingKeys: String, CodingKey {
		case text = "#text", size
	}
}
	
struct AlbumMain: Decodable {
	let album: AlbumFull
	}
	
struct AlbumFull: Decodable {
	let wiki: Wiki?
	let playcount: String
	let url: String
	}

struct Wiki: Decodable {
	let summary: String
}


