
// Sets only contain unique elements

let fibonacciArray: Array<Int> = [1, 1, 2, 3, 5, 8, 13, 21, 34]
let fibonacciSet: Set<Int> = [1, 1, 2, 3, 5, 8, 13, 21, 34]
print(fibonacciArray.count) // 10
print(fibonacciSet.count) // 9

// Insert, Remove and Contains

var animals: Set<String> = ["cat", "dog", "mouse", "elephant"]
animals.insert("rabbit")
print(animals.contains("dog")) // true
animals.remove("dog")
print(animals.contains("dog")) // false

// Union, Intersection, Symmetric Difference and Subtracting

let evenNumbers = Set<Int>(arrayLiteral: 2, 4, 6, 8, 10)
let oddNumbers: Set<Int> = [1, 3, 5, 7, 9]
let squareNumbers: Set<Int> = [1, 4, 9]
let triangularNumbers: Set<Int> = [1, 3, 6, 10]

let evenOrTriangularNumbers = evenNumbers.union(triangularNumbers) // 2, 4, 6, 8, 10, 1, 3, unordered
print(evenOrTriangularNumbers.count) // 7

let oddAndSquareNumbers = oddNumbers.intersection(squareNumbers) // 1, 9, unordered
print(oddAndSquareNumbers.count) // 2

let squareOrTriangularNotBoth = squareNumbers.symmetricDifference(triangularNumbers) // 4, 9, 3, 6, 10, unordered
print(squareOrTriangularNotBoth.count) // 5

let squareNotOdd = squareNumbers.subtracting(oddNumbers) // 4
print(squareNotOdd.count) // 1
