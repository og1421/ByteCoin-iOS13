//
//  CurrencyModel.swift
//  ByteCoin
//
//  Created by Orlando Moraes Martins on 21/06/23.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CurrencyModel {
    let time: String
    let rate: Double
    
    var rateString: String {
        return String(format: "%.2f", rate)
    }
}
