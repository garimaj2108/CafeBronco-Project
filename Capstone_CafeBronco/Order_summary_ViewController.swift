//
//  Order_history_ViewController.swift
//  Capstone_CafeBronco
//
//  Created by Vinamrata on 8/13/17.
//  Copyright © 2017 SCU. All rights reserved.
//

import UIKit
import PassKit


class Order_summary_ViewController: UIViewController,PKPaymentAuthorizationViewControllerDelegate {
    
    var paymentRequest: PKPaymentRequest!

    
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
    
    // Declaring a new variable to store the value of text data of os_subTotal
//    var subTotal: Float = 0.0
    
    var tax : Float = (8.75/100)
    
    var var_finaltotal : Float = 0.0
    
    var temp: Float = 0.0
    
    // Declaring a new variable to store the value of text data of var_finalTotal
//    var total : Float = 0.0
    
    var taxprice : Float = 0.0

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
        
        taxprice = temp * tax
        
        var_finaltotal = temp + (temp * tax)
        
        os_finalTotal.text = sign.appending(String(var_finaltotal))
        
//        total = Float(os_finalTotal.text!)!
    }

    
    func orderSummary(pretax: Double, taxPrice: Double, finalPrice: Double) -> [PKPaymentSummaryItem] {
        
        let pretax = PKPaymentSummaryItem(label: "Subtotal", amount: NSDecimalNumber(string: "\(pretax)"))
        
        let taxes = PKPaymentSummaryItem(label: "Tax", amount: NSDecimalNumber(string: "\(taxPrice)"))
        
//        let var_finaltotal = PKPaymentSummaryItem(label: "CafeBronco", amount:NSDecimalNumber(string: "\(var_finaltotal)"))
        
        let total = PKPaymentSummaryItem(label: "CafeBronco", amount:NSDecimalNumber(string: "\(finalPrice)"))
        
        return [pretax, taxes, total]
        
    }
    
    func paymentAuthorizationViewController(_ controller: PKPaymentAuthorizationViewController, didAuthorizePayment payment: PKPayment, completion: @escaping (PKPaymentAuthorizationStatus) -> Void) {
    completion(PKPaymentAuthorizationStatus.success)
    
    }
    func paymentAuthorizationViewControllerDidFinish(_ controller: PKPaymentAuthorizationViewController) {
        
        controller.dismiss(animated: true, completion: nil )
        
    }

    
    @IBAction func ApplePayAction(_ sender: Any) {
        
        let paymentNetworks = [PKPaymentNetwork.amex,.discover,.visa,.masterCard,.JCB]
        
        if PKPaymentAuthorizationViewController.canMakePayments(usingNetworks: paymentNetworks) {
            
            paymentRequest = PKPaymentRequest()
            
            paymentRequest.currencyCode = "USD"
            
            paymentRequest.countryCode = "US"
            
            paymentRequest.merchantIdentifier = "merchant.com.SCU.Capstone-CafeBronco"
            
            
            paymentRequest.supportedNetworks = paymentNetworks
            
            paymentRequest.merchantCapabilities = .capability3DS
            
            paymentRequest.requiredShippingAddressFields = [.email,.phone]
            
            paymentRequest.paymentSummaryItems = self.orderSummary(pretax: Double(temp), taxPrice: Double(taxprice), finalPrice: Double(var_finaltotal))
            
            let applePayVC = PKPaymentAuthorizationViewController(paymentRequest: paymentRequest)
            
            applePayVC.delegate = self
            
            self.present(applePayVC, animated: true, completion:nil )
            
        }

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

}
