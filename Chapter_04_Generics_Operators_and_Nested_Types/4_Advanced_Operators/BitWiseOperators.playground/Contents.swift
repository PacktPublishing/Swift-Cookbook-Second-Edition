
let zero: Int  = 0b000
let one: Int   = 0b001
let two: Int   = 0b010
let three: Int = 0b011
let four: Int  = 0b100
let five: Int  = 0b101
let six: Int   = 0b110
let seven: Int = 0b111

let phone: Int        = 1 << 0 // 0b0000001
let tablet: Int       = 1 << 1 // 0b0000010
let watch: Int        = 1 << 2 // 0b0000100
let laptop: Int       = 1 << 3 // 0b0001000
let desktop: Int      = 1 << 4 // 0b0010000
let tv: Int           = 1 << 5 // 0b0100000
let brainImplant: Int = 1 << 6 // 0b1000000

var supportedDevices: Int

// Bitwise Operators

supportedDevices = phone + tablet + tv

func isSupported(device: Int) -> Bool {
    let bitWiseANDResult = supportedDevices & device
    let containsDevice = bitWiseANDResult == device
    return containsDevice
}

let phoneSupported = isSupported(device: phone)
print(phoneSupported) // true

let brainImplantSupported = isSupported(device: brainImplant)
print(brainImplantSupported) // false

// Logical Operators

let deviceThatSupportUIKit = phone + tablet + tv
let stationaryDevices = desktop + tv
let stationaryOrUIKitDevices = deviceThatSupportUIKit | stationaryDevices
let orIsUnion = stationaryOrUIKitDevices == (phone + tablet + tv + desktop)
print(orIsUnion) // true

let onlyStationaryOrUIKitDevices = deviceThatSupportUIKit ^ stationaryDevices
let xorIsUnionMinusIntersection = onlyStationaryOrUIKitDevices == (phone + tablet + desktop)
print(xorIsUnionMinusIntersection) // true
