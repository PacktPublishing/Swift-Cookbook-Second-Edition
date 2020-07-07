
import CoreLocation

protocol TransportMethod {
    associatedtype CollectionPoint: TransportLocation
    var defaultCollectionPoint: CollectionPoint { get }
    var averageSpeedInKPH: Double { get }
}

struct Train: TransportMethod {
    typealias CollectionPoint = TrainStation
    
    // User's home or nearest station
    var defaultCollectionPoint: CollectionPoint {
        return TrainStation.BMS
    }
    
    var averageSpeedInKPH: Double {
        return 100
    }
}

protocol TransportLocation {
    var location: CLLocation { get }
}

enum TrainStation: String, TransportLocation {
    case BMS = "Bromley South"
    case VIC = "London Victoria"
    case RAI = "Rainham (Kent)"
    case BTN = "Brighton (East Sussex)"
    // Full list of UK train stations codes can be found at
    // http://www.nationalrail.co.uk/static/documents/content/station_codes.csv
    
    var location: CLLocation {
        switch self {
        case .BMS: return CLLocation(latitude: 51.4000504, longitude: 0.0174237)
        case .VIC: return CLLocation(latitude: 51.4952103, longitude: -0.1438979)
        case .RAI: return CLLocation(latitude: 51.3663, longitude: 0.61137)
        case .BTN: return CLLocation(latitude: 50.829, longitude: -0.14125)
        }
    }
}

class Journey<TransportType: TransportMethod> {
    
    var start: TransportType.CollectionPoint
    var end: TransportType.CollectionPoint
    let method: TransportType
    var distanceInKMs: Double
    var durationInHours: Double
    
    init(method: TransportType,
         start: TransportType.CollectionPoint,
         end: TransportType.CollectionPoint) {
        self.start = start
        self.end = end
        self.method = method
        // CoreLocation provides the distance in meters,
        // so we divide by 1000 to get kilometers
        distanceInKMs = end.location.distance(from: start.location) / 1000
        durationInHours = distanceInKMs / method.averageSpeedInKPH
    }
}

let trainJourney = Journey(method: Train(), start: TrainStation.BMS, end: TrainStation.VIC)
let distanceByTrain = trainJourney.distanceInKMs
let durationByTrain = trainJourney.durationInHours
print("Journey distance: \(distanceByTrain) km")
print("Journey duration: \(durationByTrain) hours")

enum Road: TransportMethod {
    typealias CollectionPoint = CLLocation
    
    case car
    case motobike
    case van
    case hgv
    
    // The users home or current location
    var defaultCollectionPoint: CLLocation {
        return CLLocation(latitude: 51.1, longitude: 0.1)
    }
    
    var averageSpeedInKPH: Double {
        switch self {
        case .car: return 60
        case .motobike: return 70
        case .van: return 55
        case .hgv: return 50
        }
    }
}

extension CLLocation: TransportLocation {
    var location: CLLocation {
        return self
    }
}

let start = CLLocation(latitude: 51.476853, longitude: -0.0005002)
let end = CLLocation(latitude: 51.4218504, longitude: -0.0723853)
let roadJourney = Journey(method: Road.car, start: start, end: end)
let distanceByRoad = roadJourney.distanceInKMs
let durationByRoad = roadJourney.durationInHours
print("Journey distance: \(distanceByTrain) km")
print("Journey duration: \(durationByTrain) hours")
