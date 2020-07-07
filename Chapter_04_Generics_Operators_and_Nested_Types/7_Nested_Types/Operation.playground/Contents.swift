
class Operation {
    
    let doctorsName: String
    let patientsName: String
    
    init(doctorsName: String, patientsName: String) {
        self.doctorsName = doctorsName
        self.patientsName = patientsName
    }
}

import Foundation

let medicalOperation = Operation(doctorsName: "Dr. Crusher", patientsName: "Commander Riker")
let longRunningOperation = Foundation.Operation()
