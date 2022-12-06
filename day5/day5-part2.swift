import Foundation

let fileName = "input5"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var inputArray = Array(readString.split(separator: "\n\n")).map { String($0) }

var matrix: [[Character]] = [["P","D","Q","R","V","B","H","F"], ["V","W","Q","Z","D","L"], ["C", "P", "R", "G", "Q", "Z", "L", "H"], ["B", "V", "J", "F", "H", "D", "R"], ["C", "L", "W", "Z"], ["M","V","G","T","N","P","R","J"], ["S","B","M","V","L","R","J"], ["J","P","D"], ["V","W","N","C","D"]]

let instructions = retrieveInstructions(from: inputArray[1])

func retrieveInstructions(from input: String) -> [[Int]] {
    var instructions = [[Int]]()
    
    let splitInstructions = Array(input.split(separator: "\n")).map { String($0) }
    
    for instruction in splitInstructions {
        let segmentedInstruction = instruction.split(separator: " ")
        instructions.append([Int(segmentedInstruction[1])!, Int(segmentedInstruction[3])!, Int(segmentedInstruction[5])!])
    }
    
    return instructions
}

for instruction in instructions {
    performInstruction(instruction, using: &matrix)
}

func performInstruction(_ instruction: [Int], using matrix: inout [[Character]]) {
    let moves = instruction[0]
    let initialPlace = instruction[1] - 1
    let targetPlace = instruction[2] - 1
    
    var tempArray = [Character]()
    
    for _ in 0 ..< moves {
        let temp = matrix[initialPlace][0]
        matrix[initialPlace].removeFirst()
        tempArray.append(temp)
    }
    
    matrix[targetPlace].insert(contentsOf: tempArray, at: 0)
}

print(matrix[0].first!, matrix[1].first!, matrix[2].first!, matrix[3].first!, matrix[4].first!, matrix[5].first!, matrix[6].first!, matrix[7].first!, matrix[8].first!)

