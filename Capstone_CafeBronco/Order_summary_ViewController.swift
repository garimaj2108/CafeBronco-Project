//
//  Order_history_ViewController.swift
//  Capstone_CafeBronco
//
//  Created by Vinamrata on 8/13/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit

class Order_summary_ViewController: UIViewController {
    
    @IBOutlet weak var os_item1: UILabel!
    @IBOutlet weak var os_quantity1: UILabel!
    @IBOutlet weak var os_price1: UILabel!
    
    @IBOutlet weak var os_item2: UILabel!
    @IBOutlet weak var os_quantity2: UILabel!
    @IBOutlet weak var os_price2: UILabel!
    
    @IBOutlet weak var os_item3: UILabel!
    @IBOutlet weak var os_quantity3: UILabel!
    @IBOutlet weak var os_price3: UILabel!
    
    @IBOutlet weak var os_subTotal: UILabel!
    
    @IBOutlet weak var os_finalTotal: UILabel!
    
    @IBOutlet weak var pickupTime: UIDatePicker!
   
    //To display menu items on order summary page
    
    var itemname1 = String()
    var itemname2 = String()
    var itemname3 = String()
    
    var tax : Float = (8.75/100)
    var var_finaltotal : Float = 0.0

    var sign = "$ "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Display the items selected by user on Order summary page
        
        if(var_quantity1 != 0){
            os_item1.text = itemname1
            os_quantity1.text = String(var_quantity1)
            os_price1.text = sign.appending(String(var_itemprice1))
        }
        if(var_quantity2 != 0){
            os_item2.text = itemname2
            os_quantity2.text = String(var_quantity2)
            os_price2.text = sign.appending(String(var_itemprice2))
        }
        if(var_quantity3 != 0){
            os_item3.text = itemname3
            os_quantity3.text = String(var_quantity3)
            os_price3.text = sign.appending(String(var_itemprice3))
        }
        
        
        let temp = var_itemprice1 + var_itemprice2 + var_itemprice3

        os_subTotal.text = sign.appending(String(temp))
        
        var_finaltotal = temp + (temp * tax)
        
        os_finalTotal.text = sign.appending(String(var_finaltotal))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

}
