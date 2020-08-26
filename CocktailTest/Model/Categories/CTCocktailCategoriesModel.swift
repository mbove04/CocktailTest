

import Foundation

class CTCocktailCategoriesModel: NSObject {
     var categeriesList: [CTCocktailCategory]
    
    override init() {
        self.categeriesList = [CTCocktailCategory]()
        
        super.init()
    }
    
    func setCategoriesList(catList: [CTCocktailCategory]?) {
        self.categeriesList.removeAll()
        if let list = catList {
            if list.count > 0 {
                for category in list {
                    self.categeriesList.append(category)
                }
            }
        }
        self.categeriesList = self.categeriesList.sorted(by: { $0.categoryStr < $1.categoryStr })
    }
    
    func getCategoriesListCount() -> Int {
        return self.categeriesList.count
    }
    
    func getCategoryForIndex(_ index: Int) -> CTCocktailCategory? {
        if self.categeriesList.count > 0 {
            return self.categeriesList[index]
        }
        return nil
    }
}
