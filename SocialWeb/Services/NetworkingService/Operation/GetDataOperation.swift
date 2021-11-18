//
//  GetDataOperation.swift
//  SocialWeb
//
//  Created by Никитка on 18.11.2021.
//

import Foundation
import Alamofire

class GetDataOperation: AsyncOperation {
    private var request: DataRequest
    var data: Data?

    init(request: DataRequest) {
        self.request  = request
    }

    override func main() {
        request.responseData(queue: DispatchQueue.global()) { [weak self] response in
            self?.data = response.data
            self?.state = .finished
            print("Data loaded")
        }
    }

    override func cancel() {
        request.cancel()
        super.cancel()
    }
}
