

import Foundation
import Unbox

class CTCategoriesList: NSObject, NSCoding, Unboxable {
    
    private var key = CTConstants.drinksListKey
    private var drinksList: [CTCocktailCategory]?
    
    required init(unboxer: Unboxer) throws {
        self.drinksList = unboxer.unbox(key: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.drinksList = aDecoder.decodeObject(forKey: key) as? [CTCocktailCategory]
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.drinksList, forKey: key)
    }
    
    func getCategoriesList() -> [CTCocktailCategory]? {
        return drinksList
    }
}
