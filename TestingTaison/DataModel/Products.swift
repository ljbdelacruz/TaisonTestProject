//
//  Products.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import Foundation
import SwiftyJSON


class Product{
    var id:Int=0;
    var name:String = ""
    var Price:Double=0;
    var quantity:Int=0;
    var updated_at:Date=Date();
    var created_at:Date=Date();
    convenience init(id:Int, name:String, price:Double, quantity:Int, created_at:String, updated_at:String){
        self.init()
        self.set(id:id, name: name, price: price, quantity: quantity, created_at: created_at, updated_at: updated_at)
    }
    static func set(json:JSON)->Product{
        var data=Product();
        data.set(id:4, name: json["name"] as! String, price: json["quantity"] as! Double, quantity: json["quantity"] as! Int, created_at:json["created_at"] as! String, updated_at:json["updated_at"] as! String);
        return data;
    }
    static func insert(name:String, price:Double, quantity:Int, completionHandler: @escaping (Error?) -> ()){
        var param:[String:Any]=["name":name, "price":price, "quantity":quantity];
        MyCustomAlamo.PostAlamo(url: "192.168.1.1:80/testforyou/insert/product", param: param, completionHandler: {
            (resp, err) in
            if err == nil {
                completionHandler(nil);
            }else{
                completionHandler(err);
            }
        })
    }
    static func remove(id:String, completionHandler: @escaping (Error?) -> ()){
        var param:[String:String]=["id":id];
        MyCustomAlamo.PostAlamo(url: "192.168.1.1:80/testforyou/delete/product", param:param , completionHandler: {
            (resp, err) in
            if err == nil{
                completionHandler(nil)
            }else{
                completionHandler(err);
            }
        })
    }
    
    //MARK: -Fetch all json data
    static func all(completionHandler: @escaping ([Product]?, Error?) -> ()){
        var list:[Product] = [];
        list.append(Product(id:1, name: "Samsung Note", price: 9000, quantity: 2, created_at: "2013-07-21T19:32:00Z", updated_at: "2013-07-21T19:32:00Z"))
        list.append(Product(id:2, name: "Samsung Note 8", price: 18000, quantity: 100, created_at: "2013-07-21T19:32:00Z", updated_at: "2013-07-21T19:32:00Z"))
        completionHandler(list, nil);
        
//        MyCustomAlamo.GetAlamo(url: "192.168.1.1:80/testforyou/api/product", completionHandler: {
//            (resp, err) in
//            if err == nil {
//                completionHandler(self.setList(json: resp as! JSON), nil)
//            }else{
//                completionHandler(nil, err);
//            }
//        })
    }
    
    //MARK: -Setup list of product
    static func setList(json:JSON)->[Product]{
        var list:[Product]=[]
        //access list of json
        var njson=json["data"]["data"] as! JSON;
        if njson != nil{
            for itm in njson.array!{
                var temp=Product();
                temp.set(id: 4, name: itm["name"] as! String, price: itm["price"] as! Double, quantity: itm["quantity"] as! Int, created_at: itm["created_at"] as! String, updated_at: itm["updated_at"] as! String)
                list.append(temp);
            }
        }
        return list;
    }
    func set(id:Int, name:String, price:Double, quantity:Int, created_at:String, updated_at:String){
        self.name=name;
        self.Price=price;
        self.quantity=quantity;
        let formatter = ISO8601DateFormatter()
//        self.created_at=formatter.date(from: created_at)!
//        self.updated_at=formatter.date(from: updated_at)!;
    }
    
    
}
