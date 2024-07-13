//
//  PDFMakerProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit
import NefertitiFile

public protocol NefertitiPDFMakerProtocol {
    var fontSizeCalculator: FontSizeCalculatorProtocol { get }
    
    func generatePdfDocumentFile(from documentImages: [UIImage],
                                 completionHandler: @escaping ((any NefertitiFileProtocol)?, Error?) -> ()) -> ()?
}
