//
//  PlaceHolderService.swift
//  CleanTableView
//
//  Created by Canberk Bibican on 26.09.2021.
//

import Alamofire

protocol IJsonPlaceHolderProtocol {
    func fectAllPosts(onSuccess:@escaping([PostModel])-> Void, onFail:@escaping (String?) -> Void)
}

enum JsonPlaceHolderPath: String{
    case POSTS = "/posts"
}

extension JsonPlaceHolderPath{
    func withBaseUrl() -> String{
        return "https://jsonplaceholder.typicode.com\(self.rawValue)"
    }
}

struct JsonPlaceHolderService: IJsonPlaceHolderProtocol {
    func fectAllPosts(onSuccess: @escaping ([PostModel]) -> Void, onFail: @escaping (String?) -> Void) {
        AF.request(JsonPlaceHolderPath.POSTS.withBaseUrl(), method: .get).validate().responseDecodable(of: [PostModel].self) { (response) in
            // response.value = parse edilmiş hali
            // resonse.data = datanın saf hali
            guard let itemList = response.value else {
                onFail(response.debugDescription)
                return
            }
            onSuccess(itemList)
        }
    }
    
    
}
