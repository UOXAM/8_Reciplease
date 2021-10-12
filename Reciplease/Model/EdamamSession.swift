//
//  EdamamSession.swift
//  Reciplease
//
//  Created by ROUX Maxime on 12/10/2021.
//

import Foundation
import Alamofire

protocol AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void)
}

final class EdamamSession: AlamofireSession {
    func request(url: URL, callback: @escaping (AFDataResponse<Any>) -> Void) {
        AF.request(url).responseJSON { dataResponse in
            callback(dataResponse)
        }
    }
}
