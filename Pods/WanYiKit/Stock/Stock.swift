//
//  Stock.swift
//  demoPractice
//
//  Created by Jason on 11/1/2021.
//

import Foundation

public struct Stock {
    
    public var buyPrice:Double = 0
    public var soldPrice:Double = 0
    public var hands:Double = 0

    public var comission:Double {
        
        return buyPrice*hands*0.001 + 10 + 1
        
    }
    
    public var win:Double {
        
        let winMoney = (soldPrice-buyPrice)*hands - comission
        let winPrice = buyPrice + comission/hands
        print("Buy: \(buyPrice) Sold: \(soldPrice) Comission: \(comission)   Win:\(winMoney) WinFrom: \(winPrice)\n")
        
        return winMoney
    }
    
    public init(buyPrice:Double, soldPrice:Double, hands:Double) {
        self.buyPrice = buyPrice
        self.soldPrice = soldPrice
        self.hands = hands
    }
    
    public init(buyPrice:Double, hands:Double){
        self.buyPrice = buyPrice
        self.hands = hands
        let comission = buyPrice*hands*0.001 + 10 + 1
        let winPrice = buyPrice + comission/hands
        print("Buy: \(buyPrice)  WinFrom: \(winPrice)\n   Comission: \(comission)")
    }
    
    public init(soldPrice:Double, hands:Double ){
        self.soldPrice = soldPrice
        let comission = buyPrice*hands*0.001 + 10 + 1
        let winPrice = soldPrice - comission/hands
        
        print("Sold: \(soldPrice)  should buy no more than: \(winPrice)\n   Comission: \(comission)")
    }
    
    
    func howTOWin(Yuan amount:Double){
        
        
        print("You can win \(amount)Yuan by solding at ")
    }

}
