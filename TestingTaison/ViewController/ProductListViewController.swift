//
//  ProductListViewController.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController, ProductRemoveDelegate {
    @IBOutlet weak var UIProductSB: UISearchBar!
    @IBOutlet weak var UIProductListTV: UITableView!
    var userLoginInfo:Users?;
    var selectedProd:Product?;
    var selectedIndex:Int=0;
    
    var origProductList:[Product]=[];
    var productList:[Product]=[];
    override func viewDidLoad(){
        super.viewDidLoad()
        //assign delegates
        self.UIProductSB.delegate=self;
        self.UIProductListTV.delegate=self;
        self.UIProductListTV.dataSource=self;
        self.UIProductListTV.register(UINib(nibName: "Cell1TableViewCell", bundle: nil), forCellReuseIdentifier: "Cell1");
        self.LoadData();
        self.ConfigureTVCell()
        //do query for list on web
        //assign data got from list
    }
    @IBAction func AddOnClick(_ sender: Any) {
        var productNameTF:UITextField?;
        var priceTF:UITextField?;
        var quantityTF:UITextField?;
        
        let uialert=UIAlertController(title: "Add Product", message: "", preferredStyle: .alert)
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Room Name";
            productNameTF=tf;
        })
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Quantity";
            quantityTF=tf;
        })
        uialert.addTextField(configurationHandler: {
            (tf) in
            tf.placeholder="Price";
            priceTF=tf;
        })
        let addAction=UIAlertAction(title: "Add", style: .default, handler:{
            (action) in
            //action invoked when user added new item button
            self.AddNewData(name: productNameTF!.text!, price: Double(priceTF!.text!) ?? 0 , quantity: Int(quantityTF!.text!) ?? 0)
        })
        let cancelAction=UIAlertAction(title: "Cancel", style: .default, handler: {
            (action) in
        })
        uialert.addAction(addAction);
        uialert.addAction(cancelAction);
        present(uialert, animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "productListToViewInfo"{
            let destVC=segue.destination as! ViewProductViewController;
            destVC.productInfo=self.selectedProd;
            destVC.productRemoveDelegate=self;
            destVC.index=self.selectedIndex;
        }
    }
    func productRemove(id: Int) {
        //do removing of product here
        self.origProductList.remove(at: id);
        self.LoadData();
    }
}
//MARK: UITableView Functionalities
extension ProductListViewController:UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.productList.count;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell=self.UIProductListTV.dequeueReusableCell(withIdentifier: "Cell1", for: indexPath) as! Cell1TableViewCell;
        cell.setContent(name: self.productList[indexPath.row].name, price: self.productList[indexPath.row].Price, quantity: self.productList[indexPath.row].quantity)
        return cell;
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true);
        self.selectedProd=self.productList[indexPath.row];
        self.selectedIndex=indexPath.row;
        self.performSegue(withIdentifier: "productListToViewInfo", sender: nil);
    }
    func ConfigureTVCell(){
        self.UIProductListTV.rowHeight=150;
    }
    
}
//MARK: -UISearchBar Functionalities
extension ProductListViewController : UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.count <= 0 {
            self.LoadData();
        }
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.LoadData()
    }
}

//MARK: -DataHandling Func
extension ProductListViewController{
    func LoadData(){
        if self.UIProductSB.text!.count > 0 {
            self.productList=self.productList.filter({$0.name.lowercased().contains(self.UIProductSB.text!.lowercased())})
            self.UIProductListTV.reloadData();
        }else{
            if self.origProductList.count <= 0{
                Product.all(completionHandler: {
                    (list, err) in
                    if err == nil{
                        self.productList=list!;
                        self.origProductList=list!;
                        self.UIProductListTV.reloadData()
                    }else{
                        print(err?.localizedDescription)
                    }
                })
            }else{
                self.productList=self.origProductList;
                self.UIProductListTV.reloadData()
            }
        }
    }
    func AddNewData(name:String, price:Double, quantity:Int){
        var dateNow=Date();
        var temp=Product(id:10, name: name, price: price, quantity: quantity, created_at:"", updated_at:"")
        self.origProductList.append(temp);
        self.productList.append(temp);
        self.UIProductListTV.reloadData();
    }
}
