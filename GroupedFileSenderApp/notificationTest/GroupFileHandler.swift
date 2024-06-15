import Foundation

class GroupFileHandler {
    
    static func saveStringToGroupFile(string: String, fileName: String, groupIdentifier: String) {
        let fileManager = FileManager.default
        let fileCoordinator = NSFileCoordinator(filePresenter: nil)
        
        guard let fileURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: groupIdentifier)?.appendingPathComponent(fileName) else {
            print("Error getting file URL for group \(groupIdentifier) and file")
            return
        }
        
        fileCoordinator.coordinate(writingItemAt: fileURL, options: .forReplacing, error: nil, byAccessor: { writingURL in
            do {
                try string.write(to: writingURL, atomically: true, encoding: .utf8)
                print("\(string) written to group \(groupIdentifier) file \(fileName)")
            } catch {
                print("Error writing \(string) to group \(groupIdentifier) file \(fileName)")
            }
        })
    }
}
