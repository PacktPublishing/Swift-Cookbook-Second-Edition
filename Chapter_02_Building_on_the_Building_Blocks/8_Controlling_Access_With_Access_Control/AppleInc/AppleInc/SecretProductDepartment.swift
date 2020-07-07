
class SecretProductDepartment {
    
    private var secretCodeWord = "Titan"
    private var secretProducts = ["iPhone 8",
                                  "Apple Car",
                                  "Apple Brain Implant",
                                  "Apple Spaceship"]
    
    func nextProduct(givenCodeWord codeWord: String) -> String? {
        let codeCorrect = codeWord == secretCodeWord
        return codeCorrect ? secretProducts.first : nil
    }
}
