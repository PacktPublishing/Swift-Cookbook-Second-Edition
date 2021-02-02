
enum Title: String {
    case mr = "Mr"
    case mrs = "Mrs"
    case mister = "Master"
    case miss = "Miss"
    case dr = "Dr"
    case prof = "Prof"
    case other // Inferred as "other"
    
    var isProfessional: Bool {
        return self == Title.dr || self == Title.prof
    }
}

let loganTitle = Title.mr
let xavierTitle = Title.prof

print(loganTitle.isProfessional) // false
print(xavierTitle.isProfessional) // true
