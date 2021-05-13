//
//  ContentView.swift
//  WeSplit
//
//  Created by David Bailey on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var orderAmount = ""
    @State private var numberOfPeople = 2
    @State private var tipSelection = 1

    let tipPercentages = [0, 10, 15, 20, 25]

    var totalPerPerson: Double {
        let numberOfPeople = Double(self.numberOfPeople + 2)
        let tipPercentage = Double(tipPercentages[tipSelection])
        let orderAmount = Double(self.orderAmount) ?? 0

        let tipValue = orderAmount / 100 * tipPercentage
        let grandTotal = orderAmount + tipValue
        return grandTotal / numberOfPeople
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order details")) {
                    TextField("Order amount", text: $orderAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 21) {
                            Text("\($0) people")
                        }
                    }
                }

                Section(header: Text("Tip selection")) {
                    Picker("Tip percentage", selection: $tipSelection) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total per person")) {
                    Text("£\(totalPerPerson, specifier: "%.2f")")
                }
            }
            .navigationBarTitle("WeSplit")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
