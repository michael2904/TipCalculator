//
//  ViewController.swift
//  TipCalculator
//
//  Created by Michael Abdallah-Minciotti on 2015-01-15.
//  Copyright (c) 2015 Michael Abdallah-Minciotti. All rights reserved.
//

import UIKit

class UIViewController {
}
 
class ViewController: UIKit.UIViewController {

  @IBOutlet var TotalTextField : UITextField!
  @IBOutlet var SubtotalField : UITextField!
    @IBOutlet var TipPctSlider : UISlider!
    @IBOutlet var TipPctLabel : UILabel!
  @IBOutlet var resultsTextView : UITextView!
    @IBOutlet var tipChoice: UISegmentedControl!
    @IBOutlet var refreshTot: UIButton!
    @IBOutlet var refreshSubtot: UIButton!
    @IBOutlet var totalWithTip: UITextField!
    
    var tipCalc = TipCalculatorModel(subtotal: 100.0,TPS:5.0,TVQ:9.975)
    var choice = true

  func refreshUI() {
    var tiptext=String(format:"%.2f",(Double(TipPctSlider.value)))
    TipPctLabel.text = "Tip (\(tiptext)%)"
    resultsTextView.text = ""
  }
    func refreshTotal(){
        tipCalc.subtotal = Double((SubtotalField.text as NSString).doubleValue)
        TotalTextField.text = String(format:"%.2f", tipCalc.calcWithTax())
    }
    func refreshSubtotal(){
        tipCalc.total = Double((TotalTextField.text as NSString).doubleValue)
        SubtotalField.text = String(format:"%.2f", tipCalc.calcWithOutTax())
    }
    
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    refreshUI()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  @IBAction func calculateTapped(sender : AnyObject) {
    tipCalc.subtotal = Double((SubtotalField.text as NSString).doubleValue)
    var possibleTips :[Int:Double]
    if choice {
        possibleTips = tipCalc.returnPossibleTipsFromSubtotal()

    }else{
        possibleTips = tipCalc.returnPossibleTipsFromTotal()
    }
    var results = ""
    var keys = Array(possibleTips.keys)
    sort(&keys)
    for tipPct in keys {
        let tipValue = possibleTips[tipPct]!
        let prettyTipValue = String(format:"%.2f", tipValue)
        results += "\(tipPct)%: \(prettyTipValue)\n"
    }
    let selectedTipP = String(format:"%.2f", Double(TipPctSlider.value))
    var selectedTip : Double
    if choice {
        selectedTip = tipCalc.calcTipWithTipPctFromSubtotal(Double(TipPctSlider.value)/100)
        
    }else{
        selectedTip = tipCalc.calcTipWithTipPctFromTotal(Double(TipPctSlider.value)/100)
    }
    var selTipP = String(format:"%.2f", selectedTip)
    results += "selected tip : \(selectedTipP)%: \(selTipP)\n"

    resultsTextView.text = results
    totalWithTip.text = String(format:"%.2f", Double(tipCalc.total+selectedTip))

  }
    
    @IBAction func TipPercentageChanged(sender : AnyObject) {
        refreshUI()
    }
    @IBAction func SubtotalChanged(sender : AnyObject) {
            tipCalc.subtotal = Double((SubtotalField.text as NSString).doubleValue)
            choice = true
            refreshTotal()
    }

    @IBAction func TipUsed(sender : AnyObject) {
        if tipChoice.selectedSegmentIndex == 0 {
            tipCalc.subtotal = Double((SubtotalField.text as NSString).doubleValue)
            choice=true
            refreshTotal()
        }else if tipChoice.selectedSegmentIndex == 1 {
            tipCalc.total = Double((TotalTextField.text as NSString).doubleValue)
            choice=false
            refreshSubtotal()
        }

    }
    @IBAction func TotalChanged(sender : AnyObject) {
        tipCalc.total = Double((TotalTextField.text as NSString).doubleValue)
        choice = false
        refreshSubtotal()
    }
    
  @IBAction func viewTapped(sender : AnyObject) {
    TotalTextField.resignFirstResponder()
  }

}

