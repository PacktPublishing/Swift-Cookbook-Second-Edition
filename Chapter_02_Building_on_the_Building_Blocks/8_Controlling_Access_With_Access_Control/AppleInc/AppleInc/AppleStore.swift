
public enum DeviceModel {
    case iPhoneSE
    case iPhone6
    case iPhone6Plus
    case iPhone6S
    case iPhone6SPlus
    case iPhone7
    case iPhone7Plus
}

public class AppleiPhone {
    
    public let model: DeviceModel
    
    fileprivate init(model: DeviceModel) {
        self.model = model
    }
}

fileprivate class Factory {
    func makeiPhone(ofModel model: DeviceModel) -> AppleiPhone {
        return AppleiPhone(model: model)
    }
}

public class AppleStore {
    
    private var factory = Factory()
    
    public func selliPhone(ofModel model: DeviceModel) -> AppleiPhone {
        return factory.makeiPhone(ofModel: model)
    }
}
