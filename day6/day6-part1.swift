import Foundation

let fileName = "input6"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var lastFourCharacters = Array<Character>()
var uniqueCharactersWereFound = false

// This algorithm has a flaw, you would need to compare at the end of the for loop whether or not the last array state contains 4 unique characters, because if the 4 unique characters were the last ones in readString, you would miss that comparison.
for (idx, char) in readString.enumerated() {
    if lastFourCharacters.count == 4 {
        // You compare the previous array state, not using the current character in readString, that one is appended after you compare previous state
        if isCharacterArrayUnique(lastFourCharacters) {
            print("Characters processed when marker was found: \(idx)")
            uniqueCharactersWereFound = true
            break
        } else {
            lastFourCharacters.removeFirst()
        }
    }
    lastFourCharacters.append(char)
}

// Figure out whether last 4 characters in the lastFourCharacters array were unique.
if !uniqueCharactersWereFound && isCharacterArrayUnique(lastFourCharacters) {
    print("Characters processed when marker was found: \(readString.count)")
}

func isCharacterArrayUnique(_ array: [Character]) -> Bool {
    for i in 0 ..< 3 {
        for j in i + 1 ..< 4 {
            if array[i] == array[j] {
                return false
            }
        }
    }
    return true
}
