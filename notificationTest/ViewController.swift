//
//  ViewController.swift
//  notificationTest
//
//  Created by Jan on 01.06.24.
//

import UIKit
import Foundation

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //IBaction button pressed
    @IBAction func buttonPressed(_ sender: UIButton) {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
                print("Error getting app delegate")
                return
        }
        let started: Bool = appDelegate.toggleBackgroundTask()
        if started {
            sender.setTitle("Stop", for: .normal)
        } else {
            sender.setTitle("Start", for: .normal)
        }
            
    }
}
        
//        // Write glucose values to the shared file in the app group directory
//        let fileManager = FileManager.default
//        let fileCoordinator = NSFileCoordinator(filePresenter: nil)
//
//        let fileURL = fileManager.containerURL(forSecurityApplicationGroupIdentifier: "group.kuq")?.appendingPathComponent()
//
//        guard let fileURL = fileURL else {
//            print("Error getting file URL")
//            return
//        }
//
//        fileCoordinator.coordinate(writingItemAt: fileURL, options: .forReplacing, error: nil, byAccessor: { writingURL in
//            do {
//                // Write data to the file
//                let data = ["glucose": 120, "timestamp": Date().timeIntervalSince1970, "trend": 1.5]
//
//                try "\(data)".write(to: writingURL, atomically: true, encoding: .utf8)
//                print("Data was successfully written to the file")
//
//                // Read the content of the file after modification
//                let fileContent = try String(contentsOf: writingURL, encoding: .utf8)
//                print("Content of the file after modification: \(fileContent)")
//            } catch {
//                print("Error: \(error)")
//            }
//        })
//
//    }
