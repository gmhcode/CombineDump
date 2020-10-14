import UIKit


let numbers = (1...100).publisher

numbers.dropFirst(50)
    .prefix(20)
    .filter({$0 % 2 == 0})
    .sink {
    print($0)
}
//output should be
//52
//54
//56
//58
//60
//62
//64
//66
//68
//70
