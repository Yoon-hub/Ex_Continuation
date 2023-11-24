//
//  ViewController.swift
//  Ex_CheckedContinuation
//
//  Created by VP on 11/24/23.
//

import UIKit

class ViewController: UIViewController {
    
    let url = "https://random.imagecdn.app/500/150"

    @IBOutlet weak var imageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        requestImage { data in
            print(data)
        }
        
        Task {
            do {
                let data = try await requestImageAsycAwait()
            } catch {
                print(error)
            }
        }
    
    }
        
    func requestImage(handler: @escaping ((Data) -> Void)) {
        let request = URLRequest(url: URL(string: url)!)
        URLSession.shared.dataTask(with: request) { data, response, error in
            print(error)
            handler(data!)
        }.resume()
    }
    
    func requestImageAsycAwait() async throws -> Data {
        let request = URLRequest(url: URL(string: url)!)
        
        return try await withUnsafeThrowingContinuation { continuation in
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data {
                    //continuation.resume(returning: data)
                } else if let error {
                    //continuation.resume(throwing: error)
                }
            }.resume()
        }
    }

}

