//
//  NetworkService.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import Foundation

extension String{
    var encodeUrl : String {
        return self.addingPercentEncoding(withAllowedCharacters: NSCharacterSet.urlQueryAllowed)!
    }
    var decodeUrl : String {
        return self.removingPercentEncoding!
    }
}

class NetworkService: NSObject, URLSessionDelegate {

    typealias Answer = String
    typealias AnswerHandler = (Answer?) -> Void
    static let urlString = "https://94.130.19.98:5000"

    lazy var session: URLSession = {
        let sessionConfiguration = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfiguration, delegate: self, delegateQueue: nil)
        return session
    }()


    func ask(question: String, completionHandler: @escaping AnswerHandler) {
        guard let serviceUrl = URL(string: "\(NetworkService.urlString)/textProcessing") else {
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

        session.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                let answer = String(data: data, encoding: String.Encoding.utf8)
                completionHandler(answer)
            }
        }.resume()
    }

    func playbill(composer: String?, completionHandler: @escaping ([Concert]?) -> Void) {
        var urlString = "\(NetworkService.urlString)/playbill"
        if let comp = composer {
            urlString +=  "?composer=\(comp)"
        }
        urlString = urlString.encodeUrl

        guard let serviceUrl = URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        var request = URLRequest(url: serviceUrl)
        request.httpMethod = "GET"
        request.setValue("Application/json", forHTTPHeaderField: "Content-Type")

        session.dataTask(with: request) { (data, response, error) in
            if let data = data,
                let httpResponse = response as? HTTPURLResponse,
                httpResponse.statusCode == 200 {
                do {
                    let concerts = try JSONDecoder().decode([Concert].self, from: data)
                    completionHandler(concerts)
                } catch {
                    completionHandler(nil)
                    return
                }
            }
            }.resume()
    }

    // MARK: - URL Session delegate

    func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: @escaping (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        if challenge.protectionSpace.authenticationMethod == NSURLAuthenticationMethodServerTrust {
            let cred = URLCredential(trust: challenge.protectionSpace.serverTrust!)
            completionHandler(URLSession.AuthChallengeDisposition.useCredential, cred)
        }
    }

}
