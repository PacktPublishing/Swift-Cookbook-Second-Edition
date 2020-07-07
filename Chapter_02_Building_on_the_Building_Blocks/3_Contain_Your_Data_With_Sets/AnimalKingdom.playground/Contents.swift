
let animalKingdom: Set<String> = ["dog", "cat", "pidgeon", "chimpanzee", "snake", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let vertebrates: Set<String> = ["dog", "cat", "pidgeon", "chimpanzee", "snake", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let reptile: Set<String> = ["snake"]
let mammals: Set<String> = ["dog", "cat", "chimpanzee", "kangaroo", "giraffe", "elephant", "tiger", "lion", "panther"]
let catFamily: Set<String> = ["cat", "tiger", "lion", "panther"]
let domesticAnimals: Set<String> = ["cat", "dog"]

print(mammals.isSubset(of: animalKingdom)) // true
print(mammals.isSuperset(of: catFamily)) // true

print(vertebrates.isStrictSubset(of: animalKingdom)) // false
print(mammals.isStrictSubset(of: animalKingdom)) // true
print(animalKingdom.isStrictSuperset(of: vertebrates)) // false
print(animalKingdom.isStrictSuperset(of: domesticAnimals)) // true

print(catFamily.isDisjoint(with: reptile)) // true 
