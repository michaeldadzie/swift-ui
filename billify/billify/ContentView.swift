import SwiftUI

struct ContentView: View {
    @State private var checkAmout = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercanetage = 20
    @FocusState private var amountIsFocused: Bool
    
    let tipPercentages = [0, 10, 15, 20, 25, 50]
    
    var totalPerPerson: Double {
        let peopleCount = Double(numOfPeople + 2)
        let tipSelection = Double(tipPercanetage)
        
        let tipValue = checkAmout / 100 * tipSelection
        let grandTotal = checkAmout + tipValue
        let amountPerPerson = grandTotal /  peopleCount
        
        return amountPerPerson
    }
    
    var totalAmount: Double {
        let tipSelection = Double(tipPercanetage)
        
        let tipValue = checkAmout / 100 * tipSelection
        let grandTotal = checkAmout + tipValue
        
        return grandTotal
    }
    
    var currencyCode: FloatingPointFormatStyle<Double>.Currency {
        return .currency(code: Locale.current.currency?.identifier ?? "Ghc")
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmout, format:
                            .currency(code: Locale.current.currency?.identifier ?? "Ghc"))
                            .keyboardType(.decimalPad)
                            .focused($amountIsFocused)
                    
                    Picker("Number of People", selection: $numOfPeople) {
                        ForEach(2..<10) {
                            Text("\($0) people")
                        }
                    }
                }
                
                Section {
                    Picker("Tip percentage", selection: $tipPercanetage) {
                        ForEach(tipPercentages, id: \.self) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                
                Section {
                    Text(totalAmount, format: currencyCode)
                } header: {
                    Text("Total amount")
                }
                
                Section {
                    Text(totalPerPerson, format: currencyCode)
                } header: {
                    Text("How much tip do you want to leave?")
                }
                .navigationTitle("Billify")
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
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
