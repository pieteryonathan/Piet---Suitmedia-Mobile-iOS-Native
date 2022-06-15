//
//  HomeViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 12/06/22.
//

import UIKit

class HomeViewController: UIViewController {
    
    //Declaration
    let userViewController = UserViewController()
    let bottomSheetViewController = BottomSheetViewController()
    var webURL = ""
    //IBOutlet
    @IBOutlet weak var avatarUser: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emptyStateLabel: UILabel!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var websiteButton: UIButton!{
        didSet{
            websiteButton.titleLabel?.font = UIFont(name: "Poppins-Medium", size: 18)
        }
    }
    
    
    //Set Data from Login
    var nameUser = ""
    init(nameUser: String = ""){
        self.nameUser = nameUser
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //Button Attributes
    let buttonAttributes: [NSAttributedString.Key: Any] = [
        .underlineStyle: NSUnderlineStyle.single.rawValue
    ]
    
    var attributedString = NSMutableAttributedString(string:"")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
    }
    
    func setup(){
        navigationItem.title = "Home"
        navigationItem.backButtonTitle = ""
        avatarUser.image = UIImage(named: "image 2")
        nameLabel.text = nameUser
        userViewController.delegate = self
        bottomSheetViewController.delegate = self
    }
    
    @IBAction func websiteDidTapped(_ sender: Any) {
        
        //Pasing Data
        let webViewController = WebViewController(webURL: webURL)
//        let navVC = UINavigationController(rootViewController: webViewController)
//        navVC.modalPresentationStyle = .fullScreen
//        present(navVC, animated: true)
        navigationController?.pushViewController(webViewController, animated: true)
    }
    @IBAction func choosUserDidTapped(_ sender: Any) {
        navigationController?.pushViewController(userViewController, animated: true)
    }
}

extension HomeViewController: UserViewControllerDelegate{
    func getDataUserForHome(userData: UserData) {
        guard let firstName = userData.first_name else{
            return
        }
        guard let lastName = userData.last_name else{
            return
        }
        let name = firstName + " " + lastName
        let imageURL = URL(string: userData.avatar ?? "")
        emptyStateLabel.text = ""
        fullNameLabel.text = name
        emailLabel.text = userData.email
        websiteButton.setAttributedTitle(NSAttributedString(string: "website", attributes: buttonAttributes), for: .normal)
        avatarUser.downloaded(from: imageURL!)
        avatarUser.layer.cornerRadius = avatarUser.frame.height/2
        avatarUser.clipsToBounds = true
        webURL = userData.website
    }
}

extension HomeViewController: BottomSheetViewControllerDelegateHome{
    func getDataUserFromMap(userData: UserData) {
        navigationController?.popViewController(animated: true)
    }
    
    
}



