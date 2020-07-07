import Foundation

func howLongUntilChristmas() -> String {
    
    let calendar = Calendar.current
    let timeZone = TimeZone.current
    
    let now = Date()
    let yearOfNextChristmas = calendar.component(.year, from: now)
    
    var christmasComponents = DateComponents(calendar: calendar,
                                             timeZone: timeZone,
                                             era: nil,
                                             year: yearOfNextChristmas,
                                             month: 12,
                                             day: 25,
                                             hour: 0,
                                             minute: 0,
                                             second: 0,
                                             nanosecond: 0,
                                             weekday: nil,
                                             weekdayOrdinal: nil,
                                             quarter: nil,
                                             weekOfMonth: nil,
                                             weekOfYear: nil,
                                             yearForWeekOfYear: nil)
    
    var christmas = christmasComponents.date!
    // If we have already had Christmas this year,
    // then we need to use Christmas next year.
    if christmas < now {
        christmasComponents.year = yearOfNextChristmas + 1
        christmas = christmasComponents.date!
    }
    
    let componentFormatter = DateComponentsFormatter()
    componentFormatter.unitsStyle = .full
    componentFormatter.allowedUnits = [.month, .day, .hour, .minute, .second]
    
    return componentFormatter.string(from: now, to: christmas)!
}

let timeUntilChristmas = howLongUntilChristmas()
print("Time until Christmas: \(timeUntilChristmas)")
