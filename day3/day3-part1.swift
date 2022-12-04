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

var totalPriorities = 0

for (idx, backpack) in inputArray.enumerated() {
    let backpackHalves = divideBackpackEvenly(backpack)
    print(backpackHalves)
    if let item = findSharedItems(from: backpackHalves) {
        totalPriorities += determineItemPriority(item)
    }
}

print(totalPriorities)

func divideBackpackEvenly(_ backpack: String) -> [String] {
    let middleIdx = backpack.index(backpack.startIndex, offsetBy: backpack.count / 2)
    let leftHalf = String(backpack[..<middleIdx])
    let rightHalf = String(backpack[middleIdx...])
    return [leftHalf, rightHalf]
}

func findSharedItems(from backpackHalves: [String]) -> Character? {
    guard backpackHalves.count == 2 else { return nil }
    let (left, right) = (backpackHalves[0], backpackHalves[1])
    
    for idx in 0 ..< left.count {
        let currentIdx = left.index(left.startIndex, offsetBy: idx)
        
        let currentLeftChar = left[currentIdx]
        let currentRightChar = right[currentIdx]

        if right.contains(currentLeftChar) {
            return currentLeftChar
        }

        if left.contains(currentRightChar) {
            return currentRightChar
        }
    }
    return nil
}

func determineItemPriority(_ item: Character) -> Int {
    let alphabet: [Character] = ["a", "b", "c", "d", "e", "f", "g", "h", "i", "j", "k", "l", "m", "n", "o", "p", "q", "r", "s", "t", "u", "v", "w", "x", "y", "z", "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    if let indexInAlphabet = alphabet.firstIndex(of: item) {
        return indexInAlphabet + 1
    }
    return 0
}

// Divide every string in half
// Find the common character between the 2 parts (What if there isn't?)
// Save every shared character from every backpack, and also, determine its priority
// Sum the priority to the total Amount
