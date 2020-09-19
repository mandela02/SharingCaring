//
//  Session.swift
//  SharingCaring
//
//  Created by TriBQ on 9/20/20.
//

import Foundation
import RxAlamofire
import RxSwift

enum UrlType: String, CaseIterable {
    case categories

    var urlString: String {
        switch self {
        case .categories:
            return Constants.baseUrl + "categories"
        default:
            return ""
        }
    }
}

class Session {
    static let shared = Session()

    private init() {}
    private let disposeBag = DisposeBag()

    func getData() -> Observable<[Category]> {
        Observable.create {[weak self] observable in
            guard let self = self else {
                observable.onNext([])
                return Disposables.create()
            }
            RxAlamofire.requestData(.get, UrlType.categories.urlString)
                .observeOn(MainScheduler.instance)
                .mapObject(type: CategoriesResponse.self)
                .catchErrorJustReturn(CategoriesResponse())
                .subscribe(onNext: { categories in
                    observable.onNext(categories.response.categories)
                }, onCompleted: {observable.onCompleted()})
                .disposed(by: self.disposeBag)
            return Disposables.create()
        }
    }
}
