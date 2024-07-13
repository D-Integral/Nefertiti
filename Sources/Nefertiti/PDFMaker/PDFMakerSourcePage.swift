//
//  PDFMakerSourcePage.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit

struct PDFMakerSourcePage: PDFMakerSourcePageProtocol {
    public private(set) var image: UIImage
    public private(set) var pageNumber: Int
}
