//
//  MyCustomAlamo.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class MyCustomAlamo{
    
    
    static func PostAlamo(url:String, param:[String:Any], completionHandler: @escaping (Any?, Error?) -> ()){
        ExecuteParam(url: url, httpmethod: .post, param: param, completionHandler: {
            (resp, err) in
            completionHandler(resp, err);
        })
    }
    static func GetAlamo(url:String, completionHandler: @escaping (JSON?, Error?) -> ()){
        self.GetAlamo(url: url, completionHandler: {
            (resp, err) in
            completionHandler(resp, err);
        })
    }
    static func GetAlamo(url:String, param:[String:Any], completionHandler: @escaping (JSON?, Error?) -> ()){
        self.ExecuteParam(url: url, httpmethod: .get, param: param, completionHandler: {
            (resp, err) in
            completionHandler(resp, err);
        })
    }
    
    static func DeleteAlamo(url:String, param:[String:Any], completionHandler: @escaping (JSON?, Error?) -> ()){
        self.ExecuteParam(url: url, httpmethod: .delete, param: param, completionHandler: {
            (resp, err) in
            completionHandler(resp, err);
        })
    }
    
    static func ExecuteNoParam(url:String, httpmethod:HTTPMethod, completionHandler: @escaping (JSON?, Error?) -> ()){
        Alamofire.request(url, method:httpmethod).responseJSON{response in
            if response.result.isSuccess{
                let data:JSON=JSON(response.result.value!);
                completionHandler(data as? JSON, nil)
            }else{
                completionHandler(nil, response.error!)
            }
        };
    }
    static func ExecuteParam(url:String, httpmethod:HTTPMethod, param:[String:Any], completionHandler: @escaping (JSON?, Error?) -> ()){
        Alamofire.request(url, method:httpmethod, parameters:param).responseJSON{response in
            if response.result.isSuccess{
                let data:JSON=JSON(response.result.value!);
                completionHandler(data as? JSON, nil)
            }else{
                completionHandler(nil, response.error!)
            }
        };
    }
    
    
    
    
    
}
