
enum CompassPoint {
    case north
    case south
    case east
    case west
}

func lookTowards(_ direction: CompassPoint) {
    
    switch direction {
    case .north:
        print("To the north lies a winding road")
    case .south:
        print("To the south is the Prancing Pony tavern")
    case .east:
        print("To the east is a blacksmith")
    case .west:
        print("The the west is the town square")
    }
}

lookTowards(.south) // To the south is the Prancing Pony tavern

enum Item {
    case key
    case lockedDoor
    case openDoor
    case bluntKnife
    case sharpeningStone
    case sharpKnife
}

func combine(_ firstItem: Item, with secondItem: Item) -> Item? {
    
    switch (firstItem, secondItem) {
    case (.key, .lockedDoor), (.lockedDoor, .key):
        print("You have unlocked the door!")
        return .openDoor
    case (.bluntKnife, .sharpeningStone), (.sharpeningStone, .bluntKnife):
        print("Your knife is now sharp")
        return .sharpKnife
    default:
        print("\(firstItem) and \(secondItem) cannot be combined)")
        return nil
    }
}

let door1 = combine(.key, with: .lockedDoor) // openDoor
let door2 = combine(.lockedDoor, with: .key) // openDoor
let oilAndWater = combine(.bluntKnife, with: .lockedDoor) // nil

enum Character: String {
    case wizard
    case bartender
    case dragon
}

func say(_ textToSay: String, to character: Character? = nil) {
    
    switch (textToSay, character) {
    case ("abracadabra", .wizard?):
        print("The wizard says, \"Hey, that's my line!\"")
    case ("Pour me a drink", .bartender?):
        print("The bartender pours you a drink")
    case ("Can I have some of your gold?", .dragon?):
        print("The dragon burns you to death with his firey breath")
    case (let textSaid, nil):
        print("You say \"\(textSaid)\", to no-one.")
    case (_, let anyCharacter?):
        print("The \(anyCharacter) looks at you, blankly")
    }
}
say("Is anybody there?") // You say "Is anybody there?", to no-one.
say("Pour me a drink", to: .bartender) // The bartender pours you a drink
say("Can I open a tab?", to: .bartender) // The bartender looks at you, blankly

