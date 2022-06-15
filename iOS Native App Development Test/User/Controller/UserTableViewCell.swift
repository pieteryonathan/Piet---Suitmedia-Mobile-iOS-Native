//
//  UserTableViewCell.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 12/06/22.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var imageUser: UIImageView!{
        didSet{
            imageUser.layer.cornerRadius = imageUser.frame.height/2
            imageUser.clipsToBounds = true
        }
    }
    @IBOutlet weak var firstNameUser: UILabel!
    @IBOutlet weak var lastNameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    
}
