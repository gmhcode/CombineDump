import UIKit
import Combine



    let isReady = PassthroughSubject<Void,Never>()
    
    let taps = PassthroughSubject<Int,Never>()
    
    taps.drop(untilOutputFrom: isReady).sink {
        print($0)
    }
    
    print("About to tap")
    (1...10).forEach { i in
//            print("tapping: ",i)
        taps.send(i)
//            print("Tapped: ",i)
        
        if i == 3 {
//                print("isReady is about to send")
            isReady.send()
//                print("isReady Sent")
        }
    }
