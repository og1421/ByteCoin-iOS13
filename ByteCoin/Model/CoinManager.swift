//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    func didUpdateCurrency
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "5D52932F-828A-41E2-8B8F-ADA770ECF705"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    func getCoinPrice(for currency: String) {
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        
        performRequest(with: urlString)
    }
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    print(error!)
                    return
                }
                
                if let safeData = data {
                    if let currency = parseJson(currencyData: safeData){
                        print("OK")
                    }
                }
                
            }
        }
    }
    
    func parseJson(currencyData: Data) -> CurrencyModel? {
        let decoder = JSONDecoder()
        
        do {
            let decoderData = try decoder.decode(CoinData.self, from: currencyData)
            let time = decoderData.time
            let rate = decoderData.rate
            
            let currency = CurrencyModel(time: time, rate: rate)
            
            return currency
        } catch {
//            return error
        }
    }
}
