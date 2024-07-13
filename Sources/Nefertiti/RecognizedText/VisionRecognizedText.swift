//
//  VisionRecognizedText.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import Vision

struct VisionRecognizedText: RecognizedTextProtocol {
    public private(set) var pageNumber: Int
    public private(set) var recognizedText: VNRecognizedText
}
