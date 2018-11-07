//
//  Users.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class Users{
    var id:String;
    var email:String;
    var password,api_token, remember_token:String
    var created_at, updated_at:Date;
    
    
    init(){
        self.id="";
        self.email="";
        self.password="";
        self.api_token="";
        self.remember_token="";
        self.created_at=Date()
        self.updated_at=Date()
    }
    convenience init(id:String, email:String){
        self.init();
        self.set(id: id, email: email)
    }
    convenience init(json:JSON){
        self.init()
        self.set(json: json);
    }
    func set(id:String, email:String){
        self.id=id;
        self.email=email;
    }
    func set(json:JSON)->Users{
        self.id=json["id"] as! String;
        self.email=json["email"] as! String;
    }
    static func Authenticate(email:String, password:String, completionHandler: @escaping (Users?, Error?) -> ()){
        MyCustomAlamo.PostAlamo(url: "192.168.1.0/testapiforyou/api/login", param: ["email":email, "pass":password], completionHandler: {
            (resp, err) in
            if err == nil{
                let temp=Users(json: resp as! JSON);
                completionHandler(temp, nil);
            }
        })
    }
    
}
