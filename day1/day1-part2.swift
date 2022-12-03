import Foundation

func getIndexFrom(number: Int, inside array: [Int]) -> Int? {
    for (idx, num) in array.enumerated() {
        if num == number {
            return idx
        }
    }
    return nil
}

let fileName = "input1"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var inputArray = Array(readString.split(separator: "\n\n"))

var maxCalories = 0
var calories = [Int]()

// Solution 1, get every amount of calories into an array
//inputArray.forEach { elfCarry in
//    let maxCaloriesFromCurrentElfInventory = elfCarry.split(separator: "\n")
//                                                     .map { Int($0) }
//                                                     .compactMap { $0 }
//                                                     .reduce(0, +)
//
//    calories.append(maxCaloriesFromCurrentElfInventory)
//}

// When you're done adding them all, iterate as long as you have more than 3, and remove the smallest amount of calories
//while calories.count > 3 {
//    let min = calories.min()!
//    let index = getIndexFrom(number: min, inside: calories)!
//    calories.remove(at: index)
//}

// Ta-dah! You have the top 3 elves with most calories
//print("Total amount of most calories from top 3 elves: \(calories.reduce(0, +))")

// Solution 2,

func updateLargest(array: inout [Int?], number: Int) {
    for idx in stride(from: array.count - 1, through: 0, by: -1) {
        if let validLargest = array[idx] {
            if number > validLargest {
                shiftAndUpdate(&array, number, idx)
                return
            }
        } else {
            array[idx] = number
            break
        }
    }
}

func shiftAndUpdate(_ array: inout [Int?], _ newNumber: Int, _ replacementIdx: Int) {
    // Iterate from 0 through the idx we got
    // We iterate from 0 through the number instead of going backwards because we don't want to afect numbers that are
    // AFTER the replacementIdx. Traversing backwards could compromise numbers to the right
    
    for idx in 0 ..< replacementIdx + 1 {
        if idx == replacementIdx {
            array[idx] = newNumber
        } else {
            array[idx] = array[idx + 1]
        }
    }
}

var largestCalories = Array<Int?>(repeating: nil, count: 3)

inputArray.forEach { elfCarry in
    let maxCaloriesFromCurrentElfInventory = elfCarry.split(separator: "\n")
                                                     .map { Int($0) }
                                                     .compactMap { $0 }
                                                     .reduce(0, +)

    updateLargest(array: &largestCalories, number: maxCaloriesFromCurrentElfInventory)
}

let nonOptionalLargest = largestCalories.compactMap { $0 }

print("Top three elves are carrying: \(nonOptionalLargest.reduce(0,+)) total calories")
