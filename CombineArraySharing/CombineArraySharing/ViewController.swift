//
//  ViewController.swift
//  CombineArraySharing
//
//  Created by Greg Hughes on 10/22/20.
//

import UIKit
import Combine

var trash : Set<AnyCancellable> = []
var numbers = Array.init(repeating: Unit(name: "first"), count: 100)

var passThroughArray = PassthroughSubject<Unit,Never>()

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
       
        let onesub = PassthroughSubject<Unit, Never>()
        let twosub = AnySubscriber(onesub)
        
        let passthroughSubject = PassthroughSubject<Unit, Never>()
        let anySubscriber = AnySubscriber(passthroughSubject)
        //we define what the subscriber will do once it receives a publisher
        
        let oldsub = onesub.sink(receiveCompletion: { completion in
            print(completion)
        }) { value in
            print(value)
        }
        
        passthroughSubject.sink(receiveCompletion: { completion in
                         print(completion)
                     }) { value in
                         print(value)
        }.store(in: &trash)
        
        let publisher = numbers.publisher
        publisher.receive(subscriber: anySubscriber)
        publisher.subscribe(passthroughSubject).store(in: &trash)
        
        
        
        passthroughSubject.receive(subscriber: twosub)
        
        
        
        passthroughSubject.send(Unit(name: "greg"))
        
        
        let currentValueSubject = CurrentValueSubject<Int, Never>(1)
        print(currentValueSubject.value)
        currentValueSubject.sink { (i) in
            print("hello",i)
        }.store(in: &trash)
        // 1
        currentValueSubject.send(2)
        print(currentValueSubject.value)
        // 2
        currentValueSubject.send(10)
        currentValueSubject.send(completion: .finished)
        currentValueSubject.send(10) // won’t be printed
        print(currentValueSubject.value)
        // prints 2
        
        
        // Do any additional setup after loading the view.
    }


}
struct Unit {
    let name : String
}

