//
//  ViewController.swift
//  TipCalculator
//
//  Created by Ajinkya Pawar on 2/20/17.
//  Copyright © 2017 Ajinkya Pawar. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //declare static consts
    static let DATE_BILL_UPDATED = "date_bill_updated"
    static let SAVED_BILL_VALUE = "saved_bill_value"
    static let MAX_TIME_INTERVAL = -60.00
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //Set the textfield to the previous value
        let defaults = UserDefaults.standard
        let lastBillUpdate = defaults.object(forKey: ViewController.DATE_BILL_UPDATED) as! NSDate
        let timeIntervalFromLastChange = lastBillUpdate.timeIntervalSinceNow
        if(timeIntervalFromLastChange > ViewController.MAX_TIME_INTERVAL){
            let lastBill = defaults.string(forKey: ViewController.SAVED_BILL_VALUE)
            billField.text = lastBill
        }
        
        //Listen to UIApplicationDidEnterBackground for saving the recent bill value.
        NotificationCenter.default.addObserver(self, selector: #selector(onApplicationDidEnterBackground), name: NSNotification.Name.UIApplicationDidEnterBackground, object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /*
        calculateTip - calculates the tip and the total amount based on the bill amount. It updates the labels accordingly.
    */
    func calculateTip() {
        let tipPercentages = [0.15, 0.2, 0.25]
        let bill = Double(billField.text!) ?? 0
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    /*
        onApplicationDidEnterBackground - saves the recent bill vallue to UserDefaults. Best point to save the values since the app might potentially get terminated.
     */
    func onApplicationDidEnterBackground() {
        let defaults = UserDefaults.standard

        //save values for the recent calculations feature.
        defaults.set(billField.text, forKey: ViewController.SAVED_BILL_VALUE)
        defaults.set(NSDate(), forKey: ViewController.DATE_BILL_UPDATED)
    }

    /*
        calculateTipForChangedParams - Handler for bill amount or tip % change events.
     */
    @IBAction func calculateTipForChangedParams(_ sender: AnyObject) {
        calculateTip()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //make billField as the First Responder
        billField.becomeFirstResponder()

        let defaults = UserDefaults.standard
        tipControl.selectedSegmentIndex = defaults.integer(forKey: SettingsViewController.TIP_PERCENTAGE)
        calculateTip()
    }
}

