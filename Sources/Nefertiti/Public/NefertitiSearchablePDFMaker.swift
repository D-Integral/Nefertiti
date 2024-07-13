//
//  Nefertiti.swift
//  PDFReaderApp
//
//  Created by Dmytro Skorokhod on 13/01/2024.
//

import Foundation
import UIKit
import Vision
import NefertitiFile

public class NefertitiSearchablePDFMaker: NefertitiPDFMakerProtocol {
    public var fontSizeCalculator: FontSizeCalculatorProtocol
    
    public init() {
        self.fontSizeCalculator = FontSizeCalculator()
    }
    
    public func generatePdfDocumentFile(from documentImages: [UIImage],
                                        completionHandler: @escaping ((any NefertitiFileProtocol)?, Error?) -> ()) -> ()? {
        DispatchQueue.global(qos: .userInitiated).async { [weak self] in
            let dispatchGroup = DispatchGroup()
            var scanResults = [PDFMakerScanResultPage]()
            
            for (index, documentImage) in documentImages.enumerated() {
                dispatchGroup.enter()
                let sourcePage = PDFMakerSourcePage(image: documentImage,
                                                    pageNumber: index)
                
                self?.recognizeText(from: sourcePage) { recognizedTexts, error  in
                    if let error = error {
                        print(error)
                        dispatchGroup.leave()
                        return
                    }
                    
                    guard let recognizedTexts = recognizedTexts else {
                        dispatchGroup.leave()
                        return
                    }
                    
                    scanResults.append(PDFMakerScanResultPage(sourcePage: sourcePage,
                                                              recognizedTexts: recognizedTexts))
                    
                    dispatchGroup.leave()
                }
            }
            
            dispatchGroup.wait()
            
            let sortedScanResults = scanResults.sorted { left, right in
                left.sourcePage.pageNumber < right.sourcePage.pageNumber
            }
            
            let data = UIGraphicsPDFRenderer().pdfData { [weak self] context in
                for scanResult in sortedScanResults {
                    self?.fillPdfDocumentLayers(with: scanResult,
                                                on: context)
                }
            }
            
            let currentDate = Date()
            
            let thumbnailData = documentImages.count > 0 ? documentImages[0].pngData() : nil
            
            let file = NefertitiFile(title: "Scan \(currentDate)",
                                     documentData: data,
                                     thumbnailData: thumbnailData,
                                     createdDate: currentDate,
                                     modifiedDate: currentDate)
            
            DispatchQueue.main.async {
                completionHandler(file, nil)
            }
        }
    }
    
    private func recognizeText(from sourcePage: PDFMakerSourcePageProtocol,
                               completionHandler: @escaping ([RecognizedTextProtocol]?, Error?) -> ()) {
        guard let cgImage = sourcePage.image.cgImage else {
            completionHandler(nil,
                              PDFMakerError.canNotTransformUIImageIntoCGImage)
            return
        }
        
        var recognizedTexts: [RecognizedTextProtocol] = []
        
        let recognizeTextRequest = recognizeTextRequest(for: sourcePage.pageNumber) { recognizedText, error in
            guard let recognizedText = recognizedText else { return }
            
            if let error = error {
                print(error)
                return
            }
            
            recognizedTexts.append(recognizedText)
        }
        
        let requestHandler = VNImageRequestHandler(cgImage: cgImage,
                                                   options: [:])
        
        do {
            try requestHandler.perform([recognizeTextRequest])
        } catch {
            completionHandler(nil, error)
            return
        }
         
        completionHandler(recognizedTexts, nil)
    }
    
    private func recognizeTextRequest(for pageNumber: Int,
                                      completionHandler: @escaping (RecognizedTextProtocol?, Error?) -> ()) -> VNRecognizeTextRequest {
        let request = VNRecognizeTextRequest { request, error in
            guard error == nil else {
                completionHandler(nil, error)
                
                return
            }
            
            guard let observations = request.results as? [VNRecognizedTextObservation] else { return }
            
            let maximumRecognitionCandidates = 1
            
            for observation in observations {
                guard let topCandidate = observation.topCandidates(maximumRecognitionCandidates).first else { continue }
                
                let recognizedText = VisionRecognizedText(pageNumber: pageNumber,
                                                          recognizedText: topCandidate)
                
                completionHandler(recognizedText, nil)
            }
        }
        
        request.recognitionLevel = .accurate
        
        return request
    }
    
    func pdfPageSize(for sourcePage: PDFMakerSourcePageProtocol) -> CGRect {
        let pageWidth = sourcePage.image.size.width
        let pageHeight = sourcePage.image.size.height
        
        return CGRect(x: 0,
                      y: 0,
                      width: pageWidth,
                      height: pageHeight)
    }
    
    private func fillPdfDocumentLayers(with scanResult: PDFMakerScanResultPage,
                                       on context: UIGraphicsPDFRendererContext) {
        let pageRect = self.pdfPageSize(for: scanResult.sourcePage)
        
        context.beginPage(withBounds: pageRect,
                          pageInfo: [:])
        
        scanResult.recognizedTexts.forEach { recognizedText in
            if let recognizedText = recognizedText as? VisionRecognizedText {
                self.fillTextLayer(with: recognizedText.recognizedText, in: pageRect)
            }
        }
        
        self.fillImageLayer(with: scanResult.sourcePage.image,
                            in: pageRect)
    }
    
    private func fillTextLayer(with recognizedText: VNRecognizedText,
                               in rect: CGRect) {
        let text = recognizedText.string
        let pageWidth = rect.size.width
        let pageHeight = rect.size.height
        
        let start = text.index(text.startIndex, offsetBy: 0)
        let end = text.index(text.endIndex, offsetBy: 0)
        
        guard let boundingBox = try? recognizedText.boundingBox(for: start..<end) else {
            return
        }
        
        let transform = CGAffineTransform(scaleX: 1, y: -1).translatedBy(x: 0, y: -pageHeight)
        let transformedRect: CGRect = VNImageRectForNormalizedRect(boundingBox.boundingBox,
                                                                   Int(pageWidth),
                                                                   Int(pageHeight)).applying(transform)
        let fontSize = fontSizeCalculator.fontSizeThatFits(FontSizeCalculatorSource(text: text,
                                                                                    rectSize: transformedRect.size))
        let font = UIFont.systemFont(ofSize: fontSize)
        
        let attributedString = NSAttributedString(string: text,
                                                  attributes:  [NSAttributedString.Key.font: font])
        
        attributedString.draw(in: transformedRect)
    }
    
    private func fillImageLayer(with image: UIImage,
                                in rect: CGRect) {
        image.draw(in: rect)
    }
}
