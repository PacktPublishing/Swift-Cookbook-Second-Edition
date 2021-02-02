
enum ClassificationState {
    case initial
    case classifying
    case complete
}

enum MovieReviewClass {
    case bad
    case average
    case good
    case brilliant
}

class MovieReviewClassifier {
    
    var state: ClassificationState = .initial
    
    func classify(forStarsOutOf10 stars: Int) -> MovieReviewClass {
        
        precondition(state == .initial, "Classifier state must be initial before classifying")
        
        state = .classifying
        
        defer {
            state = .complete
        }
        
        if stars > 8 && stars <= 10 {
            return .brilliant // 9 or 10
        } else if stars > 6 {
            return .good // 7 or 8
        } else if stars > 3 {
            return .average // 4, 5 or 6
        } else if stars > 0 {
            return .bad // 1, 2 or 3
        } else {
            fatalError("Star rating must be between 1 and 10")
        }
    }
}

let classifier = MovieReviewClassifier()
let review1 = classifier.classify(forStarsOutOf10: 9)
print(review1) // brilliant
print(classifier.state) // complete
