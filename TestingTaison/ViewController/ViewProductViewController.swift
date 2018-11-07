//
//  ViewProductViewController.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class ViewProductViewController: UIViewController {

    @IBOutlet weak var UINameLabel: UILabel!
    @IBOutlet weak var UIQuantityLabel: UILabel!
    @IBOutlet weak var UIPriceLabel: UILabel!
    
    var productRemoveDelegate:ProductRemoveDelegate?;
    var productInfo:Product?;
    var index:Int?;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.UINameLabel.text=productInfo?.name;
        self.UIQuantityLabel.text="Quantity: "+String(productInfo!.quantity)
        self.UIPriceLabel.text="Price: "+String(self.productInfo!.Price);
    }
    @IBAction func DeleteProduct(_ sender: Any) {
        self.productRemoveDelegate?.productRemove(id:self.index!)
        self.navigationController?.popViewController(animated: true);
        
    }
    
}
