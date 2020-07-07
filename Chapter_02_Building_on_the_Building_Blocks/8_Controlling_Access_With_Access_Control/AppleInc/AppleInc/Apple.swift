
public class Person {
    
    public let name: String
    
    public init(name: String) {
        self.name = name
    }
}

public class Apple {
    
    public private(set) var ceo: Person
    private var employees = [Person]()
    public let store = AppleStore()
    private let secretDepartment = SecretProductDepartment()
    
    public init() {
        ceo = Person(name: "Tim Cook")
        employees.append(ceo)
    }
    
    public func newEmployee(person: Person) {
        employees.append(person)
    }
    
    func weeklyProductMeeting() {
        
        var superSecretProduct = secretDepartment.nextProduct(givenCodeWord: "Not sure... Abracadabra?") // nil
        
        // Try again
        superSecretProduct = secretDepartment.nextProduct(givenCodeWord: "Titan") // "iPhone 8"
        print(superSecretProduct as Any)
    }
}
