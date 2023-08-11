import SwiftUI

struct ContentView: View {
    @State private var usedWords = [String]()
    @State private var rootWord = ""
    @State private var newWord = ""
    
    @State private var errorTitle = ""
    @State private var errorMessage = ""
    @State private var wordCount = 0
    @State private var score = 0
    @State private var resetPlay = false
    @State private var showingError = false
    @State private var textError = false
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    VStack(alignment: .leading) {
                        TextField("Enter your word", text: $newWord)
                            .autocapitalization(.none)
                            .onSubmit(addNewWord)
                        
                        if (textError) {
                            Text("Input must be at least 3 characters")
                                .foregroundColor(.red)
                        }
                    }
                }
                
                Section {
                    ForEach(usedWords, id: \.self) { word in
                        HStack {
                            Image(systemName: "\(word.count).circle")
                            Text(word)
                        }
                    }
                }
                
                Section {
                    Text("Score: \(score)")
                }
            }
            .navigationTitle(rootWord)
            .onAppear(perform: startGame)
            .toolbar {
                Button("Change", action: startGame)
            }
            .alert(errorTitle, isPresented: $showingError) {
                Button("OK", role: .cancel) {}
            } message: {
                Text(errorMessage)
            }
            .alert("Game Over", isPresented: $resetPlay) {
                Button("Restart", action: startGame)
            } message: {
                Text("Your score is: \(score)")
            }
        }
    }
    
    func addNewWord() {
        let answer = newWord.lowercased().trimmingCharacters(in: .whitespacesAndNewlines)
        guard answer.count > 0 else {
            reset()
            return
        }
        
        guard isOriginal(word: answer) else {
            reset()
            wordError(title: "Word used already", message: "Be more original")
            return
        }
        
        guard isPossible(word: answer) else {
            reset()
            wordError(title: "Word not possible", message: "You can't spell this word from '\(rootWord)!'")
            return
        }
        
        guard isReal(word: answer) else {
            reset()
            wordError(title: "Word not recognized", message: "You can't just make them up, you know!")
            return
        }
            
        withAnimation { usedWords.insert(answer, at: 0) }
        reset()
        newWord = ""
        score += 1
    }
    
    func startGame() {
        resetGame()
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt") {
            if let startWords = try? String(contentsOf: startWordsURL) {
                let allwords = startWords.components(separatedBy: "\n")
                rootWord = allwords.randomElement() ?? "silkworm"
                return
            }
        }
        fatalError("Could not load start.txt from bundle")
    }
    
    func reset() {
        wordCount += 1
        if (wordCount == 8) {
            wordCount = 0
            usedWords = []
            showingError = false
            resetPlay = true
        }
    }
    
    func resetGame() {
        score = 0
        usedWords = []
        newWord = ""
    }
    
    func isOriginal(word: String) -> Bool {
        !usedWords.contains(word)
    }
    
    func isPossible(word: String) -> Bool {
        var tempWord = rootWord
        
        for letter in word {
            if let pos = tempWord.firstIndex(of: letter) {
                tempWord.remove(at: pos)
            } else {
                return false
            }
        }
        return true
    }
    
    
    func isReal(word: String) -> Bool {
        let checker = UITextChecker()
        let range = NSRange(location: 0, length: word.utf16.count)
        let misspelledRange = checker.rangeOfMisspelledWord(in: word, range: range, startingAt: 0, wrap: false, language: "en")
        
        return misspelledRange.location == NSNotFound
    }
    
    func wordError(title: String, message: String) {
        errorTitle = title
        errorMessage = message
        showingError = true
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
