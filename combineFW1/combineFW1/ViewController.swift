//
//  ViewController.swift
//  combineFW1
//
//  Created by Greg Hughes on 10/12/20.
//

import UIKit
import Combine



class ViewController: UIViewController {

    var subs = [AnyCancellable]()
    
    @Published var bar = (1...29)
    override func viewDidLoad() {
        super.viewDidLoad()
        combLatest()
  
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        barChanged()
    }
    func publishedExample() {
        $bar.sink() { val in
            print("new bar value ", val)
            //If we dont store this in subs, this functionality cannot get called
        }.store(in: &subs)
        
        $bar.sink() { val in
            print("new bar value 2", val)
            //If we dont store this in subs, this functionality cannot get called
        }.store(in: &subs)
    }
    func barChanged(){
        // will execute the functionality in published example
        bar = (70...100)
        print("subs count ",subs.count)
    }
}
// MARK: - Combining Operators
extension ViewController {
    
    // MARK: - CombineLatest
    func combLatest() {
        let publisher1 = PassthroughSubject<Int,Never>()
        let publisher2 = PassthroughSubject<String,Never>()
        
        publisher1.combineLatest(publisher2).sink {
            print("P1: \($0), P2: \($1)")
        }.store(in: &subs)
        
        publisher1.send(1)
        //will not trigger yet
        publisher2.send("A")
        //triggered
        
        publisher2.send("B")
//        prints
//        P1: 1, P2: A
//        P1: 1, P2: B
        
    }
    
    // MARK: - Merge
    func merge() {
        //gives both publishers the same sink
        let publisher1 = PassthroughSubject<Int,Never>()
        let publisher2 = PassthroughSubject<Int,Never>()
        publisher1.merge(with: publisher2).sink{
            print($0)
        }.store(in: &subs)
        
        publisher2.send(10)
        let sub = IntSubscriber()
        
        publisher1.receive(subscriber: sub)
        
        
        
    }
    
    
    
    // MARK: - Switch To Latest
    func switchToLatest() {
        let publisher1 = PassthroughSubject<String,Never>()
        let publisher2 = PassthroughSubject<String,Never>()
        let publishers = PassthroughSubject<PassthroughSubject<String,Never>,Never>()
        
        publishers.switchToLatest()
            .sink{
            print($0)
            }.store(in: &subs)
        
        publishers.send(publisher1)
        
        publisher1.send("Publisher 1 - Value 1")
        publisher1.send("Publisher 1 - Value 2")
        //This will not print
        publisher2.send("Publisher 2 - Value 1")
        
        publishers.send(publisher2)
        //Now it will print
        publisher2.send("Publisher 2 - Value 1")
    }
    
    
    func append() {
        let numbers = (1...5).publisher
        
        
        
        numbers.append(11,12)
            .sink{print($0)}
//        prints
//        1
//        2
//        3
//        4
//        5
//        11
//        12
    }
    
    
    // MARK: - Prepend
    func prepend() {
        let numbers = (1...5).publisher
        let publisher2 = (500...510).publisher
        
        numbers.prepend(100,101)
            .sink {
            print($0)
        }
//        prints
//        100
//        101
//        1
//        2
//        3
//        4
//        5
        numbers.prepend(100,101)
            .prepend(publisher2)
            .sink {
            print($0)
        }
//        prints
//        500
//        501
//        502
//        503
//        504
//        505
//        506
//        507
//        508
//        509
//        510
//        100
//        101
//        1
//        2
//        3
//        4
//        5
    }
    
}


// MARK: - Filtering Operations
extension ViewController {
    func prefix() {
        let numbers = (1...10).publisher
        
        numbers.prefix(2).sink{print($0)}
//        prints
//        1
//        2
        numbers.prefix(while: {$0 < 4}).sink{print($0)}
//        prints
//        1
//        2
//        3
                
    }
    
    func dropUntilOutputFrom() {
        
        let isReady = PassthroughSubject<Void,Never>()
        
        let taps = PassthroughSubject<Int,Never>()
        
        taps.drop(untilOutputFrom: isReady).sink {
            print($0)
        }.store(in: &subs)
        
        print("About to tap")
        (1...10).forEach { i in
            print("tapping: ",i)
            taps.send(i)
            print("Tapped: ",i)
            
            if i == 3 {
                print("isReady is about to send")
                isReady.send()
                print("isReady Sent")
            }
        }
//        prints
//        About to tap
//        4
//        5
//        6
//        7
//        8
//        9
//        10
//
    }
    
    
    func dropWhile() {
        let numbers = (1...10).publisher
        
        numbers.drop(while: {$0 % 3 != 0}).sink(receiveValue: {print($0)})
    }
    func last() {
        let numbers = (1...9).publisher
        
        numbers.last(where: {$0 % 2 == 0}).sink(receiveValue: {print($0)})
    }
    func first() {
        let numbers = (1...9).publisher
        
        numbers.first(where: {$0 % 2 == 0}).sink(receiveValue: {print($0)})
        
    }
        
    func ignoreOutput() {
        let numbers = (1...5000).publisher
        
        numbers.ignoreOutput().sink(receiveCompletion: {print($0)}, receiveValue: {print($0)})}
    }
    
    func compactMap() {
        let strings = ["a","b","c","d","t","3.34","4.12"].publisher.compactMap{Float($0)}.sink {
            print($0)
        }
    }
    
    func removeDuplicates1() {
        let words = "apple apple fruit apple mango watermelon apple".components(separatedBy: " ").publisher
        
        words.removeDuplicates().sink {
            print($0)
        }
        
    }
    
    func filteringExample1() {
        
       
        var numbers = (1...29).publisher

        let numberArray = [Int]()
        
        _ = numbers.filter {$0 % 2 == 0}
            .sink{
                print($0)

            }
        
       
    }


