
class UserManager {
    var currentUserName: String = "Emmanuel Goldstein" {
        willSet (newUserName) {
            print("Goodbye to \(currentUserName)")
            print("I hear \(newUserName) is on their way!")
        }
        didSet (oldUserName) {
            print("Welcome to \(currentUserName)")
            print("I miss \(oldUserName) already!")
        }
    }
}

let manager = UserManager()

manager.currentUserName = "Dade Murphy"
// Goodbye to Emmanuel Goldstein
// I hear Dade Murphy is on their way!
// Welcome to Dade Murphy
// I miss Emmanuel Goldstein already!

manager.currentUserName = "Kate Libby"
// Goodbye to Dade Murphy
// I hear Kate Libby is on their way!
// Welcome to Kate Libby
// I miss Dade Murphy already!
