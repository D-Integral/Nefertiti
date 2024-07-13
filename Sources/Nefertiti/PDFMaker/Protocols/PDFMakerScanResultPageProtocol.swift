//
//  PDFMakerScanResultPageProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit

protocol PDFMakerScanResultPageProtocol {
    var recognizedTexts: [RecognizedTextProtocol] { get }
    var sourcePage: PDFMakerSourcePageProtocol { get }
}
