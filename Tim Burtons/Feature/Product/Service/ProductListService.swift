//
//  ProductListService.swift
//  Tim Burtons
//
//  Created by Haewon Kwak on 2018-02-27.
//  Copyright © 2018 Tim Burtons. All rights reserved.
//

class ProductListService {
    private var products: [Product] = []

    let apiExecutor: APIExecutable
    
    init(apiExecutor: APIExecutable = APIService.shared) {
        self.apiExecutor = apiExecutor
    }
    
    func fetchDataSource(completion: @escaping (Error?) -> ()) {
        
        let request = Request.Products()
        apiExecutor.execute(request) { [weak self] result in
            guard let strongSelf = self else {
                return
            }
            
            switch result {
            case .success(let response):
                guard let products = request.parseFromResponse(response) else {
                    return completion(ParserError.unableToParse)
                }
                strongSelf.products = products
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

// MARK: - ListDataSource
extension ProductListService: ListDataSource {
    typealias Item = (name: String, price: String)
    
    func numberOfRows(inSection section: Int) -> Int {
        return products.count
    }
    
    func item(at indexPath: IndexPath) -> Item {
        let product = products[indexPath.row]
        let name: String
        switch product.productSize {
        case .havingSize(let size):
            name = "\(product.name) \(size.shortTerm)"
        case .none:
            name = product.name
        }
        return (name: name, price: product.price)
    }
}

