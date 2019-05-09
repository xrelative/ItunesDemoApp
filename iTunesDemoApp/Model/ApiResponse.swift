//
//  ApiResponse.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

struct ApiResponse: Decodable {
    let resultCount: Int
    let results: [ResultRow]
}
