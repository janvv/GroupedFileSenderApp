import Foundation

// Protocol for delegate
protocol GroupFileObserverDelegate: AnyObject {
    func receivedData(_ data: String)
}

class GroupFileObserver: NSObject {
    
    let fileManager = FileManager.default
    let fileName: String
    let groupName: String
    let delegate: GroupFileObserverDelegate
    
    init(fileName: String, groupName: String, delegate: GroupFileObserverDelegate) {
        self.fileName = fileName
        self.groupName = groupName
        self.delegate = delegate
        super.init()
        NSFileCoordinator.addFilePresenter(self)
        print("GroupFileObserver initialized")
    }
    
    //loopObserver.removeFilePresenter when function is deinitialized
    deinit {
        NSFileCoordinator.removeFilePresenter(self)
        print("GroupFileObserver deinitialized")
    }
    
    private func getURL() -> URL? {
        guard let fileURL = self.fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupName) else {
            print("Error: File URL is nil")
            return nil
        }
        print("File URL: \(fileURL.appendingPathComponent(fileName))")
        return fileURL.appendingPathComponent(fileName)
    }

}


// MARK: - NSFilePresenter
extension GroupFileObserver: NSFilePresenter {
    public var presentedItemURL: URL? {
        let url = self.getURL()
        print("Presented item URL: \(String(describing: url))")
        return url
    }
    
    public var presentedItemOperationQueue: OperationQueue {
        return OperationQueue.main
    }
    
    public func presentedItemDidChange() {
        print(#function, "Loading file \(fileName)")
        //read the new data
        // Read glucose values from the shared file in the app group directory
        guard let fileURL = self.getURL() else {
            print("Error: File URL is nil")
            return
        }

        do {
            let data = try String(contentsOf: fileURL, encoding: .utf8)
            print("Received glucose values: \(data)")
            delegate.receivedData(data)
        } catch {
            print("Error reading glucose values: \(error)")
        }
        
    }
}
    
