
enum Title: String {
    case mr = "Mr"
    case mrs = "Mrs"
    case mister = "Master"
    case miss = "Miss"
    case dr = "Dr"
    case prof = "Prof"
    case other // Inferred as "other"
} 

let title1 = Title.mr
print(title1.rawValue) // "Mr"
