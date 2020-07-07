
struct Devices: OptionSet {
    
    let rawValue: Int
    
    static let phone        = Devices(rawValue: 1 << 0)
    static let tablet       = Devices(rawValue: 1 << 1)
    static let watch        = Devices(rawValue: 1 << 2)
    static let laptop       = Devices(rawValue: 1 << 3)
    static let desktop      = Devices(rawValue: 1 << 4)
    static let tv           = Devices(rawValue: 1 << 5)
    static let brainImplant = Devices(rawValue: 1 << 6)
    
    static let none: Devices = []
    static let all: Devices = [.phone, .tablet, .watch, .laptop, .desktop, .tv, .brainImplant]
    static let stationary: Devices = [.desktop, .tv]
    static let supportsUIKit: Devices = [.phone, .tablet, .tv]
}

let supportedDevices: Devices = [.phone, .tablet, .watch, .tv]

// Contains / AND and comparison
let phoneIsSupported = supportedDevices.contains(.phone)

// Union / OR
let stationaryOrUIKitDevices = Devices.supportsUIKit.union(Devices.stationary)

// Intersection / AND
let stationaryAndUIKitDevices = Devices.supportsUIKit.intersection(Devices.stationary)
