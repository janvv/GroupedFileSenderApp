//
//  ViewController.swift
//  GroupFileReceiver
//
//  Created by Jan on 02.06.24.
//

import UIKit

class ViewController: UIViewController, GroupFileObserverDelegate {
    
    var observer: GroupFileObserver?
    //array to hold strings
    var dataArray: [String] = []
    @IBOutlet weak var logText: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        observer = GroupFileObserver(fileName: "glucoseValues.txt", groupName: "group.kuq", delegate: self)
        receivedData("ViewDidLoad")
    }
    
    func receivedData(_ data: String) {
        dataArray.append(data)
        //convert array to string separatea by linebreak
        let dataAsString = dataArray.joined(separator: "\n")
        logText.text = dataAsString
    }

}

