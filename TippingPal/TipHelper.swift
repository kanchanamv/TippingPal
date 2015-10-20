//
//  TipHelper.swift
//  TippingPal
//
//  Created by helpdesk on 10/18/15.
//  Copyright © 2015 kanch. All rights reserved.
//

import Foundation

public class TipHelper {
    
    static let defaults = NSUserDefaults.standardUserDefaults();
  
    class func getSubparServiceTip() -> Double {
        return getTipValue("defaultSubParTip", defaultIfNotFound: 15)
    }
    
    class func getAverageServiceTip() -> Double {
        return getTipValue("defaultAverageTip", defaultIfNotFound: 22)
    }
    
    class func getExcellentServiceTip() -> Double {
        return getTipValue("defaultExcellentTip", defaultIfNotFound: 30)
    }
    
    class func setSubparServiceTip(tipValue: Double) {
        defaults.setDouble(tipValue, forKey: "defaultSubParTip")
    }
    
    class func setAverageServiceTip(tipValue: Double) {
        defaults.setDouble(tipValue, forKey: "defaultAverageTip")
    }
    
    class func setExcellentServiceTip(tipValue: Double) {
        defaults.setDouble(tipValue, forKey: "defaultExcellentTip")
    }
    
    class func getTipValue(tipLevel: String, defaultIfNotFound: Double) -> Double {
        
        var value = defaults.doubleForKey(tipLevel);
        
        if(value == 0){
            value = defaultIfNotFound;
        }
        
        return value;
    }
}