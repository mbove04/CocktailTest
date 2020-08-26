
import Foundation
import Unbox

class CTDrinksList: NSObject, Unboxable {
    
    private let key = CTConstants.drinksListKey
    
    private var drinksList: [CTDrinksCategory]?
    
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: key)
    }
    
    func getDrinksList() -> [CTDrinksCategory]? {
        return drinksList
    }
}
