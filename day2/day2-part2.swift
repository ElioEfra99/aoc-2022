import Foundation

let fileName = "input2"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var inputArray = Array(readString.split(separator: "\n"))

enum Game: Int {
    case rock = 1
    case paper
    case scissors
    
    init?(_ game: String) {
        switch game {
        case "A", "X":
            self = .rock
        case "B", "Y":
            self = .paper
        case "C", "Z":
            self = .scissors
        default:
            return nil
        }
    }
}

enum ExpectedResult {
    case lose, draw, win
    
    init?(_ result: String) {
        switch result {
        case "X":
            self = .lose
        case "Y":
            self = .draw
        case "Z":
            self = .win
        default:
            return nil
        }
    }
}

func canWin(game: [String]) -> Int {
    let (rivalGame, result) = (Game(game[0]), ExpectedResult(game[1]))
    
    if let rivalGame, let result {
        if let move = determineMove(rivalPlay: rivalGame, result: result) {
            if result == .lose {
                return move.rawValue
            } else if result == .draw {
                return 3 + move.rawValue
            } else if result == .win {
                return 6 + move.rawValue
            } else {
                return 0
            }
        }
    }
    return 0
}

func determineMove(rivalPlay: Game, result: ExpectedResult) -> Game? {
    if rivalPlay == .rock && result == .lose { // Rock means I Lose
        return .scissors
    } else if rivalPlay == .rock && result == .draw { // Paper means I draw
        return .rock
    } else if rivalPlay == .rock && result == .win { // Scissors means I win
        return .paper
    } else if rivalPlay == .paper && result == .lose {
        return .rock
    } else if rivalPlay == .paper && result == .draw {
        return .paper
    } else if rivalPlay == .paper && result == .win {
        return .scissors
    } else if rivalPlay == .scissors && result == .lose {
        return .paper
    } else if rivalPlay == .scissors && result == .draw {
        return .scissors
    } else if rivalPlay == .scissors && result == .win {
        return .rock
    } else {
        return nil
    }
}

var totalScore = 0

for game in inputArray {
    let currentGame = Array(game.split(separator: " ")).map{ String($0) }
    
    totalScore += canWin(game: currentGame)
}

print(totalScore)
