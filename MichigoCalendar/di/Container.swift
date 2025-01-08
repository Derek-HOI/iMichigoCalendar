//
//  container.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import Swinject
import Moya

func configureDIContainer() -> Container {
    let container = Container()
    container.register(MoyaProvider<GameScheduleAPI>.self) { _ in
        MoyaProvider<GameScheduleAPI>()
    }
    container.register(MainViewModel.self) { resolver in
        let provider = resolver.resolve(MoyaProvider<GameScheduleAPI>.self)!
        return MainViewModel(apiProvider: provider)
    }
    return container
}
