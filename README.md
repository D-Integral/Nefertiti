# Nefertiti
Nefertiti by Dmytro Skorokhod is an open source iOS library for making searchable PDF documents from photos. It takes an array of UIImage objects and returns a file confirming to NefertitiFileProtocol.

Nefertiti is available as a Swift package. To start using the library add package dependancy, then import Nefertiti and NefertitiFile into your source code file.

Here is an example of usage Nefertiti with VisionKit:

```Swift
    import Nefertiti
    import NefertitiFile

    let nefertiti: NefertitiPDFMakerProtocol = NefertitiSearchablePDFMaker()
    var pdfDocumentSavingOperation: ((any NefertitiFileProtocol) -> ())?

    extension VisionDocumentCameraManager: VNDocumentCameraViewControllerDelegate {
        func documentCameraViewController(_ controller: VNDocumentCameraViewController,
                                      didFinishWith scan: VNDocumentCameraScan) {
          var pageImages = [UIImage]()
        
          for pageIndex in 0 ..< scan.pageCount {
              pageImages.append(scan.imageOfPage(at: pageIndex))
          }
        
          nefertiti.generatePdfDocumentFile(from: images) { file, error in
              if let error = error {
                  debugPrint(error)
                  return
              }

              guard let file = file,
                    let pdfDocumentSavingOperation = pdfDocumentSavingOperation else { return }
            
              pdfDocumentSavingOperation(file)
          }
       }
    }
```

Here is an example of NefertitiFileProtocol usage:
```Swift
    import NefertitiFile
    
    var file: (any NefertitiFileProtocol)?
    
    func activityViewController(with file: (any NefertitiFileProtocol)) -> UIActivityViewController? {
        guard let pdfDocumentDataUrl = file.documentDataUrl else { return nil }
    
        let activityViewController = UIActivityViewController(activityItems: [pdfDocumentDataUrl],
                                                              applicationActivities: nil)
    
        return activityViewController
    }
```

NefertitiFileProtocol has properties <Code>documentDataUrl</Code> and <Code>thumbnailDataUrl</Code>. The first of them is a url to the whole document data and the last one is a link to a thumbnail which you may use for a small document preview.

The articles I recommend to read to understand the topic better:
<BR>
<A HREF=https://alexanderweiss.dev/blog/2020-11-28-from-uiimage-to-searchable-pdf-part-1>From UIImage to searchable PDF</A> by Alexander Weiß.
<BR>
<A HREF=https://www.hoboes.com/Mimsy/hacks/searchable-pdfs/>Create searchable PDFs in Swift</A> by Jerry Stratton.
