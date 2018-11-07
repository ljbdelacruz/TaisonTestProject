//
//  Cell1TableViewCell.swift
//  TestingTaison
//
//  Created by Lainel John Dela Cruz on 05/11/2018.
//  Copyright © 2018 Lainel John Dela Cruz. All rights reserved.
//

import UIKit

class Cell1TableViewCell: UITableViewCell {
    
    @IBOutlet weak var UIProductName: UILabel!
    @IBOutlet weak var UIPrice: UILabel!
    @IBOutlet weak var UIQuantity: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func setContent(name:String, price:Double, quantity:Int){
        self.UIProductName.text=name;
        self.UIPrice.text=String(price);
        self.UIQuantity.text=String(quantity);
    }
    @IBAction func RemoveOnClick(_ sender: Any) {
        
    }
}
