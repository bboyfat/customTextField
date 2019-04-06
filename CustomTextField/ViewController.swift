//
//  ViewController.swift
//  CustomTextField
//
//  Created by Andrey Petrovskiy on 4/6/19.
//  Copyright © 2019 Andrey Petrovskiy. All rights reserved.
//

import UIKit




class ViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var phoneNumTextField: UITextField!
    @IBOutlet weak var passworTextField: UITextField!
    
    @IBOutlet weak var dsoisoidg: UIButton!
    var floatDelegate: FloatingTextDelegate?
    var validDelegate: ValidationDelegate?
    
    let phoneLabel: UILabel = {
        let label = UILabel()

        label.text = "Enter Phone"
        
        label.font = label.font.withSize(15)
        label.textColor = .green
       return label
    }()
    let passLabel: UILabel = {
        let label = UILabel()

        label.text = "Enter pass"
        label.font = label.font.withSize(15)
        label.textColor = .lightGray
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        floatDelegate = FloatingTextField()
        validDelegate = ValidPhonePass()
        self.view.backgroundColor = .purple
        phoneNumTextField.delegate = self
        passworTextField.delegate = self

        
        
        
        addFrames(view: phoneLabel, superView: phoneNumTextField)
        addFrames(view: passLabel, superView: passworTextField)
       
        phoneNumTextField.addSubview(phoneLabel)
        passworTextField.addSubview(passLabel)
    }
        
    

    func addFrames(view: UIView, superView: UIView){
        
        view.frame = superView.bounds
        
        
    }
    
   
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
         textField.becomeFirstResponder()
        if phoneNumTextField.isFirstResponder{
        floatDelegate?.moveUp(view: phoneLabel)
        } else if passworTextField.isFirstResponder{

            floatDelegate?.moveUp(view: passLabel)

        }
        
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
   
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        
        if textField.text?.count == 0{
        if textField == phoneNumTextField{
            floatDelegate?.moveBack(view: phoneLabel)
            return true
        } else if textField == passworTextField {
            floatDelegate?.moveBack(view: passLabel)
            return true
        }
        }

        return true
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        var text = textField.text ?? ""
        if text.count > 0{
        if let validDelegate = self.validDelegate{
        if textField == phoneNumTextField{
            text = phoneNumTextField.text ?? ""
            if validDelegate.isValid(phone: text) == false{
                print(validDelegate.isValid(phone: text))
                
                self.floatDelegate?.moveDown(view: phoneLabel)
            }
            return
        } else if textField == passworTextField {
            text = passworTextField.text ?? ""
            if validDelegate.isCorrectPassword(pass: text) == false{
                
                self.floatDelegate?.moveDown(view: passLabel)
            }
     
            }
            return
        }
        }
    }


}

