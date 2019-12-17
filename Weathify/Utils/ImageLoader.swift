//
//  ImageLoader.swift
//  Weathify
//
//  Created by macbook-097 on 12/10/19.
//  Copyright © 2019 Tigran Sarkisyan. All rights reserved.
//

import UIKit
import Kingfisher

class ImageLoader {
    
    static func loadImage(
        imageView: UIImageView,
        url: URL,
        placeholder: String
    ) {
        imageView.kf.setImage(
            with: url,
            placeholder: UIImage(named: placeholder)
        )
    }
    
}
