//
//  FontSizeCalculatorProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

public protocol FontSizeCalculatorProtocol {
    func fontSizeThatFits(_ source: FontSizeCalculatorSourceProtocol) -> CGFloat
}
