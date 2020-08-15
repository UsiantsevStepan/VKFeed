//
//  FeedManager.swift
//  VKFeed
//
//  Created by Степан Усьянцев on 08.08.2020.
//  Copyright © 2020 Stepan Usiantsev. All rights reserved.
//

import Foundation

class FeedManager {
    
    enum FeedManagerError: LocalizedError {
        case parseError
        
        var errorDescription: String? {
            return "Data hasn't been parsed or has been parsed incorrectly"
        }
    }
    
    let dataParser = DataParser()
    let networkManager = NetworkManager()
    
    func getFeedData(_ completion: @escaping ((Result<[PostCellModel],Error>) -> Void)) {
        networkManager.getData(with: VkApi.feedList) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                guard let feedListData = self.dataParser.parse(withData: data, to: FeedListData.self) else {
                    completion(.failure(FeedManagerError.parseError))
                    return
                }
                let postCellModels = self.createPostCellModel(from: feedListData)
                completion(.success(postCellModels))
            }
        }
    }
    
    private func createPostCellModel(from feedData: FeedListData) -> [PostCellModel] {
        let profiles = feedData.response.profiles.reduce([Int : Profile]()) { (result, profile) -> [Int : Profile] in
            var result = result
            result[profile.id] = profile
            return result
        }
        
        return feedData.response.items.map { item -> PostCellModel in
            let profile = profiles[item.sourceId]
            
            return PostCellModel(postText: item.text, postUserFirstName: profile?.firstName, postUserLastName: profile?.lastName, postUserPhotoUrl: profile?.userPhotoUrl, postDate: dateFormat(with: item.date))
        }
    }
}

private extension FeedManager {
    func dateFormat(with date: Date) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .current
        dateFormatter.dateFormat = "d MMM' at 'h:mm"
        return dateFormatter.string(from: date)
    }
}
