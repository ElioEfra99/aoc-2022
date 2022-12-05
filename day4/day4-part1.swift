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

for (idx, input) in inputArray.enumerated() {
    var ranges = [[Int]]()
    
    Array(input.split(separator: ",")).map { String($0) }.forEach { range in
        
        let rangeArray = Array(range.split(separator: "-")).map { Int($0)! }
        ranges.append(rangeArray)
    }
    
    let range1 = ranges[0]
    let range2 = ranges[1]
    
    if range1[0] <= range2[0] && range1[1] >= range2[1] {
        // Range 1 contains all of range 2 sections
        totalAssignmentPairsContainingAnotherPair += 1
        continue
    }
    
    if range2[0] <= range1[0] && range2[1] >= range1[1] {
        totalAssignmentPairsContainingAnotherPair += 1
        continue
    }
}

print(totalAssignmentPairsContainingAnotherPair)
