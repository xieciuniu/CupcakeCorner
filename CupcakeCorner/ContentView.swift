//
//  ContentView.swift
//  CupcakeCorner
//
//  Created by Hubert Wojtowicz on 14/07/2023.
//

import SwiftUI
// Adding Codable conformance for @Published properties
//enum CodingKeys: CodingKey {
//    case name
//}
//
//class User: ObservableObject, Codable {
//     @Published var name = "Paul Hudson"
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//        self.name = try container.decode(String.self, forKey: .name)
//    }
//
//    func encode(to encoder: Encoder) throws {
//        var conatiner = encoder.container(keyedBy: CodingKeys.self)
//        try conatiner.encode(name, forKey: .name)
//    }
//}
//
//struct Response: Codable {
//    var results: [Result]
//}
//
//struct Result: Codable {
//    var trackId: Int
//    var trackName: String
//    var collectionName: String
//}

enum CodingKeys: CodingKey {
    case type, quantity, extraFrosting, addSprinkles, name, streetAddress, city, zip, information
}

class Order: ObservableObject, Codable {
    @Published var information = OrderStruct()
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(information, forKey: .information)
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        information = try container.decode(OrderStruct.self, forKey: .information)
    }
    
    init() {}
}

struct OrderStruct: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate","Rainbow"]
    
    var type = 0
    var quantity = 3
    
    var specialRequestEnabled = false {
        didSet{
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var addSprinkles = false
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAddress: Bool {
        
        if name.trimmingCharacters(in: .whitespaces).isEmpty || streetAddress.trimmingCharacters(in: .whitespaces).isEmpty || city.trimmingCharacters(in: .whitespaces).isEmpty || zip.trimmingCharacters(in: .whitespaces).isEmpty {
            return false
        }
        
        return true
    }
    
    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2
        
        // complicated cakes cost more
        cost += (Double(type) / 2)
        
        // 1$ for frosting per cake
        if extraFrosting {
            cost += Double(quantity)
        }
        
        // 0.5$ for sprinkles per cake
        if addSprinkles {
            cost += Double(quantity) / 2
        }
        
        return cost
    }
    
//    func encode(to encoder: Encoder) throws {
//        var container = encoder.container(keyedBy: CodingKeys.self)
//
//        try container.encode(type, forKey: .type)
//        try container.encode(quantity, forKey: .quantity)
//
//        try container.encode(extraFrosting, forKey: .extraFrosting)
//        try container.encode(addSprinkles, forKey: .addSprinkles)
//
//        try container.encode(name, forKey: .name)
//        try container.encode(streetAddress, forKey: .streetAddress)
//        try container.encode(city, forKey: .city)
//        try container.encode(zip, forKey: .zip)
//    }
//
//    required init(from decoder: Decoder) throws {
//        let container = try decoder.container(keyedBy: CodingKeys.self)
//
//        type = try container.decode(Int.self, forKey: .type)
//        quantity = try container.decode(Int.self, forKey: .quantity)
//
//        extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
//        addSprinkles = try container.decode(Bool.self, forKey: .addSprinkles)
//
//        name = try container.decode(String.self, forKey: .name)
//        streetAddress = try container.decode(String.self, forKey: .streetAddress)
//        city = try container.decode(String.self, forKey: .city)
//        zip = try container.decode(String.self, forKey: .zip)
//    }
//
//    init(){ }
}

struct ContentView: View {
    //    @State private var results = [Result]()
    //    @State private var username = ""
    //    @State private var email = ""
    //    var disabledForm: Bool {
    //        username.count < 5 || email.count < 5
    //    }
    @StateObject var order = Order()
    
    var body: some View {
        
            //            AsyncImage(url: URL(string: "https://hws.dev/img/logo.png")) { image in
            //                image
            //                    .resizable()
            //                    .scaledToFit()
            //            }placeholder: {
            //                Color.red
            //            }
            //            .frame(width: 200, height: 200)
            //
            //            Form{
            //                Section {
            //                    TextField("Username", text: $username)
            //                    TextField("Email", text: $email)
            //                }
            //
            //                Section {
            //                    Button("Create account") {
            //                        print("Creating account...")
            //                    }
            //                }
            //                .disabled(disabledForm)
            //            }
            //
            //            AsyncImage(url: URL(string: "https://cdn.britannica.com/55/234355-050-6B07C130/Saltwater-crocodile.jpg")) { phase in
            //                if let image = phase.image {
            //                    image
            //                        .resizable()
            //                        .scaledToFit()
            //                } else if phase.error != nil {
            //                    Text("There was and error loading the image.")
            //                } else {
            //                    ProgressView()
            //                }
            //            }
            //            //.frame(width: 200, height: 200)
            //
            //            List(results, id: \.trackId) { item in
            //                VStack(alignment: .leading) {
            //                    Text(item.trackName)
            //                        .font(.headline)
            //                    Text(item.collectionName)
            //                }
            //            }
            //        }
            //        .task {
            //            await loadData()
            //        }
            //    }
            //
            //    func loadData() async {
            //        guard let url = URL(string: "https://itunes.apple.com/search?term=taylor+swift&entity=song") else {
            //            print("Invalid URL")
            //            return
            //        } //dodanie linku do wyszukiwania
            //
            //        do {
            //            let (data, _) = try await URLSession.shared.data(from: url)
            //            // something will be here
            //            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
            //                results = decodedResponse.results
            //                //dodanie pobranych danych do struktury Result
            //            }
            //        } catch {
            //            print("Invalid data")
            //        } // pobranie danych z linku
            //    }
        NavigationView {
            Form {
                Section {
                    Picker("Select your cake type", selection: $order.information.type) {
                        ForEach(OrderStruct.types.indices) {
                            Text(OrderStruct.types[$0])
                        }
                    }

                    Stepper("Number of cakes: \(order.information.quantity)", value: $order.information.quantity, in: 3...20)
                }
                
                Section {
                    Toggle("Any special requests?", isOn: $order.information.specialRequestEnabled.animation())
                    
                    if order.information.specialRequestEnabled {
                        Toggle("Add extra frosting", isOn: $order.information.extraFrosting)
                        
                        Toggle("Add extra sprinkles", isOn: $order.information.addSprinkles)
                    }
                }
                
                Section {
                    NavigationLink {
                        AddresView(order: order)
                    } label: {
                        Text("Delivery details")
                    }
                }
            }
            .navigationTitle("Cupcake Corner")
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
