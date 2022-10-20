import UIKit

//print(testArray)
var starting = 0
var starting2 = 1

func bubbleSort() -> [Int]{
    var testArray = [1,4,2,5,7,3,8,6,10,9]
    var sortedArray: [Int] = []
    var higherVal = 0
    var lowerVal = 0
    
        if starting2 <= testArray.count - 1 {
            print(testArray)
            if testArray[starting] > testArray[starting2] {
                print("Currently working on positon 1 \(starting) and position 2 \(starting2)")
                sortedArray = testArray
                print("Made it to the first swap")
                higherVal = testArray[starting2]
                print(higherVal)
                lowerVal = testArray[starting]
                print(lowerVal)
                sortedArray[starting] = higherVal
                sortedArray[starting2] = lowerVal
                starting = starting + 1
                starting2 = starting2 + 1
                testArray = sortedArray
                print("This work?",testArray)
                bubbleSort()
            }
            starting = starting + 1
            starting2 = starting2 + 1
            bubbleSort()
        } else {
            print("made it to runagain false")
    }
    return testArray
}

bubbleSort()
