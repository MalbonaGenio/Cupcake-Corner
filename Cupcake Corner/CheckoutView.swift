//
//  CheckoutView.swift
//  Cupcake Corner
//
//  Created by Pau Valverde Molina on 25/11/21.
//

import SwiftUI

struct CheckoutView: View {
    
    @ObservedObject var order: Order
    
    var body: some View {
        Text("checkout view")
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
