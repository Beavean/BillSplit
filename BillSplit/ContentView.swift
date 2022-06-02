//
//  ContentView.swift
//  BillSplit
//
//  Created by Beavean on 02.06.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numberOfPeople = 2
    @State private var tipPercentage = 5
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [5, 10, 15, 20, 25, 0]
    
    var amountWithTip: Double {
        let tipSelection = Double(tipPercentage + 1)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        return grandTotal
    }
    
    var totalPerPerson: Double {
        let peopleCount = Double(numberOfPeople + 2)
        let tipSelection = Double(tipPercentage + 1)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount
        return amountPerPerson
    }
    var body: some View{
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format:
                            .currency(code: Locale.current.currencyCode ?? "USD"))
                    .keyboardType(.decimalPad)
                    .focused($amountIsFocused)
                    Picker("Number of people", selection: $numberOfPeople) {
                        ForEach(2..<20) {
                            Text("\($0) peoples")
                        }
                    }
                }
                Section {
                    Picker("Tip percentage", selection: $tipPercentage) {
                        ForEach(1..<101) {
                            Text("\($0) %")
                        }
                    }
                } header: {
                    Text("How much tip do you want to leave?")
                }
                Section {
                    Text(amountWithTip, format: .currency(code: Locale.current.currencyCode ?? "UAH"))
                } header: {
                    Text("Amount with tip")
                }
                Section {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currencyCode ?? "UAH"))
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("How we split the bill")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            ContentView()
                .previewInterfaceOrientation(.portrait)
        }
    }
    
}

