//
//  LoginViewController.swift
//  iOS Native App Development Test
//
//  Created by Pieter Yonathan on 11/06/22.
//

import UIKit

class LoginViewController: UIViewController {
    //IBOutlet
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var polindromeTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var resultLabel: UILabel!
    
    //Declaration Variable
    var nameText = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UpdateUI()

    }

    //Check Button Did Tapped
    @IBAction func checkDidTapped(_ sender: Any) {
        if isPalindrome(text: polindromeTextField.text ?? ""){
            resultLabel.text = "isPalindrome"
        }
        else{
            resultLabel.text = "not polindrome"
        }
    }
    
    func isPalindrome(text: String) -> Bool{
        let polindromeArray = Array(text.lowercased())
        var currentIndex = 0
            while currentIndex < polindromeArray.count / 2{
                if polindromeArray[currentIndex] != polindromeArray[polindromeArray.count - currentIndex - 1]{
                    return false
                }
                currentIndex += 1
            }
            return true
    }
    
    //Next Button Did Tapped
    @IBAction func nextDidTapped(_sender: Any){
        //Passing Data
        self.nameText = nameTextField.text ?? ""
        let homeViewController = HomeViewController(nameUser: nameText)
        navigationController?.pushViewController(homeViewController, animated: true)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        let vc = segue.destination as! HomeViewController
//        vc.nameUser = self.nameText
//    }
    
    //Update UI
    func UpdateUI(){
        nameTextField.layer.cornerRadius = 12
        nameTextField.clipsToBounds = true
        
        polindromeTextField.layer.cornerRadius = 12
        polindromeTextField.clipsToBounds = true
        
        nextButton.layer.cornerRadius = 12
        nextButton.clipsToBounds = true
        
        checkButton.layer.cornerRadius = 12
        checkButton.clipsToBounds = true
        
        backgroundImage.contentMode = .scaleAspectFill
    }
    
}
