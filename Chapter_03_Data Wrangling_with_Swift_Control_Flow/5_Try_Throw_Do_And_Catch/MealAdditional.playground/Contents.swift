
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
    case tooMuchSalt
    case wrongStateToAddSalt
}

class Meal {
    
    private(set) var state: MealState = .initial
    
    private func change(to newState: MealState) throws {
        
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
    
    func buyIngredients() throws {
        try change(to: .buyIngredients)
    }
    
    func prepareIngredients() throws {
        try change(to: .prepareIngredients)
    }
    
    func cook() throws {
        try change(to: .cook)
    }
    
    func plateUp() throws {
        try change(to: .plateUp)
    }
    
    func serve() throws {
        try change(to: .serve)
    }
    
    private(set) var saltAdded = 0
    
    func addSalt() throws {
        if saltAdded >= 5 {
            throw MealError.tooMuchSalt
        } else if case .initial = state, case .buyIngredients = state {
            throw MealError.wrongStateToAddSalt
        } else {
            saltAdded = saltAdded + 1
        }
    }
}

func makeMeal(using block: (Meal) throws -> ()) rethrows -> Meal {
    let newMeal = Meal()
    try block(newMeal)
    return newMeal
}

do {
    let dinner = try makeMeal { meal in
        try meal.buyIngredients()
        try meal.prepareIngredients()
        try meal.cook()
        try meal.addSalt()
        try meal.plateUp()
        try meal.serve()
    }
    if dinner.state == .serve {
        print("Dinner is served!")
    }
} catch MealError.canOnlyMoveToAppropriateState {
    print("It's not possible to move to this state")
} catch MealError.tooMuchSalt {
    print("Too much salt!")
} catch MealError.wrongStateToAddSalt {
    print("Can't add salt at this stage")
} 
