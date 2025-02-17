import SwiftUI
import QuickLook
import Foundation
import Combine




class DownloadManager: ObservableObject {
    @Published var downloadProgress: Double = 0.0
    @Published var downloadURL: URL?
    @Published var downloadError: Error?
    @Published var isDownloading: Bool = false
    
    func downloadFile(from url: URL) {
        isDownloading = true
        downloadError = nil
        
        downloadFile(from: url) { result in
            DispatchQueue.main.async {
                self.isDownloading = false
                switch result {
                case .success(let fileURL):
                    self.downloadURL = fileURL
                    self.downloadProgress = 1.0
                case .failure(let error):
                    self.downloadError = error
                }
            }
        }
    }
    
    private func downloadFile(from url: URL, completion: @escaping (Result<URL, Error>) -> Void) {
        let task = URLSession.shared.downloadTask(with: url) { tempURL, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let tempURL = tempURL else {
                completion(.failure(NSError(domain: "DownloadError", code: 0, userInfo: [NSLocalizedDescriptionKey: "No file URL found."])))
                return
            }
            
            let fileManager = FileManager.default
            let customDirectoryURL = fileManager.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let destinationURL = customDirectoryURL.appendingPathComponent("CustomFolder").appendingPathComponent(url.lastPathComponent)
            
            do {
                let directoryURL = destinationURL.deletingLastPathComponent()
                if !fileManager.fileExists(atPath: directoryURL.path) {
                    try fileManager.createDirectory(at: directoryURL, withIntermediateDirectories: true, attributes: nil)
                }
                
                if fileManager.fileExists(atPath: destinationURL.path) {
                    try fileManager.removeItem(at: destinationURL)
                }
                try fileManager.moveItem(at: tempURL, to: destinationURL)
                completion(.success(destinationURL))
            } catch {
                completion(.failure(error))
            }
        }
        
        task.resume()
    }
}


struct QuickLookPreview: UIViewControllerRepresentable {
    var url: URL
    
    func makeUIViewController(context: Context) -> QLPreviewController {
        let previewController = QLPreviewController()
        previewController.dataSource = context.coordinator
        return previewController
    }
    
    func updateUIViewController(_ uiViewController: QLPreviewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(url: url)
    }
    
    class Coordinator: NSObject, QLPreviewControllerDataSource {
        var url: URL
        
        init(url: URL) {
            self.url = url
        }
        
        func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
            return 1
        }
        
        func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
            return url as QLPreviewItem
        }
    }
}

struct DownloadView: View {
    @StateObject private var downloadManager = DownloadManager()
    @State private var showPreview: Bool = false
    
    var body: some View {
        VStack {
            if downloadManager.isDownloading {
                ProgressView("Downloading...", value: downloadManager.downloadProgress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle())
            } else if let url = downloadManager.downloadURL {
                Text("Download complete! File saved at \(url.path)")
                Button("Open File") {
                    print("\(url.path)")
                    showPreview = true
                }
                .sheet(isPresented: $showPreview) {
                    QuickLookPreview(url: downloadManager.downloadURL!)
                }
            } else if let error = downloadManager.downloadError {
                Text("Failed to download: \(error.localizedDescription)")
            } else {
                Text("Ready to download")
            }
            
            Button("Download File") {
                guard let url = URL(string: "https://www.w3.org/WAI/ER/tests/xhtml/testfiles/resources/pdf/dummy.pdf") else { return }
                downloadManager.downloadFile(from: url)
            }
        }
        .padding()
    }
}

struct DownloadView_Previews: PreviewProvider {
    static var previews: some View {
        // DownloadView의 프리뷰를 생성합니다.
        DownloadView()
            .previewLayout(.sizeThatFits) // 뷰의 크기를 화면에 맞게 조정합니다.
            .padding() // 패딩을 추가하여 프리뷰의 간격을 조정합니다.
    }
}

