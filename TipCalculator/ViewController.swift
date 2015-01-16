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

  @IBOutlet var totalTextField : UITextField!
  @IBOutlet var SubtotalField : UITextField!
    @IBOutlet var TipPctSlider : UISlider!
    @IBOutlet var TipPctLabel : UILabel!
  @IBOutlet var resultsTextView : UITextView!
    var tipCalc = TipCalculatorModel(subtotal: 100.0,TPS:5.0,TVQ:9.975)
    var choice = true

  func refreshUI() {
    TipPctLabel.text = "Tip (\(Double(TipPctSlider.value))%)"
    resultsTextView.text = ""
  }
    func refreshTotal(){
        totalTextField.text = tipCalc.calcWithTax()
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
    tipCalc.total = Double((totalTextField.text as NSString).doubleValue)

    // 2
    let possibleTips = tipCalc.returnPossibleTips()
    var results = ""
    // 3
    var keys = Array(possibleTips.keys)
    sort(&keys)
    for tipPct in keys {
        let tipValue = possibleTips[tipPct]!
        let prettyTipValue = String(format:"%.2f", tipValue)
        results += "\(tipPct)%: \(prettyTipValue)\n"
    }
    let selectedTipP = String(format:"%.2f", Double(TipPctSlider.value))
    let selectedTip = tipCalc.calcTipWithTipPct(Double(TipPctSlider.value)/100)
    results += "selected tip : \(selectedTipP)%: \(selectedTip)\n"

    resultsTextView.text = results
  }
    @IBAction func TipPercentageChanged(sender : AnyObject) {
        refreshUI()
    }
    @IBAction func SubtotalChanged(sender : AnyObject) {
            tipCacl.subtotal = Double((SubtotalField.text as NSString).doubleValue)
    }
    @IBAction func TotalUsedTapped(sender : AnyObject) {
        tipCalc.total = Double((totalTextField.text as NSString).doubleValue)

    }
    @IBAction func SubTotalUsed(sender : AnyObject) {
        tipCalc.total = Double((SubtotalField.text as NSString).doubleValue)

    }
    @IBAction func TotalChanged(sender : AnyObject) {
        refreshUI()
    }
    
  @IBAction func viewTapped(sender : AnyObject) {
    totalTextField.resignFirstResponder()
  }

}

