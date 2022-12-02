import Foundation

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

inputArray.forEach { elfCarry in
    let maxCaloriesFromElfInventory = elfCarry.split(separator: "\n")
                                      .map { Int($0) }
                                      .compactMap { $0 }
                                      .reduce(0, +)
    
    if maxCaloriesFromElfInventory > maxCalories {
        maxCalories = maxCaloriesFromElfInventory
    }
}

print("Max calories: \(maxCalories)")
