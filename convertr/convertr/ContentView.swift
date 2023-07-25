import SwiftUI

struct ContentView: View {
    @State private var inputNumber = 0.0
    @State private var input = "Celsius"
    @State private var output = "Fahrenheit"
    @FocusState private var numberIsFocused: Bool
    
    let units = ["Celsius", "Fahrenheit", "Kelvin"]
    
    var convertedNumber: Double {
        let inputNumberValue = Double(inputNumber)
        let inputUnitVlaue = Measurement(value: inputNumberValue, unit: unitFromIndex(index: input))
        let outputUnitValue = inputUnitVlaue.converted(to: unitFromIndex(index: output))
        
        return outputUnitValue.value
    }
    
    func unitFromIndex(index: String) -> UnitTemperature {
        switch index {
        case "Celsius": return .celsius
        case "Fahrenheit": return .fahrenheit
        case "Kelvin": return .kelvin
        default: return .celsius
        }
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select unit", selection: $input) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Input unit")
                }
                
                Section {
                    Picker("Select unit", selection: $output) {
                        ForEach(units, id: \.self) {
                            Text("\($0)")
                        }
                    }
                    .pickerStyle(.segmented)
                } header: {
                    Text("Output unit")
                }
                
                Section {
                    TextField("Number", value: $inputNumber, format: .number)
                            .keyboardType(.decimalPad)
                            .focused($numberIsFocused)
                } header: {
                    Text("Input value")
                }
                
                Section {
                    Text(convertedNumber, format: .number)
                } header: {
                    Text("Converted value")
                }
                
            }
            .navigationTitle("Convertr")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        numberIsFocused = false
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
