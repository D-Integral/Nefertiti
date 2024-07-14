# Nefertiti
Nefertiti by Dmytro Skorokhod is an open source iOS library for making searchable PDF documents from photos. It takes an array of UIImage objects and returns a file confirming to NefertitiFileProtocol.

The usage example:

<Code>
  let pdfMaker: NefertitiPDFMakerProtocol = NefertitiSearchablePDFMaker()
  
  var pdfDocumentSavingOperation: ((any NefertitiFileProtocol) -> ())?

  func documentCameraViewController(_ controller: VNDocumentCameraViewController,
                                    didFinishWith scan: VNDocumentCameraScan) {
        var pageImages = [UIImage]()
        
        for pageIndex in 0 ..< scan.pageCount {
            pageImages.append(scan.imageOfPage(at: pageIndex))
        }
        
        pdfMaker.generatePdfDocumentFile(from: images) { [weak self] file, error in
            if let error = error {
                debugPrint(error)
                return
            }

            guard let file = file,
                  let pdfDocumentSavingOperation = self?.pdfDocumentSavingOperation else { return }
            
            pdfDocumentSavingOperation(file)
        }
    }
</Code>

The articles I recommend to read to understand the topic better:
<BR>
<A HREF=https://alexanderweiss.dev/blog/2020-11-28-from-uiimage-to-searchable-pdf-part-1>From UIImage to searchable PDF</A> by Alexander Weiß.
<BR>
<A HREF=https://www.hoboes.com/Mimsy/hacks/searchable-pdfs/>Create searchable PDFs in Swift</A> by Jerry Stratton.
