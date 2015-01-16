//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Michael Abdallah-Minciotti on 2015-01-15.
//  Copyright (c) 2015 Michael Abdallah-Minciotti. All rights reserved.
//

import Foundation

class TipCalculatorModel {

    var total: Double
    var TPS: Double
    var TVQ:Double
    var subtotal: Double


    init(subtotal: Double,TPS: Double, TVQ: Double) {
        self.subtotal = subtotal
        self.TPS = TPS
        self.TVQ = TVQ
        total = calcWithTax()
    }

    func calcTipWithTipPctFromTotal(tipPct: Double) -> Double {
        return total * tipPct
    }
    func calcTipWithTipPctFromSubtotal(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    func calcWithTax() -> Double {
        var total = (subtotal * ((100+TPS)/100))*((100+TVQ)/100)
        return total
    }

  func returnPossibleTipsFromTotal() -> [Int: Double] {
   
    let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
    var retval = [Int: Double]()
    for possibleTip in possibleTipsExplicit {
      let intPct = Int(possibleTip*100)
      retval[intPct] = calcTipWithTipPctFromTotal(possibleTip)
    }
    return retval
   
  }
    func returnPossibleTipsFromSubtotal() -> [Int: Double] {
        
        let possibleTipsExplicit:[Double] = [0.15, 0.18, 0.20]
        var retval = [Int: Double]()
        for possibleTip in possibleTipsExplicit {
            let intPct = Int(possibleTip*100)
            retval[intPct] = calcTipWithTipPctFromSubtotal(possibleTip)
        }
        return retval
        
    }

}