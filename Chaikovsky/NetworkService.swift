//
//  NetworkService.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

class NetworkService: NSObject, URLSessionDelegate {

    typealias Answer = String
    typealias AnswerHandler = (Answer?) -> Void
    static let urlString = "https://94.130.19.98:5000/iOS"

    func ask(question: String, completionHandler: @escaping AnswerHandler) {
        guard let serviceUrl = URL(string: NetworkService.urlString) else {
            completionHandler(nil)
            return
        }
        let parameterDictionary = ["request" : question]
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "POST"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameterDictionary, options: []) else {
            completionHandler(nil)
            return
        }
        request.httpBody = httpBody

        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)

        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                let answer = String(data: data, encoding: String.Encoding.utf8)
                completionHandler(answer)
            }
        }.resume()
    }

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, cred)
        }
    }

}
