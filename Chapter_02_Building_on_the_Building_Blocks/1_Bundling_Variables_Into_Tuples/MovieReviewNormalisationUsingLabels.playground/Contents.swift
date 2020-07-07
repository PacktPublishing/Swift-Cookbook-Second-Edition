
import Foundation

func normalisedStarRating(forRating rating: Float,
                          ofPossibleTotal total: Float)
                          -> (starRating: Int, displayString: String) {
    
    let fraction = rating / total
    let ratingOutOf5 = fraction * 5
    let roundedRating = round(ratingOutOf5) // Rounds to the nearest integer.
    let numberOfStars = Int(roundedRating) // Turns a Float into an Int
    let ratingString = "\(numberOfStars) Star Movie"
    return (starRating: numberOfStars, displayString: ratingString)
}

let ratingValueAndDisplayString = normalisedStarRating(forRating: 5, ofPossibleTotal: 10)

let ratingValue = ratingValueAndDisplayString.starRating
print(ratingValue) // 3 - Use to show the right number of stars

let ratingString = ratingValueAndDisplayString.displayString
print(ratingString) // "3 Star Movie" - Use to put in the label
