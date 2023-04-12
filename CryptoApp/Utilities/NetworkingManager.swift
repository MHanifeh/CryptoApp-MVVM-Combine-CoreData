//
//  NetworkingManager.swift
//  CryptoApp
//
//  Created by MahdiHanifeh on 11/23/1401 AP.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError:LocalizedError{
        case badURLResponse(url:URL)
        case unlnown
        var errorDescription: String?{
            switch self{
            case .badURLResponse(url: let url) : return "[🔥] Bad response from URL : \(url)"
            case .unlnown : return "[☣️] Unknown error occured"
            }
        }
    }
    // download
    static func download (url : URL)->AnyPublisher<Data,Error>{
        
      return URLSession.shared.dataTaskPublisher(for: url)
           .subscribe(on: DispatchQueue.global(qos: .default))
           .tryMap({try handeldURLResponse(output: $0,url: url)})
        
           .receive(on: DispatchQueue.main)
           .eraseToAnyPublisher()
    }
    static func handeldURLResponse(output: URLSession.DataTaskPublisher.Output,url:URL) throws-> Data{
        guard let response = output.response as? HTTPURLResponse,
              response.statusCode >= 200 && response.statusCode < 300
        else{
            throw NetworkingError.badURLResponse(url: url)
           
        
        }
        return output.data
    }
    static func handelError (complition : Subscribers.Completion<Error>){
        switch complition{
        case .finished:
            break
        case .failure(let error):
            print(error.localizedDescription)
            print(error)
        }
    }
}
