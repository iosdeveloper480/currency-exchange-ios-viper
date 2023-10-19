//
//  CurrencyModel.swift
//  AlFardan
//
//  Created by EDS on 18/10/2023.
//

import Foundation

struct CurrencyModel {
    var id = UUID().uuidString
    var country: String
    var currency: String
    var value: Double = 0.0
}

struct CurrencyResponseModel: Codable {
    var rates: [String: Double]
    var ratesList = [CurrencyModel]()
    
    enum CodingKeys: String, CodingKey {
        case rates
    }
    
    init(from decoder: Decoder) throws {
        func get<V: Decodable>(from decoder: Decoder = decoder,
                               _ type: V.Type,
                               forKey: CodingKeys) throws -> V? {
            let values = try decoder.container(keyedBy: CodingKeys.self)
            if let value = try? values.decode(V.self, forKey: forKey) {
                return value
            } else {
                return nil
            }
        }
        
        self.rates = try! get([String: Double].self, forKey: .rates)!
        
        let allKeys = rates.keys
        self.ratesList = allKeys.map({CurrencyModel(country: "", currency: $0, value: self.rates[$0]!)})
    }
}
