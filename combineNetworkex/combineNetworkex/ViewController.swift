//
//  ViewController.swift
//  combineNetworkex
//
//  Created by Greg Hughes on 10/15/20.
//

import UIKit
import Combine
class ViewController: UITableViewController {

    let d = Date()
    let df = DateFormatter()
    
    private var webservice = Webservice()
    private var cancellable : AnyCancellable?
    private var posts = [Post]() {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                print(self.df.string(from: Date()))
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        df.dateFormat = "y-MM-dd H:ssm:ss.SSSS"
        
        cancellable = webservice.getPost()
            //(Just) basically just returns an empty post array if there is an error
            .catch{_ in Just(self.posts)}
            .assign(to: \.posts, on: self)
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = posts[indexPath.row].title

        return cell
    }
}

class Webservice {
    
    func getPost() -> AnyPublisher<[Post],Error>{
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); fatalError("Invalid URL")}
        return URLSession.shared.dataTaskPublisher(for: url)
            .map{$0.data}
            .decode(type: [Post].self, decoder: JSONDecoder())
//            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    func getPostReg(completion:@escaping([Post]?)->()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); completion(nil);return}
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            if let error = error {
                print("❌ There was an error in \(#function) \(error) : \(error.localizedDescription) : \(#file) \(#line)")
                completion(nil)
                return
            }
            guard let data = data else {print("❇️♊️>>>\(#file) \(#line): guard let failed<<<"); return}

            do {
                let jsonDecoder = JSONDecoder()
                let posts = try jsonDecoder.decode([Post].self, from: data)
                completion(posts)
            }catch let er{
                
                print("❌ There was an error in \(#function) \(er) : \(er.localizedDescription) : \(#file) \(#line)")
                completion(nil)
            }
            
            
        }.resume()
    }
    
}
class Post:Codable {
    let title: String
    let body : String
}
