
class MovieReview {
    let movieTitle: String
    var starRating: Int // Rating out of 5
    init(movieTitle: String, starRating: Int) {
        self.movieTitle = movieTitle
        self.starRating = starRating
    }
}

// Write a review
let shawshankReviewOnYourWebsite = MovieReview(movieTitle: "Shawshank Redemption", starRating: 3)

// Post it to social media
let reviewLinkOnTwitter = shawshankReviewOnYourWebsite
let reviewLinkOnFacebook = shawshankReviewOnYourWebsite

print(reviewLinkOnTwitter.starRating) // 3
print(reviewLinkOnFacebook.starRating) // 3

// Reconsider my review
shawshankReviewOnYourWebsite.starRating = 5

// The change visible from anywhere with a reference to the object
print(reviewLinkOnTwitter.starRating) // 5
print(reviewLinkOnFacebook.starRating) // 5