//MARK: - TransformationOperators
extension ViewController {
    
    
    func scanExample() {
        //accumulates all the previous values into a single value, so "value" is an accumulation of all the previous values
        let publisher = (1...10).publisher
        publisher.scan([]) {numbers, value -> [Int] in
            return numbers + [value]
        }.sink {
            print($0)
        }
//        prints
//        [1]
//        [1, 2]
//        [1, 2, 3]
//        [1, 2, 3, 4]
//        [1, 2, 3, 4, 5]
//        [1, 2, 3, 4, 5, 6]
//        [1, 2, 3, 4, 5, 6, 7]
//        [1, 2, 3, 4, 5, 6, 7, 8]
//        [1, 2, 3, 4, 5, 6, 7, 8, 9]
//        [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    }
    
    
    struct Point {
        let x : Int
        let y: Int
    }
    // MARK: - MAP KepPath
    func mapKeypath() {
        //maps over the properties of "Point"
        let publisher = PassthroughSubject< Point , Never>()
        _ = publisher.map(\.x,\.y).sink{ x, y in
            print("x is \(x) and y is \(y)")
  
    }
        
        publisher.send(Point(x: 2, y: 10))
    }
    
    // MARK: - Map()
    func transOperatorMap() {
        
        let formatter = NumberFormatter()
        formatter.numberStyle = .spellOut
        
        _ = [123,45,67].publisher.map {
            formatter.string(from: NSNumber(integerLiteral: $0)) ?? ""
        }.sink {
            print($0)
        }
//        prints
//        one hundred twenty-three
//        forty-five
//        sixty-seven
    }
    // MARK: - Collect()
    func transOperatorsCollect() {
        _ = ["A","B","C","D"].publisher.sink {
            print($0)
        }
        //        ^^ prints
        //        A
        //        B
        //        C
        //        D
        
        
        _ = ["A","B","C","D"].publisher.collect().sink {
            print($0)
        }
        //        ^^, collect() prints ["A", "B", "C", "D"]
        //
        //
        //
        //
        _ = ["A","B","C","D"].publisher.collect(2).sink {
            print($0)
        }
        //      ^^, collect(2)
        //        prints
        //        ["A", "B"]
        //        ["C", "D"]
        _ = ["A","B","C","D","E"].publisher.collect(2).sink {
            print($0)
            }
//        ^^, collect(2)
//        prints
//        ["A", "B"]
//        ["C", "D"]
//        ["E"]
        _ = ["A","B","C","D","E"].publisher.collect(3).sink {
            print($0)
            }
//        ^^, collect(2)
//        prints
//        ["A", "B", "C"]
//        ["D", "E"]
    }
}

// MARK: - TypeEraser
extension ViewController {
    func typeEraserExample() {
        //Hides the passThroughType behind an "AnyPublisher type"
        let _ = PassthroughSubject<Int,Never>().eraseToAnyPublisher()
    }
}


extension ViewController {
    func passthroughSubjectsExample() {
        //Subjects
            // - Publisher
            // - Subscriber
            
        let subscriber = StringSubscriber2()
        let subject = PassthroughSubject<String, MyError>()
        
        subject.subscribe(subscriber)
        
        _ = subject.sink { (completion) in
            //When all values have been received do this
            
            print("Received Completion from sink")
            
        } receiveValue: { value in
            //For each value received, do this.
            print("Received Value from sink")
        
        }

        //Passthrough subjects can send a stream of data on demand.
        subject.send("A")
        subject.send("B")
        subject.send("C")
        
    }
}
enum MyError: Error {
    case subscriberError
}
class StringSubscriber2: Subscriber {
    
    func receive(subscription: Subscription) {
        subscription.request(.max(2))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print(input)
//        return .none
        //increment by 1 more sub each time.
        return .max(1)
    }
    
    func receive(completion: Subscribers.Completion<MyError>) {
        print("Completion")
    }
    
    typealias Input = String
    typealias Failure = MyError
    
    
    
}



// MARK: - MultiSubscriber Example
extension ViewController {
    func multiSubscriberExample() {
        // Do any additional setup after loading the view.
        let publisher = ["A","B","C","D","E","F","g","H","I","J","K"].publisher
        let subscriber = StringSubscriber()
        //Will only get A,B,C because we set the max to 3
        publisher.subscribe(subscriber)
    }
}

class IntSubscriber: Subscriber {
    func receive(subscription: Subscription) {
        print("Received subscription")
        //"this is backPressure" the max items we want to receive is 3
        subscription.request(.max(3))
    }
    
    func receive(_ input: Int) -> Subscribers.Demand {
        print("Received Subscription Value ", input)
        
        //Asking if we want to change the back pressure incrementation
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
    
    //Telling the Subscriber type that String is the type we will mainly work with
    typealias Input = Int
    
    typealias Failure = Never
    
    
}

class StringSubscriber: Subscriber {
    func receive(subscription: Subscription) {
        print("Received subscription")
        //"this is backPressure" the max items we want to receive is 3
        subscription.request(.max(3))
    }
    
    func receive(_ input: String) -> Subscribers.Demand {
        print("Received Subscription Value ", input)
        
        //Asking if we want to change the back pressure incrementation
        return .unlimited
    }
    
    func receive(completion: Subscribers.Completion<Never>) {
        print("Completed")
    }
    
    //Telling the Subscriber type that String is the type we will mainly work with
    typealias Input = String
    
    typealias Failure = Never
    
    
}
