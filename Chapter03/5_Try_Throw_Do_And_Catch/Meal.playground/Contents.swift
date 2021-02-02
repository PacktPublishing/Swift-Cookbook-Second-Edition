
enum MealState {
    case initial
    case buyIngredients
    case prepareIngredients
    case cook
    case plateUp
    case serve
}

enum MealError: Error {
    case canOnlyMoveToAppropriateState
}

class Meal {
    
    private(set) var state: MealState = .initial
    
    func change(to newState: MealState) throws {
        
        switch (state, newState) {
        case (.initial, .buyIngredients),
             (.buyIngredients, .prepareIngredients),
             (.prepareIngredients, .cook),
             (.cook, .plateUp),
             (.plateUp, .serve):
            state = newState
            
        default:
            throw MealError.canOnlyMoveToAppropriateState
        }
    }
}

let dinner = Meal()
do {
    try dinner.change(to: .buyIngredients)
    try dinner.change(to: .prepareIngredients)
    try dinner.change(to: .cook)
    try dinner.change(to: .plateUp)
    try dinner.change(to: .serve)
    print("Dinner is served!")
} catch let error {
    print(error)
} 
