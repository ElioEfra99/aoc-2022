import Foundation

let fileName = "input4"
let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
var readString = ""

do {
    readString = try String(contentsOf: fileURL)
} catch let error as NSError {
    print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
}

var inputArray = Array(readString.split(separator: "\n")).map { String($0) }
var rawPairs = [String]()

var totalAssignmentPairsContainingAnotherPair = 0

for input in inputArray {
    var ranges = [[Int]]()
    
    Array(input.split(separator: ",")).map { String($0) }.forEach { range in
        
        let rangeArray = Array(range.split(separator: "-")).map { Int($0)! }
        ranges.append(rangeArray)
    }
    
    let range1 = ranges[0][0] ... ranges[0][1]
    let range2 = ranges[1][0] ... ranges[1][1]
    
    if range1.overlaps(range2) {
        totalAssignmentPairsContainingAnotherPair += 1
    }
}

print(totalAssignmentPairsContainingAnotherPair)
