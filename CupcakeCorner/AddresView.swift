//
//  AddresView.swift
//  CupcakeCorner
//
//  Created by Hubert Wojtowicz on 15/07/2023.
//

import SwiftUI

struct AddresView: View {
    @ObservedObject var order: Order
    var body: some View {
        Form {
            Section {
                TextField("Name", text: $order.information.name)
                TextField("StreetAddress", text: $order.information.streetAddress)
                TextField("City", text: $order.information.city)
                TextField("Zip", text: $order.information.zip)
            }
            
            Section {
                NavigationLink{
                    CheckoutView(order: order)
                } label: {
                    Text("Check out")
                }
            }
            .disabled(order.information.hasValidAddress == false)
        }
        .navigationTitle("Delivery details")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct AddresView_Previews: PreviewProvider {
    static var previews: some View {
        AddresView(order: Order())
    }
}
