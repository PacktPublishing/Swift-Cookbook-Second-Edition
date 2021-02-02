
class Device {
    
    enum Category {
        case watch
        case phone
        case tablet
    }
    
    enum Orientation {
        case portrait
        case portraitUpsideDown
        case landscapeLeft
        case landscapeRight
    }
    
    let category: Category
    var currentOrientation: Orientation = .portrait
    
    init(category: Category) {
        self.category = category
    }
}

let phone = Device(category: .phone)
let desiredOrientation: Device.Orientation = .portrait
let phoneHasDesiredOrientation = phone.currentOrientation == desiredOrientation

struct UserInterface {
    
    struct Version {
        let major: Int
        let minor: Int
        let patch: Int
    }
    
    enum Orientation {
        case portrait
        case landscape
    }
    
    let version: Version
    var orientation: Orientation
}

func uiOrientation(for deviceOrientation: Device.Orientation) -> UserInterface.Orientation {
    switch deviceOrientation {
    case Device.Orientation.portrait, Device.Orientation.portraitUpsideDown:
        return UserInterface.Orientation.portrait
    case Device.Orientation.landscapeLeft, Device.Orientation.landscapeRight:
        return UserInterface.Orientation.landscape
    }
}
let phoneUIOrientation = uiOrientation(for: phone.currentOrientation)
print(phoneUIOrientation) // UserInterface.Orientation.portrait
