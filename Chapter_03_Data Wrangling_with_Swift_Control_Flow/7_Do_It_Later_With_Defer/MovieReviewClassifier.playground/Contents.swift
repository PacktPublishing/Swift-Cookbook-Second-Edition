
enum MovieReviewClass {
    case bad
    case average
    case good
    case brilliant
}

enum ClassificationState {
    case initial
    case classifying
    case complete
}

class MovieReviewClassifier {
    
    var state: ClassificationState = .initial
    
    func classify(forStarsOutOf10 stars: Int) -> MovieReviewClass {
        
        state = .classifying
        
        defer {
            state = .complete
        }
        
        if stars > 8 {
            return .brilliant // 9 or 10
        } else if stars > 6 {
            return .good // 7 or 8
        } else if stars > 3 {
            return .average // 4, 5 or 6
        } else {
            return .bad // 1, 2 or 3
        }
    }
}

let classifier = MovieReviewClassifier()
let review1 = classifier.classify(forStarsOutOf10: 9)
print(review1) // brilliant
print(classifier.state) // complete 
