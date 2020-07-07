
protocol IntRepresentable {
    var intValue: Int { get }
}

extension Int: IntRepresentable {
    var intValue: Int {
        return self
    }
}

extension String: IntRepresentable {
    var intValue: Int {
        return Int(self) ?? 0
    }
}

enum CrewComplement: Int {
    case enterpriseD = 1014
    case voyager = 150
    case deepSpaceNine = 2000
}

extension CrewComplement: IntRepresentable {
    var intValue: Int {
        return rawValue
    }
}

var intableThings = [IntRepresentable]()
intableThings.append(55)
intableThings.append(1200)
intableThings.append("5")
intableThings.append("1009")
intableThings.append(CrewComplement.enterpriseD)
intableThings.append(CrewComplement.voyager)
intableThings.append(CrewComplement.deepSpaceNine)

let over1000 = intableThings.flatMap { $0.intValue > 1000 ? $0.intValue: nil }
print(over1000) 
