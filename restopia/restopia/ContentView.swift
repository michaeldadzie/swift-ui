import SwiftUI
import CoreML

struct ContentView: View {
    @State private var sleepAmount = 6.0
    @State private var coffeAmount = 1
    @State private var recommended = defaultWakeTime.formatted(date: .omitted, time: .shortened)
    @State private var wakeUp = defaultWakeTime
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false
    
    let coffeeCups = [1, 2, 3, 4, 5, 6, 7, 8]
    
    static var defaultWakeTime: Date {
        var components = DateComponents()
        components.hour = 7
        components.minute = 0
        return Calendar.current.date(from: components) ?? Date.now
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    DatePicker("Please enter a time", selection: $wakeUp, displayedComponents: .hourAndMinute)
                        .onChange(of: wakeUp, perform: {value in calculateBedtime()})
                } header: {
                    Text("When do you want to wake up?")
                }
                Section {
                    Stepper("\(sleepAmount.formatted()) hours", value: $sleepAmount, in: 4...12, step: 0.25, onEditingChanged: { editing in calculateBedtime()})
                } header: {
                    Text("Desired amount of sleep")
                }
                Section {
                    Picker("Tip percentage", selection: $coffeAmount) {
                        ForEach(coffeeCups, id: \.self) {
                            Text($0, format: .number)
                        }
                    }
                    .pickerStyle(.segmented)
                    .onChange(of: coffeAmount, perform: {value in calculateBedtime()})
                } header: {
                    Text("Daily coffee intake")
                }
                Section {
                    Text("\(recommended)")
                } header: {
                    Text("Recommended bedtime")
                }
                /* Text("^[\(coffeAmount.formatted()) cup](inflect: true)")*/
            }
            .navigationTitle("Restopia")
            /*.toolbar {
                Button("Calculate", action: calculateBedtime)
            }*/
            .alert(alertTitle, isPresented: $showingAlert) {
                Button("Continue") {}
            } message: {
                Text(alertMessage)
            }
        }
    }
    
    func calculateBedtime() {
        do {
            let config = MLModelConfiguration()
            let model = try Restopia(configuration: config)
            
            let components = Calendar.current.dateComponents(([.hour, .minute]), from: wakeUp)
            let hour = (components.hour ?? 0) * 60 * 60
            let minute = (components.minute ?? 0) * 60
            
            let prediction =  try model.prediction(wake: Double(hour + minute), estimatedSleep: sleepAmount, coffee: Double(coffeAmount))
            let sleepTime = wakeUp - prediction.actualSleep
            recommended = sleepTime.formatted(date: .omitted, time: .shortened)
        } catch {
            showingAlert = true
            alertTitle = "Error"
            alertMessage = "Sorry, there was a problem calculating your bedtime"
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
