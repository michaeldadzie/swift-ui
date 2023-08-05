import SwiftUI

struct ContentView: View {
    var moves = ["Rock", "Paper", "Scissors"]
    
    @State private var appMove = Int.random(in: 0..<3)
//    @State private var shouldWin = Bool.random()
    @State private var resetScore = false
    @State private var score = 0
    @State private var totalMoves = 0

    
    var body: some View {
        VStack {
            
            Text("Move: \(moves[appMove])")
            
            HStack() {
                Button("Rock") {
                    checkMove(1)
                }
                Button("Paper") {
                    checkMove(2)
                }
                Button("Scissors") {
                    checkMove(3)
                }
            }.padding()
            
            Text("Score: \(Int(score))")
        }
        .alert("Game over", isPresented: $resetScore) {
            Button("Reset", action: resetMoves)
        } message: {
            Text("Your score is: \(score)")
        }
    }
    
    func checkMove(_ playerMove: Int) {
        let appMove = self.appMove
//        let shouldWin =  self.shouldWin
        if (/*shouldWin &&*/(appMove + 1) % 3 == playerMove) ||
            (/*!shouldWin &&*/(playerMove + 1) % 3 == appMove) {
             score += 1
        } else {
            score -= 1
        }
        nextMove()
        totalMoves += 1
        if (totalMoves == 10) {
            resetScore = true
        }
    }
    
    func nextMove() {
        appMove = Int.random(in: 0..<3)
//        shouldWin.toggle()
    }
    
    func resetMoves() {
        score = 0
        totalMoves = 0
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
