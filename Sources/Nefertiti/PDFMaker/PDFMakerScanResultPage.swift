//
//  PDFMakerScanResultPage.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit

struct PDFMakerScanResultPage: PDFMakerScanResultPageProtocol {
    var sourcePage: PDFMakerSourcePageProtocol
    var recognizedTexts: [RecognizedTextProtocol]
}
