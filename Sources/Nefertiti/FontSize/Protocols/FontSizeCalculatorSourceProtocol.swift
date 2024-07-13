//
//  FontSizeCalculatorSourceProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

protocol FontSizeCalculatorSourceProtocol {
    var text: String { get }
    var fontSizeRange: FontSizeRange { get }
    var rectSize: CGSize { get }
    
    var currentFontSize: CGFloat { get }
    var constraintSize: CGSize { get }
    var fontSizeRangeDiff: CGFloat { get }
}
