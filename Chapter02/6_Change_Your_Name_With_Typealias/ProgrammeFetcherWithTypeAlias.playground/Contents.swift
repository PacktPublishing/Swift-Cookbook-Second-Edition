
enum Channel {
    case BBC1
    case BBC2
    case BBCNews
    //...
}

class ProgrammeFetcher {
    
    typealias FetchResultHandler = (String?, Error?) -> Void
    
    func fetchCurrentProgrammeName(forChannel channel: Channel,
                                   resultHandler: FetchResultHandler) {
        // Get next programme
        let programmeName = "Sherlock"
        resultHandler(programmeName, nil)
    }
    
    func fetchNextProgrammeName(forChannel channel: Channel,
                                resultHandler: FetchResultHandler) {
        // Get next programme
        let programmeName = "Luther"
        resultHandler(programmeName, nil)
    }
}

let fetcher = ProgrammeFetcher()
fetcher.fetchCurrentProgrammeName(forChannel: .BBC1, resultHandler: { programmeName, error in
    print(programmeName as Any)
})
