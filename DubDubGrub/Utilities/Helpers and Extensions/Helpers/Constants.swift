//
//  Constants.swift
//  DubDubGrub
//
//  Created by River McCaine on 6/28/22.
//

import UIKit

enum RecordType {
    
    static let location = "DDGLocation"
    static let profile  = "DDGProfile"
}

enum PlaceholderImage {

    static let avatar = UIImage(named: "default-avatar")!
    static let square = UIImage(named: "default-square-asset")!
    static let banner = UIImage(named: "default-banner-asset")!

}

enum ImageDimension {
    
    case square, banner
    
    var placeholderImage: UIImage {
        switch self {
        case .square:
            return PlaceholderImage.square
        case .banner:
            return PlaceholderImage.banner
        }
    }
    
}
//    static func getPlaceholder(for dimension: ImageDimension) -> UIImage {
//
//        switch dimension {
//        case .square:
//            return PlaceholderImage.square
//        case .banner:
//            return PlaceholderImage.banner
//        }
//    }
