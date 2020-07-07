
struct ClockTime {
    var hours: Int
    var minutes: Int
}

class DailyEvent {
    var name: String
    var time: ClockTime
    
    init(name: String, time: ClockTime) {
        self.name = name
        self.time = time
    }
}

// Reference Semantics

var event1 = DailyEvent(name: "have bath", time: ClockTime(hours: 20, minutes: 00))
var event2 = event1
print("Event 1 - \(event1.name)") // have bath
print("Event 2 - \(event2.name)") // have bath
event1.name = "have shower"
print("Event 1 - \(event1.name)") // have shower
print("Event 2 - \(event2.name)") // have shower

// Value Semantics

let defaultEventTime = ClockTime(hours: 6, minutes: 30)
var event1Time = defaultEventTime // 6:30
var event2Time = defaultEventTime // 6:30
// Event 2 has been moved to 9:30
event2Time.hours = 9
print("Event 1 - \(event1Time.hours):\(event1Time.minutes)") // Event 1 - 6:30
print("Event 2 - \(event2Time.hours):\(event2Time.minutes)") // Event 2 - 9:30
