//
//  ListViewModel.swift
//  ShoppingListMain
//
//  Created by Greg Hughes on 10/29/20.
//

import Foundation
import Combine

class ListViewModel: ObservableObject {
    @Published var lists = [Listi]()
    var cancellable : AnyCancellable?

    init() {
        fetchLists()
    }
    
    func fetchLists() {
        
        let url = URL(string: "http://192.168.1.43:8081/lists")!

        
        self.cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .decode(type: [Listi].self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .map{$0}
            .sink(receiveCompletion: {_ in}, receiveValue: { list in
                self.lists = list
            })
//            .receive(on: RunLoop.main)
//            .eraseToAnyPublisher()
//            .sink(receiveCompletion: {_ in}, receiveValue: {
//                self.lists = $0
//            })
//        URLSession.shared.dataTask(with: url) { (data, res, er) in
//            do {
//                let jsonDecoder = JSONDecoder()
//                let lists = try jsonDecoder.decode([Listi].self, from: data!)
//                print(lists)
//                self.lists = lists
//            }catch let er{
//                
//                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
//            }
//        }.resume()
        
    }
}
