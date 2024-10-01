//
//  Data.swift
//  Books
//
//  Created by dennis savchenko on 22/08/2024.
//

import Foundation

class BooksViewModel: ObservableObject {
    
    @Published var books: [Book] = []
    
    init() {
        fetchData()
    }
    
    func fetchData() {
        
        guard let url = URL(string: "\(API_ENDPOINT)/api/books") else { return }
        
        print(url)
        
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
                let books = try JSONDecoder().decode([Book].self, from: data)
                DispatchQueue.main.async {
                    self.books = books
                }
            } catch let decodeError {
                print("Decoding error: \(decodeError)")
            }
            
        }

        task.resume()
        
    }
    
    func getAuthorBooks(authorId: Int, completion: @escaping ([Book]) -> Void) {
        
        guard let url = URL(string: "\(API_ENDPOINT)/api/books/authors/\(authorId)") else {
            print("Invalid URL")
            completion([])
            return
        }

        let session = URLSession.shared

        let task = session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error: \(error)")
                completion([])
                return
            }

            guard let data = data else {
                print("No data received.")
                completion([])
                return
            }

            do {
                let books = try JSONDecoder().decode([Book].self, from: data)
                DispatchQueue.main.async {
                    completion(books)
                }
            } catch let decodeError {
                print("Decoding error: \(decodeError)")
                completion([])
            }
        }

        task.resume()
        
    }
    
    func addBook(_ book: Book) {
        
            guard let url = URL(string: "\(API_ENDPOINT)/api/books") else { return }

            var request = URLRequest(url: url)
        
            request.httpMethod = "POST"
        
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                let jsonData = try JSONEncoder().encode(book)
                request.httpBody = jsonData
            } catch {
                print("Error encoding book: \(error)")
                return
            }

            let session = URLSession.shared

            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 201 else {
                    print("Unexpected response: \(response!)")
                    return
                }

                DispatchQueue.main.async {
                    self.fetchData()
                }
            }

            task.resume()
        }
    
    func deleteBook(bookId: Int) {
        
           guard let url = URL(string: "\(API_ENDPOINT)/api/books/\(bookId)") else {
               return
           }
           
           var request = URLRequest(url: url)
        
           request.httpMethod = "DELETE"
           
           let session = URLSession.shared
           
           let task = session.dataTask(with: request) { (data, response, error) in
               if let error = error {
                   print("Error: \(error)")
                   return
               }
               
               guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                   print("Unexpected response: \(response!)")
                   return
               }
               
               DispatchQueue.main.async {
                   self.fetchData()
               }
           }
           
           task.resume()
       }
    
    func updateBook(_ book: Book) {
        
            guard let url = URL(string: "\(API_ENDPOINT)/api/books") else { return }

            var request = URLRequest(url: url)
        
            request.httpMethod = "PUT"
        
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                let jsonData = try JSONEncoder().encode(book)
                request.httpBody = jsonData
            } catch {
                print("Error encoding book: \(error)")
                return
            }

            let session = URLSession.shared

            let task = session.dataTask(with: request) { (data, response, error) in
                if let error = error {
                    print("Error: \(error)")
                    return
                }

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    print("Unexpected response: \(response!)")
                    return
                }

                DispatchQueue.main.async {
                    self.fetchData()
                }
            }

            task.resume()
        }
    
}
