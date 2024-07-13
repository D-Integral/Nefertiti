//
//  FontSizeRange.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation

struct FontSizeRange: FontSizeRangeProtocol {
    
    // MARK: - Public Interface
    
    public private(set) var minFontSize: CGFloat
    public private(set) var maxFontSize: CGFloat
    
    public var diff: CGFloat {
        return maxFontSize - minFontSize
    }
    
    init(minFontSize: CGFloat? = nil,
         maxFontSize: CGFloat? = nil,
         minFontScale: CGFloat = Constants.defaultMinFontScale) {
        if let maxFontSize = maxFontSize {
            self.maxFontSize = maxFontSize.isNaN ? Constants.defaultMaxFontSize : maxFontSize
        } else {
            self.maxFontSize = Constants.defaultMaxFontSize
        }
        
        let reliableMinFontScale = minFontScale.isNaN ? Constants.defaultMinFontScale : minFontScale
        let defaultMinFontSize = self.maxFontSize * reliableMinFontScale
        
        if let minFontSize = minFontSize {
            self.minFontSize = minFontSize.isNaN ? defaultMinFontSize : minFontSize
        } else {
            self.minFontSize = defaultMinFontSize
        }
    }
    
    // MARK: - Private Definitions
    
    private struct Constants {
        static let defaultMaxFontSize = 100.0
        static let defaultMinFontScale = 0.1
        static let minFontSizeNotProvided = -1.0
    }
}
