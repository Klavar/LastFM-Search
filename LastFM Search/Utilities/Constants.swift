//
//  Constants.swift
//  LastFM Search
//
//  Created by Tony Merritt on 14/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import Foundation

typealias CompletionHandler = (_ Success: Bool) -> ()



let BASE_URL = "http://ws.audioscrobbler.com/2.0/?method="
let API_KEY = "4181786ee2f5b6c868b39dcce4a1cc54"

var SEARCH_RESULTS_ADDRESS = "\(BASE_URL)\(choiceSearch!).search&\(choiceSearch!)=\(albumSearch)&api_key=\(API_KEY)&format=json".replacingOccurrences(of: " ", with: "%20")

var ALBUM_ADDRESS = "\(BASE_URL)\(choiceSearch!).getinfo&api_key=\(API_KEY)&artist=\(artistSearch!)&album=\(albumSearch!)&format=json".replacingOccurrences(of: " ", with: "%20")




