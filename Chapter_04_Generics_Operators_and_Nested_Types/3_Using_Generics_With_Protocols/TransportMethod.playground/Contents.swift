
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
