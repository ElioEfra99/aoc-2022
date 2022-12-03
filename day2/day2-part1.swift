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

func canWin(game: [String]) -> Int {
    let (rivalGame, playerGame) = (Game(game[0]), Game(game[1]))
    
    if let rivalGame, let playerGame {
        if let winner = determineWinner(player1: rivalGame, player2: playerGame) {
            if winner == playerGame {
                return 6 + playerGame.rawValue
            } else {
                return playerGame.rawValue
            }
        } else {
            return 3 + playerGame.rawValue
        }
    }
    return 0
}

func determineWinner(player1: Game, player2: Game) -> Game? {
    if player1 == .rock && player2 == .paper {
        return player2
    } else if player1 == .paper && player2 == .paper {
        return nil
    } else if player1 == .scissors && player2 == .paper {
        return player1
    } else if player1 == .rock && player2 == .rock {
        return nil
    } else if player1 == .paper && player2 == .rock {
        return player1
    } else if player1 == .scissors && player2 == .rock {
        return player2
    } else if player1 == .rock && player2 == .scissors {
        return player1
    } else if player1 == .paper && player2 == .scissors {
        return player2
    } else if player1 == .scissors && player2 == .scissors {
        return nil
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
