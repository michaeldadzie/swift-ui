import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var resetScore = false
    @State private var scoreTitle = ""
    @State private var score = 0.0
    @State private var onTapped = 0.0
     
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)

    
    var body: some View {
        ZStack {
            
            RadialGradient(stops: [.init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3), .init(color: .red, location: 0.3)], center: .top, startRadius: 200, endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                Spacer()
                Text("Flagaroo")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.bold))
                    }
                    
                    ForEach(0..<3) {number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .renderingMode(.original)
                                .clipShape(RoundedRectangle(cornerRadius: 10))
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 40)
                .background(.regularMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 20))

                
                Text("Score: \(Int(score))")
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                Spacer()
            }
            .padding(50)
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue") {}
        }
        .alert("Game over", isPresented: $resetScore) {
            Button("Reset", action: resetQuestions)
        } message: {
            Text("Your score is: \(Int(score))")
        }
    }
    
    func flagTapped(_ number: Int) {
        if number == correctAnswer {
            score += 1
        } else {
            showingScore = true
            scoreTitle = "Wrong that's flag of \(countries[number])"
        }
        
        askQuestion()
        onTapped += 1
        if (onTapped == 8) {
            resetScore = true
        }
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func resetQuestions() {
        askQuestion()
        score = 0
        onTapped = 0
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
