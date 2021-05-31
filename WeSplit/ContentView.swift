//
//  ContentView.swift
//  WeSplit
//
//  Created by David Bailey on 11/05/2021.
//

import SwiftUI

struct ContentView: View {
    @State private var orderAmount = ""
    @State private var numberOfPeople = 4
    @State private var tipSelection = 1

    let tipPercentages = [0, 10, 15, 20, 25]

    var totalAmount: Double {
        let tipPercentage = Double(tipPercentages[tipSelection])
        let orderAmount = Double(self.orderAmount) ?? 0

        let tipValue = orderAmount / 100 * tipPercentage
        return orderAmount + tipValue
    }

    var amountPerPerson: Double {
        let numberOfPeople = Double(self.numberOfPeople)
        return totalAmount / numberOfPeople
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Order details")) {
                    TextField("Order amount", text: $orderAmount)
                        .keyboardType(.decimalPad)

                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2 ..< 21, id: \.self) {
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

                Section(header: Text("Total amount")) {
                    Text("£\(totalAmount, specifier: "%.2f")")
                        .foregroundColor(tipSelection == 0 ? .red : nil)
                }

                Section(header: Text("Amount per person")) {
                    Text("£\(amountPerPerson, specifier: "%.2f")")
                        .foregroundColor(tipSelection == 0 ? .red : nil)
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
