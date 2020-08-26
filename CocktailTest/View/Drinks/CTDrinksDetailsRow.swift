//
//  CTDrinksDetailsRow.swift
//  CocktailTest
//
//  Created by Sailor on 22/08/2020.
//  Copyright © 2020 Daniel Moraleda. All rights reserved.
//

import SwiftUI
@available(iOS 13.0, *)

struct CTDrinksDetailsRow: View {
    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    var DrinkOnly : CTDrinksCategory
    
    var body: some View {
        HStack{
            ImageView(withURL: DrinkOnly.drinkImg)
            Text(DrinkOnly.drinkStr)
                .font(.custom(CTConstants.avenirFont, size: 20))
                .fontWeight(.medium)
        }
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }
    var body: some View {
        VStack {
            Image(uiImage: imageLoader.data != nil ? UIImage(data:imageLoader.data!)! : UIImage())
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width:100, height:100)
        }
    }
}
