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
    
    func getUserData(_ completion: @escaping ((Result<TitleViewModel,Error>) -> Void)) {
        networkManager.getData(with: VkApi.getUser) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .failure(error):
                completion(.failure(error))
            case let .success(data):
                guard let titleViewData = self.dataParser.parse(withData: data, to: TitleViewData.self) else {
                    completion(.failure(FeedManagerError.parseError))
                    return
                }
                let userModel = self.createUserModel(from: titleViewData)
                completion(.success(userModel))
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
            
            let photos = item.attachments?.compactMap { $0.photo?.necessarySize?.url }
            
            let userFirstName = profile?.firstName ?? ""
            let userLastName = profile?.lastName ?? ""
            let userFullName = userFirstName + " " + userLastName
            
            return PostCellModel(text: item.text, userName: userFullName, userPhotoUrl: profile?.userPhotoUrl, date: dateFormat(with: item.date), photos: photos, comments: item.comments.formattedValue, likes: item.likes.formattedValue, reposts: item.reposts.formattedValue, views: item.views.formattedValue)
        }
    }
    
    private func createUserModel(from userData: TitleViewData) -> TitleViewModel {
        
        let firstName = userData.response.first?.firstName ?? ""
        let lastName = userData.response.first?.lastName ?? ""
        let userFullName = firstName + " " + lastName
        
        return TitleViewModel(userName: userFullName, userPhotoUrl: userData.response.first?.userPhotoUrl)
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
