import Foundation

let fileName = "input3"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var inputArray = Array(readString.split(separator: "\n")).map { String($0) }

var groupBackpacks = [[String]]()
var tempGroupBackpacks = [String]()
var totalPriorities = 0

for (idx, backpack) in inputArray.enumerated() {
    tempGroupBackpacks.append(backpack)
    
    if (idx + 1) % 3 == 0 {
        groupBackpacks.append(tempGroupBackpacks)
        tempGroupBackpacks.removeAll()
    }
}

for backpacks in groupBackpacks {
    let badge = findItemInBackpacks(backpacks)
    
    totalPriorities += determineItemPriority(badge)
}

func findItemInBackpacks(_ backpacks: [String]) -> Character {
    let (backpack1, backpack2, backpack3) = (backpacks[0], backpacks[1], backpacks[2])
    for item in backpack1 {
        if backpack2.contains(item) && backpack3.contains(item) {
            return item
        }
    }
    
    for item in backpack2 {
        if backpack1.contains(item) && backpack3.contains(item) {
            return item
        }
    }
    
    for item in backpack3 {
        if backpack1.contains(item) && backpack2.contains(item) {
            return item
        }
    }
    
    return Character("")
}

func determineItemPriority(_ item: Character) -> Int {
    let alphabet: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    if let indexInAlphabet = alphabet.firstIndex(of: item) {
        return indexInAlphabet + 1
    }
    return 0
}

print(totalPriorities)
