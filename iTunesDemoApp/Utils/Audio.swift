//
//  Audio.swift
//  iTunesDemoApp
//
//  Created by Ignacio Gómez on 5/9/19.
//  Copyright © 2019 Yapo.cl. All rights reserved.
//

import Foundation

class AudioUtils {
    static func play(from url: URL, completion: @escaping (URL) -> Void) {
        URLSession.shared.downloadTask(with: url, completionHandler: { url, response, error in
            guard let url = url else { return }
            completion(url)
        }).resume()
    }

    static func play(from urlString: String, completion: @escaping (URL) -> Void) {
        guard let url = URL(string: urlString) else { return }
        play(from: url, completion: completion)
    }
}
