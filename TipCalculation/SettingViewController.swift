//
//  SettingViewController.swift
//  TipCalculation
//
//  Created by Vu Nguyen on 6/21/16.
//  Copyright © 2016 VuNguyen. All rights reserved.
//

import UIKit

protocol ViewDelegate{
    func setData(_min : Int, _mid : Int, _max : Int, _defaultIndex: Int);
}

let defaults = NSUserDefaults.standardUserDefaults()

class SettingViewController: UIViewController {

    //MARK: properties
    @IBOutlet weak var minLab: UILabel!
    @IBOutlet weak var midLab: UILabel!
    @IBOutlet weak var maxLab: UILabel!
    @IBOutlet weak var minSlider: UISlider!
    @IBOutlet weak var midSlider: UISlider!
    @IBOutlet weak var maxSlider: UISlider!
    @IBOutlet weak var defaultIndexSegment: UISegmentedControl!
    
    var minCur: Int = 18
    var midCur: Int = 20
    var maxCur: Int = 22
    var defaultIndex: Int = 0
    
    var delegate : ViewDelegate! = nil
    
    
    
    //MARK: initialization
    override func viewDidLoad() {
        super.viewDidLoad()
             
        minCur = defaults.integerForKey("minimum_percentage")
        midCur = defaults.integerForKey("medium_percentage")
        maxCur = defaults.integerForKey("maximum_percentage")
        defaultIndex = defaults.integerForKey("default_percentage")
        
        minLab.text = "\(minCur)%"
        midLab.text = "\(midCur)%"
        maxLab.text = "\(maxCur)%"
        
        minSlider.value = Float(minCur)
        midSlider.value = Float(midCur)
        maxSlider.value = Float(maxCur)
        defaultIndexSegment.selectedSegmentIndex = defaultIndex
        
        

    }
    // MARK: - Navigation
    override func viewWillDisappear(animated: Bool) {
        defaults.setInteger(minCur, forKey: "minimum_percentage")
        defaults.setInteger(midCur, forKey: "medium_percentage")
        defaults.setInteger(maxCur, forKey: "maximum_percentage")
        defaults.setInteger(defaultIndex, forKey: "default_percentage")
        defaults.synchronize()
        
        delegate.setData(minCur, _mid: midCur, _max: maxCur, _defaultIndex: defaultIndex)

    }
    
    
    // MARK: - Action
    
    @IBAction func resetTouchDown(sender: AnyObject) {
        
        minCur = 18
        midCur = 20
        maxCur = 22
        defaultIndex = 0
        displayPercentage(minCur, mid: midCur, max: maxCur)
        //save reset values
        defaults.setInteger(minCur, forKey: "minimum_percentage")
        defaults.setInteger(midCur, forKey: "medium_percentage")
        defaults.setInteger(maxCur, forKey: "maximum_percentage")
        defaults.setInteger(defaultIndex, forKey: "default_percentage")
        defaults.synchronize()
        //send reset values to ViewController
        delegate.setData(minCur, _mid: midCur, _max: maxCur, _defaultIndex: defaultIndex)
        self.navigationController?.popToRootViewControllerAnimated(true)
    }
    
    @IBAction func minChanged(sender: AnyObject) {
        minCur = Int(minSlider.value)
        //minimum value < midle value < maximum value
        if(maxCur < minCur) {
            maxCur = minCur
        }
        if(midCur < minCur) {
            midCur = minCur
        }
        displayPercentage(minCur, mid: midCur, max: maxCur)
        
    }
    
    @IBAction func midChanged(sender: AnyObject) {
        midCur = Int(midSlider.value)
        //minimum value < midle value < maximum value
        if(minCur > midCur) {
            minCur = midCur
        }
        if(maxCur < midCur) {
            maxCur = midCur
        }
        displayPercentage(minCur, mid: midCur, max: maxCur)
    }
    
    @IBAction func maxChanged(sender: AnyObject) {
        maxCur = Int(maxSlider.value)
        //minimum value < midle value < maximum value
        if(minCur > maxCur) {
            minCur = maxCur
        }
        if(midCur > maxCur) {
            midCur = maxCur
        }
        displayPercentage(minCur, mid: midCur, max: maxCur)
    }
    
    @IBAction func onEditChanging(sender: AnyObject) {
        defaultIndex = defaultIndexSegment.selectedSegmentIndex
    }
    // MARK: - extra functions
    
    func displayPercentage(min : Int, mid : Int, max : Int) {
        minLab.text = "\(min)%"
        midLab.text = "\(mid)%"
        maxLab.text = "\(max)%"
        
        minSlider.value = Float(min)
        midSlider.value = Float(mid)
        maxSlider.value = Float(max)
        
    }
}
