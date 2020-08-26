//
//  CTDrinksModel.swift
//  CocktailTest
//
//  Created by Sailor on 22/08/2020.
//  Copyright © 2020 Daniel Moraleda. All rights reserved.
//

import Foundation

class CTDrinksModel: NSObject {
    
    var drinkList: [CTDrinksCategory]
    
    override init() {
        self.drinkList = [CTDrinksCategory]()
        super.init()
    }
    
    func setDrinksList(catList: [CTDrinksCategory]?) {
        self.drinkList.removeAll()
        if let list = catList {
            if list.count > 0 {
                for category in list {
                    self.drinkList.append(category)
                }
            }
        }
        self.drinkList = self.drinkList.sorted(by: { $0.drinkStr < $1.drinkStr })
    }
    
    func getDrinksListCount() -> Int {
        return self.drinkList.count
    }
    
    func getDrinkForIndex(_ index: Int) -> CTDrinksCategory? {
        if self.drinkList.count > 0 {
            return self.drinkList[index]
        }
        return nil
    }
    
}
