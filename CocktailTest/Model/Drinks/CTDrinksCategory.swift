

import Foundation
import Unbox

class CTDrinksCategory: NSObject, Unboxable {
    
    
    private var keyName = CTConstants.drinksKeyName
    private var keyImage = CTConstants.drinksKeyImage
    
    var drinkStr: String = ""
    var drinkImg: String = ""
    
    
    override var description: String {
        return "[\(drinkStr), \(drinkImg)]"
    }
    
    required init(unboxer: Unboxer) throws {
        self.drinkStr = try unboxer.unbox(key: keyName)
        self.drinkImg = try unboxer.unbox(key: keyImage)
    }
    
    init(drinkStr: String, drinkImg: String) {
        self.drinkStr = drinkStr
        self.drinkImg = drinkImg
    }
    
    func getDrink() -> CTDrink {
        return CTDrink(name: self.drinkStr, image: self.drinkImg)
    }
}

