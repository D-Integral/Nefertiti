//
//  FontSizeCalculatorSource.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

struct FontSizeCalculatorSource: FontSizeCalculatorSourceProtocol {
    public var text: String
    public var fontSizeRange: FontSizeRange
    public var rectSize: CGSize
    public var currentFontSize: CGFloat
    
    public var constraintSize: CGSize {
        return CGSize(width: CGFloat.greatestFiniteMagnitude,
                      height: rectSize.height)
    }
    
    public var fontSizeRangeDiff: CGFloat {
        return fontSizeRange.diff
    }
    
    init(text: String,
         fontSizeRange: FontSizeRange = FontSizeRange(),
         rectSize: CGSize) {
        self.text = text
        self.fontSizeRange = fontSizeRange
        self.rectSize = rectSize
        self.currentFontSize = (fontSizeRange.minFontSize + fontSizeRange.maxFontSize) / 2
    }
}
