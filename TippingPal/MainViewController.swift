//
//  MainViewController.swift
//  TippingPal
//
//  Created by helpdesk on 10/15/15.
//  Copyright © 2015 kanch. All rights reserved.
//

import UIKit


class MainViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var TotalLabel: UILabel!
    @IBOutlet weak var TipLabel: UILabel!
    @IBOutlet weak var BillingAmountTextField: UITextField!
    @IBOutlet weak var BillAmountField: UILabel!
    
    @IBOutlet weak var tipControl: UISegmentedControl!
    @IBOutlet weak var RoundingControl: UISegmentedControl!
    
    @IBOutlet weak var tipPicker: UIPickerView!
    
    @IBOutlet weak var SubparButton: UIButton!
    @IBOutlet weak var ExcellentButton: UIButton!
    @IBOutlet weak var AverageButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTipPicker()
        
        let tipPercentage: Double = Double(kTipPercentageValues[7])/100;
        calculateTip(tipPercentage);
        tipPicker.selectRow(7, inComponent: 0, animated: true)
        
        //buttons
        self.SubparButton.layer.cornerRadius = 3.0
        self.AverageButton.layer.cornerRadius = 3.0
        self.ExcellentButton.layer.cornerRadius = 3.0
        self.SubparButton.backgroundColor = kMainBlueColor
        self.AverageButton.backgroundColor = kMainBlueColor
        self.ExcellentButton.backgroundColor = kMainBlueColor
        
        self.RoundingControl.layer.borderColor = kMainBlueColor.CGColor
        self.RoundingControl.tintColor = kMainBlueColor
        self.RoundingControl.setTitleTextAttributes(NSDictionary(objects: [UIColor.whiteColor()], forKeys: [NSForegroundColorAttributeName]) as [NSObject : AnyObject], forState: UIControlState.Normal)
        self.RoundingControl.setTitleTextAttributes(NSDictionary(objects: [UIColor.whiteColor()], forKeys: [NSForegroundColorAttributeName]) as [NSObject : AnyObject], forState: UIControlState.Selected)
        
        self.BillingAmountTextField.layer.cornerRadius = 3.0
        self.BillingAmountTextField.layer.borderWidth = 1.0
        self.BillingAmountTextField.layer.borderColor = UIColor.grayColor().CGColor
        self.BillingAmountTextField.becomeFirstResponder()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.Black
        nav?.tintColor = UIColor.yellowColor()
        self.navigationItem.title = "Tipping Pal";
        print(TipHelper.getSubparServiceTip())
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        //print("view did appear")
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        //print("view will disappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
        //print("view did disappear")
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func onEditingChanged(sender: AnyObject) {
        
        let selectedTip : Int = kTipPercentageValues[tipPicker.selectedRowInComponent(0)];
        let tipPercentage: Double = Double(selectedTip)/100;
        calculateTip(tipPercentage);
    }
    
    @IBAction func onTap(sender: AnyObject) {
        view.endEditing(true)
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return kTipPercentageValues.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {        return ("\(kTipPercentageValues[row])" + "%");
    }
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        let rect: CGRect = CGRectMake(0.0, 0.0, 100.0,100.0)
        
        let label: UILabel = UILabel(frame: rect)
        label.text = ("\(kTipPercentageValues[row])" + "%");
        label.opaque = false
        
        label.textAlignment = .Center
        label.clipsToBounds = false
        label.textColor = UIColor.whiteColor()
        label.transform = CGAffineTransformRotate(label.transform, 1.57)
        
        return label
    }
    
    func pickerView(pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return 40.0; //at least row height 35 is needed for good alignment
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int)
    {
        let selectedTip : Int = kTipPercentageValues[row];
        let tipPercentage: Double = Double(selectedTip)/100;
        calculateTip(tipPercentage);
    }
    
    @IBAction func setSubParServiceTip(sender: AnyObject) {
        let subParTip = TipHelper.getSubparServiceTip()
        let tipPercentage: Double = subParTip/100;
        calculateTip(tipPercentage);
        
        tipPicker.selectRow(kTipPercentageValues.indexOf(Int(subParTip))!, inComponent: 0, animated: true)
    }
    
    @IBAction func setAverageServiceTip(sender: AnyObject) {
        let averageTip = TipHelper.getAverageServiceTip()
        let tipPercentage: Double = averageTip/100;
        calculateTip(tipPercentage);
        
        tipPicker.selectRow(kTipPercentageValues.indexOf(Int(averageTip))!, inComponent: 0, animated: true)

    }
    
    @IBAction func setExcellentServiceTip(sender: AnyObject) {
        let excellentTip = TipHelper.getExcellentServiceTip()
        let tipPercentage: Double = excellentTip/100;
        calculateTip(tipPercentage);
        
        tipPicker.selectRow(kTipPercentageValues.indexOf(Int(excellentTip))!, inComponent: 0, animated: true)
      
    }
    
    func calculateTip(tipPercentage: Double){
        
        var tip : Double = 0.00;
        var total : Double = 0.00;
        
        if(BillingAmountTextField.text != nil && BillingAmountTextField.text != ""){
            let amount = Double(BillingAmountTextField.text!);
            tip = amount! * tipPercentage;
            total = amount! + tip
        }
        
        total = roundTotalIfOptionSelected(total)
        
        TipLabel.text = formatResult(tip)
        TotalLabel.text = formatResult(total)
    }
    
    func roundTotalIfOptionSelected(total: Double) -> Double{
        
        let roundingFlagSelected = RoundingControl.selectedSegmentIndex
        var roundingType : RoundingType;
        
        if(roundingFlagSelected == 0) {
            roundingType = .RoundUp
        }
        else if (roundingFlagSelected == 1) {
            roundingType = .RoundDown
        }
        else{
            roundingType = .None
        }
        
        var roundedTotal: Double;
        
        switch roundingType {
        case .RoundUp:
            roundedTotal = ceil(total)
        case .RoundDown:
            roundedTotal = floor(total)
        default:
            roundedTotal = total
        }
        
        return roundedTotal;
    }
    
    func setupTipPicker() {
        
        self.tipPicker.delegate = self
        self.tipPicker.dataSource = self
        
        self.tipPicker.transform = CGAffineTransformMakeScale(1.80, 0.90);
        self.tipPicker.transform = CGAffineTransformRotate(self.tipPicker.transform, CGFloat(-M_PI/2))
        self.tipPicker.reloadAllComponents()
        self.tipPicker.backgroundColor = kMainBlueColor
        
    }
    
    func formatResult(value: Double) -> String {
        
        let currencyFormatter = NSNumberFormatter()
        currencyFormatter.numberStyle = NSNumberFormatterStyle.CurrencyStyle
        currencyFormatter.locale = NSLocale.currentLocale()
        return currencyFormatter.stringFromNumber(value)!
    }
}
