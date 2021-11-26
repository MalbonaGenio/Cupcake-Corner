//
//  Order.swift
//  Cupcake Corner
//
//  Created by Pau Valverde Molina on 25/11/21.
//

import SwiftUI

class Order: ObservableObject, Codable {
    
    enum CodingKeys: CodingKey {
        case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, postalCode
    }
    
    static let types = ["Vanilla", "Strawberry", "Cinnamon", "Unicorn", "Classic Chocolate"]
    
    @Published var type = 0
    @Published var quantity = 3
    
    @Published var specialRequestEnabled = false {
        // runs when the value changes
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    @Published var extraFrosting = false
    @Published var addSprinkles = false
    
    @Published var name = ""
    @Published var streetAddress = ""
    @Published var city = ""
    @Published var postalCode = ""
    
    var hasValidAddress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || postalCode.isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // base price
        var cost = Double(quantity * 2)
        // price add to complex cakes
        cost += (Double(type) / 2)
        
        // frosting price
        if extraFrosting {
            cost += Double(quantity)
        }
        
        //sprinkles price
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
    //Allows to create an empty Order without any data
    init() {}
    
    //Encoder and decoder to comply with the Codable protocol
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(type, forKey: .type)
        try container.encode(quantity, forKey: .quantity)
        
        try container.encode(extraFrosting, forKey: .extraFrosting)
        try container.encode(addSprinkles, forKey: .addSprinkles)
        
        try container.encode(name, forKey: .name)
        try container.encode(streetAddress, forKey: .streetAddress)
        try container.encode(city, forKey: .city)
        try container.encode(postalCode, forKey: .postalCode)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        type = try container.decode(Int.self, forKey: .type)
        quantity = try container.decode(Int.self, forKey: .quantity)
        
        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
        
        name = try container.decode(String.self, forKey: .name)
        streetAddress = try container.decode(String.self, forKey: .streetAddress)
        city =  try container.decode(String.self, forKey: .city)
        postalCode = try container.decode(String.self, forKey: .postalCode)
    }
}
