//
//  LoginViewController.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.

import UIKit

class LoginViewController: TFAccessoryViewController {
    
    @IBOutlet weak var UIUsernameTF: UITextField!
    @IBOutlet weak var UIPasswordTF: UITextField!
    @IBOutlet weak var UIProcessingLabel: UILabel!
    var userInfo:Users?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UIProcessingLabel.alpha=0;
        self.UIUsernameTF.delegate=self;
        self.UIPasswordTF.delegate=self;
        self.UIUsernameTF.inputAccessoryView=self.navbarAccessory;
        self.UIPasswordTF.inputAccessoryView=self.navbarAccessory;
    }
    @IBAction func LoginOnClick(_ sender: Any) {
        //this is the alamofire auth
//        Users.Authenticate(email: self.UIUsernameTF.text!, password: self.UIPasswordTF.text!, completionHandler: {
//            (resp, err) in
//            if err == nil{
//                self.userInfo=Users();
//                self.LoadingLabel();
//                self.UIProcessingLabel.alpha=1;
//                self.userInfo?.set(id: "", email: self.UIUsernameTF.text!);
//                self.performSegue(withIdentifier: "loginToProductList", sender: nil)
//            }else{
//                self.errorLabel(error: "Problems Logging in into your Account");
//                self.UIProcessingLabel.alpha=1;
//            }
//        })
        self.userInfo=Users();
        self.LoadingLabel();
        self.UIProcessingLabel.alpha=1;
        self.userInfo?.set(id: "", email: self.UIUsernameTF.text!);
        self.performSegue(withIdentifier: "loginToProductList", sender: nil)
        self.UIProcessingLabel.alpha=0;
    }
    func errorLabel(error:String){
        self.UIProcessingLabel.text=error;
        self.UIProcessingLabel.textColor=UIColor.red;
    }
    func LoadingLabel(){
        self.UIProcessingLabel.text="Processing please wait...";
        self.UIProcessingLabel.textColor=UIColor.black;
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "loginToProductList"{
            let destVC=segue.destination as! ProductListViewController;
            destVC.userLoginInfo=self.userInfo;
        }
    }
    
}
//MARK: - textField func
extension LoginViewController{
    func textFieldDidEndEditing(_ textField: UITextField) {
        (self.view as! AdjustingView).Move(view: self.view, duration: 0.3, moveDistance: 0, up: false);
    }
    func textFieldDidBeginEditing(_ textField: UITextField){
        (self.view as! AdjustingView).Move(view: self.view, duration: 0.3, moveDistance: 100, up: false);
    }
}
