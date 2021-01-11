
import Foundation

struct Stock {
    
    var buyPrice:Double = 0
    var soldPrice:Double = 0
    var hands:Double = 0

    var comission:Double {
        
        return buyPrice*hands*0.001 + 10 + 1
        
    }
    
    var win:Double {
        
        let winMoney = (soldPrice-buyPrice)*hands - comission
        let winPrice = buyPrice + comission/hands
        print("Buy: \(buyPrice) Sold: \(soldPrice) Comission: \(comission) WinFrom: \(winPrice)\n   Win:\(winMoney)")
        
        return winMoney
    }
    
    init(buyPrice:Double, soldPrice:Double, hands:Double) {
        self.buyPrice = buyPrice
        self.soldPrice = soldPrice
        self.hands = hands
    }
    

}
