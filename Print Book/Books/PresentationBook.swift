//
//  PresentationBook.swift
//  Print Book
//
//  Created by Fernando Florez on 5/07/21.
//

import UIKit

struct PresentationBook {
    var id: UUID
    var name: String
    var stars: Int
    var reviews: Int
    var imageUrl: String
    var isSaved: Bool
    var originalPrice: Float
    var discountPrice: Float
    var isPopular: Bool
    var color: UIColor
}
