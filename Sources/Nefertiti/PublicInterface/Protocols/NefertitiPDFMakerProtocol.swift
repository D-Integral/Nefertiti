//
//  PDFMakerProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit
import NefertitiFile
import NefertitiFontSizeCalculator

public protocol NefertitiPDFMakerProtocol {
    var fontSizeCalculator: NefertitiFontSizeCalculatorProtocol { get }
    var textRecognitionNeeded: Bool { get set }
    
    func generatePdfDocumentFile(from documentImages: [UIImage],
                                 completionHandler: @escaping ((any NefertitiFileProtocol)?, Error?) -> ()) -> ()?
}
