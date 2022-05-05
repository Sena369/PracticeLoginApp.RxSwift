//
//  ViewModel.swift
//  LoginApp.RxSwift
//
//  Created by 澤田世那 on 2022/05/05.
//

import RxSwift
import RxCocoa

final class ViewModel {
    let validationText: Observable<String>
    let loadLabelColor: Observable<UIColor>
    
    init(idTextObservable: Observable<String?>,
         passwordTextObservable: Observable<String?>,
         model: ModelProtocol) {
    
             let event = Observable
                 .combineLatest(idTextObservable, passwordTextObservable)
                 .skip(1)
                 .flatMap { idText, passwordText -> Observable<Event<Void>> in
                     return model
                         .validate(idText: idText, passwordText: passwordText)
                         .materialize()
                 }
                 .share()
             
             self.validationText = event
                 .flatMap { event -> Observable<String> in
                     switch event {
                     case .next:
                         return .just("OK!!!")
                     case let .error(error as ModelError):
                         return .just(error.errorText)
                     case .error, .completed:
                         return .empty()
                     }
                 }
                 .startWith("IDとPasswordを入力してください。")
             
             self.loadLabelColor = event
                 .flatMap { event -> Observable<UIColor> in
                     switch event {
                     case .next:
                         return .just(.green)
                     case .error:
                         return .just(.red)
                     case .completed:
                         return .empty()
                     }
                 }
         }
}
