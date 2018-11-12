//
//  ApiService.swift
//  TestApp
//
//  Created by Anton Muratov on 11/8/18.
//  Copyright © 2018 Anton Muratov. All rights reserved.
//

import RxSwift

class ApiService: ApiServiceType {
    let session: URLSession
    var baseUrl: URL
    
    // MARK: - Init
    
    init(baseUrl: URL) {
        self.baseUrl = baseUrl
        session = URLSession(configuration: .default)
    }
    
    // MARK: - Actions
    
    func execute<T: Request>(_ request: T) -> Completable {
        return executeRequest(request).ignoreElements()
    }
    
    func execute<T: Request>(_ request: T) -> Observable<T.ParseableModel> {
        return executeRequest(request).flatMap { self.parse(request: request, with: $0) }
    }
    
    // MARK: - Private
    
    private func executeRequest<T: Request>(_ request: T) -> Observable<Data> {
        return Observable<Data>.create { (observer) in
            let url = request.path.map { self.baseUrl.appendingPathComponent($0) } ?? self.baseUrl
            
            guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
                observer.onError(ApiServiceError.invalidUrl)
                return Disposables.create()
            }
            
            urlComponents.queryItems = request.queryItems
            
            guard let finalUrl = urlComponents.url else {
                observer.onError(ApiServiceError.invalidUrl)
                return Disposables.create()
            }
            
            let task = self.session.dataTask(with: self.urlRequest(from: request, url: finalUrl)) { (data, _, error) in
                if let error = error {
                    observer.onError(error)
                    return
                }
                
                guard let data = data else {
                    observer.onError(ApiServiceError.emptyData)
                    return
                    
                }
                
                observer.onNext(data)
                observer.onCompleted()
            }
            
            task.resume()
            
            return Disposables.create {
                task.cancel()
            }
        }
    }
    
    // MARK: - Helpers
    
    private func urlRequest<T: Request>(from request: T, url: URL) -> URLRequest {
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = request.headers
        urlRequest.httpBody = request.body.flatMap { try? JSONSerialization.data(withJSONObject: $0)}
        return urlRequest
    }
    
    private func parse<T: Request>(request: T, with data: Data) -> Observable<T.ParseableModel> {
        return Observable<T.ParseableModel>.create { (observer) in
            do {
                let mappedObject = try T.parse(data)
                observer.onNext(mappedObject)
                observer.onCompleted()
            } catch {
                observer.onError(error)
            }
            
            return Disposables.create()
        }
    }
}
