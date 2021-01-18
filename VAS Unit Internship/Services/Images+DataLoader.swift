//
//  Images+DataLoader.swift
//  VASUnitInternship
//
//  Created by Никита on 08.01.2021.
//

import UIKit

// Позволяет загружать изображения по URL
class ImageLoader: LoadDataProtocol {
    
    // MARK: - LoadDataProtocol Realization
    
    func loadData(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        guard let url = URL(string: source) else {
            complition(nil)
            return
        }
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let err = error {
                print(err.localizedDescription)
                complition(nil)
            }

            if let data = data {
                complition(data)
            }
        }.resume()
    }
}

// Позволяет загружать и проверять дату
final class DataLoader: LoadDataProtocol {
    
    // MARK: - LoadDataProtocol Realization
    func loadData(from source: String, complition: @escaping (_ data: Data?) -> Void) {
        if let url = Bundle.main.url(forResource: "result", withExtension: "json") {
            do {
                let resData = try Data(contentsOf: url)
                complition(resData)
            } catch {
                print(error)
            }
        }
        complition(nil)
    }
    
}

