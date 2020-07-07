
enum Title {
    case mr
    case mrs
    case mister
    case miss
    case dr
    case prof
    case other(String)
}

let mister: Title = .mr
let dame: Title = .other("Dame")
