

import Foundation
import Unbox

class CTCocktailCategory: NSObject, NSCoding, Unboxable {
    
    var categoryStr: String = ""
    private var key = CTConstants.cocktailListKey
    
    override var description: String {
        return "[\(categoryStr)]"
    }
    
    required init(unboxer: Unboxer) throws {
        self.categoryStr = try unboxer.unbox(key: key)
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.categoryStr = aDecoder.decodeObject(forKey: key) as! String
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.categoryStr, forKey: key)
    }
    
    func getCategory() -> String {
        return categoryStr
    }
    
}
