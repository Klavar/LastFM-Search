//
//  searchCell.swift
//  LastFM Search
//
//  Created by Tony Merritt on 15/08/2018.
//  Copyright © 2018 Tony Merritt. All rights reserved.
//

import UIKit


class searchCell: UITableViewCell {
	
	@IBOutlet weak var imageThumb: UIImageView!	
	@IBOutlet weak var artistLabel: UILabel!
	@IBOutlet weak var albumLabel: UILabel!
	
	
	var albumData = albumInfo
		
	override func awakeFromNib() {
		super.awakeFromNib()
	}
}
