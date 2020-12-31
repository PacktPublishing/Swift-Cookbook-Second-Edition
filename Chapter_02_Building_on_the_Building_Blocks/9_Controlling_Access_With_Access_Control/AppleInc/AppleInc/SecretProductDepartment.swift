
class SecretProductDepartment {
    
    private var secretCodeWord = "Titan"
    private var secretProducts = ["Apple Glasses",
                                  "Apple Car",
                                  "Apple Brain Implant"] 
    
    func nextProduct(givenCodeWord codeWord: String) -> String? {
        let codeCorrect = codeWord == secretCodeWord
        return codeCorrect ? secretProducts.first : nil
    }
}
