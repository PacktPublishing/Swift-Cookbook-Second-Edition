
// From http://idahoptv.org/ntti/nttilessons/lessons2000/lau1.html
let inputData: [[String: Any]] = [
    ["name": "Mercury", "positionFromSun": 1, "diameterInKMs": 4800, "distanceFromSunInAUs": 0.387, "hasRings": false],
    ["name": "Venus", "positionFromSun": 2, "diameterInKMs": 12100, "distanceFromSunInAUs": 0.723, "hasRings": false],
    ["name": "Earth", "positionFromSun": 3, "diameterInKMs": 12750, "distanceFromSunInAUs": 1.0, "hasRings": false],
    ["name": "Mars", "positionFromSun": 4, "diameterInKMs": 6800, "distanceFromSunInAUs": 1.524, "hasRings": false],
    ["name": "Jupiter", "positionFromSun": 5, "diameterInKMs": 142800, "distanceFromSunInAUs": 5.203, "hasRings": false],
    ["name": "Saturn", "positionFromSun": 6, "diameterInKMs": 120660, "distanceFromSunInAUs": 9.523, "hasRings": true],
    ["name": "Uranus", "positionFromSun": 7, "diameterInKMs": 51800, "distanceFromSunInAUs": 19.208, "hasRings": false],
    ["name": "Neptune", "positionFromSun": 8, "diameterInKMs": 49500, "distanceFromSunInAUs": 30.087, "hasRings": false]
]

struct Planet {
    let name: String
    let positionFromSun: Int
    let diameterInKMs: Float
    let distanceFromSunInKMs: Float
    let hasRings: Bool
}

func makePlanet(fromInput input: [String: Any]) -> Planet? {
    
    guard
        let name = input["name"] as? String,
        let positionFromSun = input["positionFromSun"] as? Int,
        let diameterInKMs = input["diameterInKMs"] as? Float,
        let distanceFromSunInKMs = input["distanceFromSunInAUs"] as? Float,
        let hasRings = input["hasRings"] as? Bool
        else {
            return nil
    }
    
    return Planet(name: name,
                  positionFromSun: positionFromSun,
                  diameterInKMs: diameterInKMs,
                  distanceFromSunInKMs: distanceFromSunInKMs,
                  hasRings: hasRings)
}

func makePlanets(fromInput input: [[String: Any]]) -> [Planet] {
    
    guard input.count > 0 else { return [] }
    
    var planets = [Planet]()
    for inputItem in input {
        guard let planet = makePlanet(fromInput: inputItem) else { continue }
        planets.append(planet)
    }
    
    return planets
}


