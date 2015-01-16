//
//  TipCalculatorModel.swift
//  TipCalculator
//
//  Created by Michael Abdallah-Minciotti on 2015-01-15.
//  Copyright (c) 2015 Michael Abdallah-Minciotti. All rights reserved.
//

import Foundation

class TipCalculatorModel {

    var TPS: Double
    var TVQ:Double
    var subtotal: Double
    var total: Double


    init(subtotal: Double,TPS: Double, TVQ: Double) {
        self.subtotal = subtotal
        self.TPS = TPS
        self.TVQ = TVQ
        self.total = (subtotal * ((100+TPS)/100))*((100+TVQ)/100)
    }

    func calcTipWithTipPctFromTotal(tipPct: Double) -> Double {
        return total * tipPct
    }
    func calcTipWithTipPctFromSubtotal(tipPct: Double) -> Double {
        return subtotal * tipPct
    }
    func calcWithTax() -> Double {
        total = (subtotal * ((100+TPS)/100))*((100+TVQ)/100)
        return total
    }
    func calcWithOutTax() -> Double {
        subtotal = total / (((100+TPS)/100)*((100+TVQ)/100))
        return subtotal
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