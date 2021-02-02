
enum Channel {
    case BBC1
    case BBC2
    case BBCNews
    //...
}

class ProgrammeFetcher {
    
    func fetchCurrentProgrammeName(forChannel channel: Channel, resultHandler: (String?, Error?) -> Void) {
        // ...
        // Do the work to get the current programme
        // ...
        let programmeName = "Sherlock"
        resultHandler(programmeName, nil)
    }
    
    func fetchNextProgrammeName(forChannel channel: Channel, resultHandler: (String?, Error?) -> Void) {
        // ...
        // Do the work to get the next programme
        // ...
        let programmeName = "Luther"
        resultHandler(programmeName, nil)
    }
}
