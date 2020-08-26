//
//  SheetDismisserProtocol.swift
//  CocktailTest
//
//  Created by Sailor on 22/08/2020.
//  Copyright © 2020 Daniel Moraleda. All rights reserved.
//

import Foundation
import SwiftUI

class SheetDismisserProtocol: ObservableObject {
    weak var host: UIHostingController<AnyView>? = nil

    func dismiss() {
        host?.dismiss(animated: true)
    }
}
