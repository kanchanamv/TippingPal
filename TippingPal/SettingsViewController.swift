//
//  SettingsViewController.swift
//  TippingPal
//
//  Created by helpdesk on 10/16/15.
//  Copyright © 2015 kanch. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UIViewController {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    @IBOutlet weak var defaultSubParTip: UITextField!
    @IBOutlet weak var defaultAverageTip: UITextField!
    @IBOutlet weak var defaultExcellentTip: UITextField!
    
    @IBAction func onSubParDefaultChanged(sender: AnyObject) {
        if(defaultSubParTip.text != nil && defaultSubParTip.text != ""){
            TipHelper.setSubparServiceTip(Double(defaultSubParTip.text!)!)
        }
    }
    
    @IBAction func onAverageDefaultChanged(sender: AnyObject) {
        if(defaultAverageTip.text != nil && defaultAverageTip.text != ""){
            TipHelper.setAverageServiceTip(Double(defaultAverageTip.text!)!)
        }
    }
    
    @IBAction func onExcellentDefaultChanged(sender: AnyObject) {
        if(defaultExcellentTip.text != nil && defaultExcellentTip.text != ""){
            TipHelper.setExcellentServiceTip(Double(defaultExcellentTip.text!)!)
        }
    }
    
    override func viewDidLoad() {
        defaultSubParTip.text = String(TipHelper.getSubparServiceTip())
        defaultAverageTip.text = String( TipHelper.getAverageServiceTip())
        defaultExcellentTip.text = String( TipHelper.getExcellentServiceTip())
    }
    
    
    //    @IBAction func onValueChanged (sender : AnyObject) {
    //        var tipPercentages = [0.18,0.20,0.22];
    //        let tipPercentage = tipPercentages[tipChangedPercent.selectedSegmentIndex]
    //
    //        //  defaults.setDouble(tipPercentage, forKey: "tipChangedPercentage")
    //        if (tipPercentage == 0.18) {
    //            tipChangedPercent.selectedSegmentIndex = 0
    //
    //        } else if (tipPercentage == 0.20) {
    //            tipChangedPercent.selectedSegmentIndex = 1
    //        }
    //        else if (tipPercentage == 0.22)
    //        {   tipChangedPercent.selectedSegmentIndex = 2
    //        }
    //        //defaults.setDouble(tipPercentage, forKey: "tipChangedPercentage")
    //        defaults.setObject(tipPercentage, forKey: "tipChangedPercentage")
    //
    //
    //        print(tipPercentage)
    //        print(tipChangedPercent.selectedSegmentIndex)
    //
    //        defaults.synchronize()
    //
    //    }
    //
    //    @IBAction func onButtonPressed(sender: AnyObject) {
    //        
    //        viewWillAppear(true)
    //    }
}

