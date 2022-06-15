//
//  BottomSheetViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 13/06/22.
//

import UIKit

protocol BottomSheetViewControllerDelegateHome{
    func getDataUserFromMap(userData: UserData)
}

protocol BottomSheetPop{
    func getDataUserPop(userData: UserData)
}
class BottomSheetViewController: UIViewController {

    @IBOutlet weak var selectButton: UIButton!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var avatarUser: UIImageView!
    
    var userInfo: UserInfoMap?
    init(userInfo: UserInfoMap? = nil){
        self.userInfo = userInfo
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    var delegate : BottomSheetViewControllerDelegateHome?
    var delegatePop: BottomSheetPop?
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()

    }
    
    func setup(){
        guard let firstName = userInfo?.first_name else{
            return
        }
        guard let lastName = userInfo?.last_name else{
            return
        }
        nameUser.text = firstName + " " + lastName
        let imageURL = URL(string: userInfo?.avatar ?? "")
        avatarUser.downloaded(from: imageURL!)
        avatarUser.layer.cornerRadius = avatarUser.frame.height/2
        avatarUser.clipsToBounds = true
        
    }

    @IBAction func selectDidTapped(_ sender: Any) {
        let dataUser = UserData(website: userInfo?.website ?? "", email: userInfo?.email ?? "", first_name: userInfo?.first_name ?? "", last_name: userInfo?.last_name ?? "", avatar: userInfo?.avatar ?? "")
//        delegate?.getDataUserFromMap(userData: dataUser)
        delegatePop?.getDataUserPop(userData: dataUser)
        self.dismiss(animated: true)
    }
}
    
//extension BottomSheetViewController: MapViewControllerDelegateBottom{
//    func userInfoForBottom(userData: UserInfoMap) {
//        
//    }
//}

