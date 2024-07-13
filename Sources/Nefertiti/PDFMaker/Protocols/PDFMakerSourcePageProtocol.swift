//
//  PDFMakerSourcePageProtocol.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit

protocol PDFMakerSourcePageProtocol {
    var image: UIImage { get }
    var pageNumber: Int { get }
}
