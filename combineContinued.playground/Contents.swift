import UIKit
import Combine
let images = ["denver","houston","seattle"]
var index = 0



func getImage() -> AnyPublisher<UIImage?,Never> {
    return Future<UIImage?,Never> { promise in
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 3.0) {
            promise(.success(UIImage(named: images[index])))
        }
        
    }.print().map{ $0 }
    .receive(on: RunLoop.main)
    .eraseToAnyPublisher()
}

let taps = PassthroughSubject<Void,Never>()

let subscription = taps.map { _ in getImage() }
    .print()
    .switchToLatest()
    .sink{
        print($0 as Any)
        
    }
//denver
taps.send()

//houston: Never gets printed because it takes 3 seconds to trigger (in getImages), and seattle function begins only .5 seconds after houston.
DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
    index += 1
    taps.send()
}
//seattle
DispatchQueue.main.asyncAfter(deadline: .now() + 6.5) {
    index += 1
    taps.send()
}
