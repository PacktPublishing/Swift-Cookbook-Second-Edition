import Foundation

enum Category: String {
    case shopping = "shopping"
    case work = "work"
}

public final class TaskViewModel {
    
    var category: Category?
    var title: String?
    
    var imageUrl: URL?
    
    public convenience init(title: String, category: String) {
        self.init()
        
        self.category = Category(rawValue: category)
        self.title = title
        
        self.imageUrl = URL(string: "https://www.test.com/\(category)")
        
    }

}
