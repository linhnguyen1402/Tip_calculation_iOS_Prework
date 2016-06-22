//
//  ViewController.swift
//  TipCalculation
//
//  Created by Vu Nguyen on 5/23/16.
//  Copyright © 2016 VuNguyen. All rights reserved.
//

import UIKit


class ViewController: UIViewController, ViewDelegate {

    //MARK: Properties
    @IBOutlet weak var tipLabel: UILabel!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var billField: UITextField!
    @IBOutlet weak var tipControl: UISegmentedControl!

    var minPercentage = 18
    var midPercentage = 20
    var maxPercentage = 22
    
    var defaultIndex = 0
    
    //MARK: initialization
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tipLabel.text = "$0.00"
        totalLabel.text = "$0.00"
        
        minPercentage = defaults.integerForKey("minimum_percentage")
        midPercentage = defaults.integerForKey("medium_percentage")
        maxPercentage = defaults.integerForKey("maximum_percentage")
        defaultIndex = defaults.integerForKey("default_percentage")
        
        tipControl.setTitle("\(minPercentage)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(midPercentage)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(maxPercentage)%", forSegmentAtIndex: 2)
        tipControl.selectedSegmentIndex = defaultIndex
        
        billField.becomeFirstResponder()
        billField.text = "\(defaults.doubleForKey("bill_amount"))"
        tipCalculation()
    }
    override func viewWillAppear(animated: Bool) {
        tipControl.setTitle("\(minPercentage)%", forSegmentAtIndex: 0)
        tipControl.setTitle("\(midPercentage)%", forSegmentAtIndex: 1)
        tipControl.setTitle("\(maxPercentage)%", forSegmentAtIndex: 2)
        tipControl.selectedSegmentIndex = defaultIndex
        tipCalculation()
    }
    
    override func viewWillDisappear(animated: Bool) {
        defaults.setDouble((NSString(string: billField.text!).doubleValue), forKey: "bill_amount")
        defaults.synchronize()
    }
   
    //MARK: Actions
    @IBAction func onEdittingChange(sender: AnyObject) {
     tipCalculation()
    }

    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    //MARK: navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        let destination = segue.destinationViewController as! SettingViewController
        destination.delegate = self
    }
    
    //MARK: Extra function
    
    //calculate tip amount and total amount
    func tipCalculation() {
        var tipPercentages = [Double(minPercentage)*0.01, Double(midPercentage)*0.01, Double(maxPercentage)*0.01]
        let tipPercentage = tipPercentages[tipControl.selectedSegmentIndex]
        let billAmount = NSString(string: billField.text!).doubleValue
        let tip = billAmount * tipPercentage
        let total = billAmount + tip
        tipLabel.text = String(format: "$%.2f", tip)
        totalLabel.text = String(format: "$%.2f", total)
    }
    
    func setData(_min: Int, _mid: Int, _max: Int, _defaultIndex :Int) {
        minPercentage = _min
        midPercentage = _mid
        maxPercentage = _max
        defaultIndex = _defaultIndex
    }
}

