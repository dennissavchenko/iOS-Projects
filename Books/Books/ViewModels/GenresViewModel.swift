//
//  GenresViewModel.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import Foundation

class GenresViewModel: ObservableObject {
    
    @Published var genres: [Genre] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
            guard let url = URL(string: "\(API_ENDPOINT)/api/genres") else { return }
        
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
                    let genres = try JSONDecoder().decode([Genre].self, from: data)
                    DispatchQueue.main.async {
                        self.genres = genres
                    }
                } catch let decodeError {
                    print("Decoding error: \(decodeError)")
                }
            }

            task.resume()
        
        }
    
}
