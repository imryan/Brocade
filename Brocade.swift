//
//  Brocade.swift
//  Brocade
//
//  Created by Ryan Cohen on 3/31/20.
//

import Foundation

public protocol BrocadeProtocol: class {
    func receivedMultipleItems(_ items: [Item]?, _ error: Error?)
    func receivedSingleItem(_ item: Item?, _ error: Error?)
}

public class Brocade {
    
    // MARK: - Attributes -
    
    /// Shared instance
    public static let shared = Brocade()
    
    /// API client instance
    private let apiClient: APIClient = APIClient()
    
    /// Brocade delegate
    public weak var delegate: BrocadeProtocol?
    
    /// Single item response closure.
    public typealias SingleItemResponse = (_ item: Item?, _ error: Error?) -> Void
    
    /// Multiple item response closure.
    public typealias MultipleItemResponse = (_ items: [Item]?, _ error: Error?) -> Void
    
    // MARK: - Initializatiion -
    
    /// Initialization
    ///
    /// - Parameter delegate: Optional `BrocadeProtocol` for receiving delegate callbacks.
    public init(delegate: BrocadeProtocol? = nil) {
        self.delegate = delegate
    }
    
    // MARK: - Functions -
    
    /// List all items, limited to 100 per request.
    ///
    /// - Parameter completion: Optional closure returning multiple optional `Item` objects and an optional `Error`.
    public func listItems(completion: MultipleItemResponse? = nil) {
        apiClient.request(.get, endpoint: .items) { [weak self] (items: [Item]?, error: Error?) in
            self?.delegate?.receivedMultipleItems(items, error)
            completion?(items, error)
        }
    }
    
    /// Look up an item by its UPC or EAN.
    ///
    /// - Parameters:
    ///   - code: UPC or EAN.
    ///   - completion: Optional closure returning a single optional `Item` object and an optional `Error`.
    public func getItem(code: String, completion: SingleItemResponse? = nil) {
        apiClient.request(.get, endpoint: .getItem(code)) { [weak self] (item: Item?, error: Error?) in
            self?.delegate?.receivedSingleItem(item, error)
            completion?(item, error)
        }
    }
    
    /// Search for an item
    ///
    /// - Parameters:
    ///   - query: Product search query.
    ///   - completion: Optional closure returning multiple optional `Item` objects and an optional `Error`.
    public func searchItem(query: String, completion: MultipleItemResponse? = nil) {
        apiClient.request(.get, endpoint: .items, query: query) { [weak self] (items: [Item]?, error: Error?) in
            self?.delegate?.receivedMultipleItems(items, error)
            completion?(items, error)
        }
    }
}
