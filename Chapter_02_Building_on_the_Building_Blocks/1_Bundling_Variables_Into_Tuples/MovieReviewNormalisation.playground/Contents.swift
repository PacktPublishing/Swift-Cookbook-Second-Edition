
import Foundation

func normalisedStarRating(forRating rating: Float,
                          ofPossibleTotal total: Float) -> (Int, String) {
    
    let fraction = rating / total
    let ratingOutOf5 = fraction * 5
    let roundedRating = round(ratingOutOf5) // Rounds to the nearest integer.
    let numberOfStars = Int(roundedRating) // Turns a Float into an Int
    let ratingString = "\(numberOfStars) Star Movie"
    return (numberOfStars, ratingString)
}

let ratingValueAndDisplayString = normalisedStarRating(forRating: 5, ofPossibleTotal: 10)

let ratingValue = ratingValueAndDisplayString.0
print(ratingValue) // 3 - Use to show the right number of stars

let ratingString = ratingValueAndDisplayString.1
print(ratingString) // "3 Star Movie" - Use to put in the label

let (nextValue, nextString) = normalisedStarRating(forRating: 8, ofPossibleTotal: 10)
print(nextValue)  // 4
print(nextString) // "4 Star Movie"
