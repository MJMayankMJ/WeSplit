//
//  ContentView.swift
//  FormApp
//
//  Created by Mayank Jangid on 7/29/24.
//

import SwiftUI

struct ContentView: View {
    
    @State private var checkAmount = 0.0
    @State private var noOfPeople = 2
    @State private var tipPercentage = 15
    @FocusState private var isFocused : Bool
     
    let tipPercentages = 0..<101
    
    var total : Double {
        let tipPercent = Double(tipPercentage)
        let totalTip = checkAmount * (tipPercent/100)
        let totaL = checkAmount + totalTip
        return totaL
    }

    var totalPerPerson : Double {
        let peopleCount = Double(noOfPeople + 1) //cz the ForEach starts from 1..<100 and the 0th would be 2 but the 1th would be 3 so we have to add 1 to offset that
        return (total / peopleCount)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section{
                    TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                        .keyboardType(.decimalPad)
                        .focused($isFocused)
                    Picker("Number of People", selection: $noOfPeople) {
                        ForEach(1..<100) {
                            Text("\($0) People")
                        }
                    }
                }
                Section("Tip Percent"){
                    Picker("Tip Percentage",selection: $tipPercentage){
                        ForEach(tipPercentages, id: \.self){
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                }
                Section("Amount per person") {
                    Text(totalPerPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
                .toolbar{
                    if isFocused {
                        Button("Done") {
                            isFocused = false
                        }
                    }
                }
                .navigationTitle("WeSplit")
                //It’s tempting to think that modifier should be attached to the end of the NavigationStack, but it needs to be attached to the end of the Form instead. The reason is that navigation stacks are capable of showing many views as your program runs, so by attaching the title to the thing inside the navigation stack we’re allowing iOS to change titles freely.
                Section("Total"){
                    Text(total, format:  .currency(code: Locale.current.currency?.identifier ?? "USD"))
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
