//
//  CTDrinksDetails.swift
//  CocktailTest
//
//  Created by Sailor on 22/08/2020.
//  Copyright © 2020 Daniel Moraleda. All rights reserved.
//

import SwiftUI

@available(iOS 13.0, *)
struct CTDrinksDetails: View {
    
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
    var drinkColection : [CTDrinksCategory]
    var title: String
    
    init(drinks: [CTDrinksCategory], title: String) {
        self.drinkColection = drinks
        self.title = title
        UINavigationBar.appearance().backgroundColor = .green
    }
   
    
    var body: some View {
        NavigationView{
            List(drinkColection, id: \.self) { drinkSelect in CTDrinksDetailsRow(DrinkOnly: drinkSelect)}
                .navigationBarBackButtonHidden(false)
                .navigationBarTitle(Text(title), displayMode: .inline)
        }
    }
}





