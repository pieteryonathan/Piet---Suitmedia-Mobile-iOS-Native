//
//  WebViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 13/06/22.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    @IBOutlet weak var webView: WKWebView!
    // Get Data
    var webURL = ""
    init(webURL: String = ""){
        self.webURL = webURL
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webRequest()
        setup()
    }

    func webRequest(){
        let url = URL(string: webURL)
        let request = URLRequest(url: url!)
        webView.load(request)

    }
    
    func setup(){
//        let backButton = UIBarButtonItem()
//        backButton.title = "Back"
//        navigationItem.backBarButtonItem = backButton
//        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .plain, target: self, action: #selector(dismissSelf))
    }
    
    @objc func dismissSelf(){
        dismiss(animated: true, completion: nil)
    }

}
