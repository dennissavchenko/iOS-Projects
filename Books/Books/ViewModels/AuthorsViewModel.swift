//
//  AuthorsViewModel.swift
//  Books
//
//  Created by dennis savchenko on 25/08/2024.
//

import Foundation

class AuthorsViewModel: ObservableObject {
    
    @Published var authors: [Author] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
            guard let url = URL(string: "\(API_ENDPOINT)/api/authors") else { return }
        
            let session = URLSession.shared

            let task = session.dataTask(with: url) { (data, response, error) in
                
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let data = data else {
                    print("No data received.")
                    return
                }

                do {
                    let authors = try JSONDecoder().decode([Author].self, from: data)
                    DispatchQueue.main.async {
                        self.authors = authors
                    }
                } catch let decodeError {
                    print("Decoding error: \(decodeError)")
                }
            }

            task.resume()
        
        }
    
}
