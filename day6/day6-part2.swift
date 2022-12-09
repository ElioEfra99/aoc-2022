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

// This algorithm is similar, but was improved in-here to avoid the strange validation there was after finishing the iteration
for (idx, char) in readString.enumerated() {
    lastFourCharacters.append(char)
    
    if lastFourCharacters.count == 14 {
        if isCharacterArrayUnique(lastFourCharacters) {
            print("Characters processed when marker was found: \(idx + 1)")
            break
        } else {
            lastFourCharacters.removeFirst()
        }
    }
}

// Here in part 2, we made an improvement, now this method is O(n log(n)), where n is the input array because
func isCharacterArrayUnique(_ array: [Character]) -> Bool {
    var copyArray = array
    copyArray.sort()
    
    for idx in 1 ..< copyArray.count {
        if copyArray[idx] == copyArray[idx - 1] {
            return false
        }
    }
    return true
}
