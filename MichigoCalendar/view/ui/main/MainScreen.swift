//
//  MainScreen.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/2/25.
//

import SwiftUI
import Swinject

struct MainScreen: View {
    
    @StateObject private var mainViewModel: MainViewModel
    
    init(container: Container = configureDIContainer()) {
        // DI 컨테이너를 사용해 mainViewModel 초기화
        let viewModel = container.resolve(MainViewModel.self)!
        _mainViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TopDateBar(mainViewModel: mainViewModel)
            
            //TODO item view
            ScheduleScreen(
                mainViewModel: mainViewModel,
                onClick: { url in
                    //TODO move url!
                }
            )
            
            MainBottomBar(mainViewModel: mainViewModel)
        }
        
//        NavigationSplitView {
//            List {
//                ForEach(items) { item in
//                    NavigationLink {
//                        Text("Item at \(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))")
//                    } label: {
//                        Text(item.timestamp, format: Date.FormatStyle(date: .numeric, time: .standard))
//                    }
//                }
//                .onDelete(perform: deleteItems)
//            }
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem {
//                    Button(action: addItem) {
//                        Label("Add Item", systemImage: "plus")
//                    }
//                }
//            }
//        } detail: {
//            Text("Select an item")
//        }
    }
}

#Preview {
    let container = configureDIContainer()
    MainScreen(container: container)
}
