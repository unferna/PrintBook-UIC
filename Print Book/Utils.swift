//
//  Utils.swift
//  Print Book
//
//  Created by Fernando Florez on 7/07/21.
//

import SwiftUI

enum AppFont: String {
    case loraRegular = "Lora-Regular"
    case loraMedium = "Lora-Medium"
    case loraSemiBold = "Lora-SemiBold"
    case loraBold = "Lora-Bold"
    
    case openSansRegular = "OpenSans-Regular"
    case openSansSemiBold = "OpenSans-SemiBold"
    case openSansBold = "OpenSans-Bold"
}

class Utils {
    static func font(_ fontName: AppFont, size: CGFloat) -> Font {
        return Font.custom(fontName.rawValue, size: size)
    }
}
