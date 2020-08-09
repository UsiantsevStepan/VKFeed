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
    
    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }
    
    func parse<T: Decodable>(withData data: Data, to type: T.Type) -> T? {
        return try? decoder.decode(type, from: data)
    }
}
