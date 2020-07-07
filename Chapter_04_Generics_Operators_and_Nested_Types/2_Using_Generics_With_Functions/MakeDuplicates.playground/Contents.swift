
func makeDuplicates<ItemType>(of item: ItemType, withKeys keys: Set<String>) -> [String: ItemType] {
    
    var duplicates = [String: ItemType]()
    for key in keys {
        duplicates[key] = item
    }
    return duplicates
}

let awards: Set<String> = ["Director",
                           "Cinematography",
                           "Film Editing",
                           "Visual Effects",
                           "Original Music Score",
                           "Sound Editing",
                           "Sound Mixing"]
let oscars2014 = makeDuplicates(of: "Gravity", withKeys: awards)
print(oscars2014["Director"] ?? "Unknown") // Gravity
print(oscars2014["Visual Effects"] ?? "Unknown") // Gravity
