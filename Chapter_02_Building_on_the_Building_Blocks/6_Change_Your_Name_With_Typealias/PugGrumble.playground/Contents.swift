
struct Pug {
    let name: String
}

let pugs = [Pug]()

typealias Grumble = [Pug]

var grumble = Grumble()

let marty = Pug(name: "Marty McPug")
let wolfie = Pug(name: "Wolfgang Pug")
let poppy = Pug(name: "Poppy")
let rudy = Pug(name: "Rudy")
grumble.append(marty)
grumble.append(wolfie)
grumble.append(poppy)
grumble.append(rudy)
