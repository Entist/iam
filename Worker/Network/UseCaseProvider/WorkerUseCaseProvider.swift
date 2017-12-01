//
//  WorkerUseCaseProvider.swift
//  Worker
//
//  Created by HoJun Lee on 2017. 12. 1..
//  Copyright © 2017년 HoJun Lee. All rights reserved.
//

import Foundation
import Domain
import Realm
import RealmSwift

public final class WorkerUseCaseProvider: Domain.UseCaseProvider {
    private let networkProvider: NetworkProvider
    
    public init() {
        networkProvider = NetworkProvider()
    }
    
    public func createAnswersUseCase() -> Domain.AnswerUseCase {
        return AnswerUseCase(network: networkProvider.creatAnswerNetwork(),
                             cache: Cache<Answer>(path: "Answers"))
    }
    
//    public func createCategoryUseCase() -> Domain.CategoryUseCase {
//        return nil
//    }
}