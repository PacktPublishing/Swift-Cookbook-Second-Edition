//
//  ViewController.swift
//  TaskAPIApp
//
//  Created by Chris Barker on 22/12/2020.
//

import UIKit
import Starscream
import TaskModule

class ViewController: UIViewController {
    
    @IBOutlet weak var responseLabel: UILabel!
    @IBOutlet weak var requestButton: UIButton!
    
    var socket: WebSocket!
    let server = WebSocketServer()

    override func viewDidLoad() {
        super.viewDidLoad()
        openSocket()
        
        let _ = TaskViewModel(title: "", category: "")
        
    }
    
    private func openSocket() {
        
        guard let url = URL(string: "http://127.0.0.1:8080/talk-back2") else { return }
        
        var request = URLRequest(url: url)
        request.timeoutInterval = 5
        socket = WebSocket(request: request)
        socket.delegate = self
        socket.connect()
    }
    
    
    @IBAction func onSendRequest(_ sender: Any) {
        socket.write(string: "Hello")
    }
    
}

extension ViewController: WebSocketDelegate {
    
    func didReceive(event: WebSocketEvent, client: WebSocket) {
        
        switch event {
        case .text(let textResponse):
            responseLabel.text = textResponse
        case .error(let error):
            print(error ?? "")
        default:
            print("Default response: \(event)")
        }
        
    }
        
}

