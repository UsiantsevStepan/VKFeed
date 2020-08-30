//
//  DataParser.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 08.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

class DataParser {
    
    private let decoder: JSONDecoder
    
    init(decoder: JSONDecoder? = nil) {
        if let jsonDecoder = decoder {
            self.decoder = jsonDecoder
        } else {
            let jsonDecoder = JSONDecoder()
            jsonDecoder.dateDecodingStrategy = .secondsSince1970
            self.decoder = jsonDecoder
        }
    }
    
    func parse<T: Decodable>(withData data: Data, to type: T.Type) -> T? {
        return try? decoder.decode(type, from: data)
//        do {
//            return try decoder.decode(type, from: data)
//        } catch {
//            print(error.localizedDescription)
//            return nil
//        }
    }
}
