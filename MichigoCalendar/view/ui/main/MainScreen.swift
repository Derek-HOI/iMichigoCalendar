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
    @State private var showWebView = false
    
    init(container: Container = configureDIContainer()) {
        // DI 컨테이너를 사용해 mainViewModel 초기화
        let viewModel = container.resolve(MainViewModel.self)!
        _mainViewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            TopDateBar(mainViewModel: mainViewModel)
            
            ScheduleScreen(
                mainViewModel: mainViewModel,
                onClick: { url in
                    mainViewModel.url = url
                }
            )
            
            MainBottomBar(mainViewModel: mainViewModel)
        }
//        .fullScreenCover(isPresented: $showWebView) {
//            WebViewDialog(showWebView: $showWebView, url: URL(string: mainViewModel.url)!)
//        }
        .fullScreenCover(isPresented: Binding(
            get: { !mainViewModel.url.isEmpty },  // URL이 비어 있지 않은 경우 표시
            set: { if !$0 { mainViewModel.url = "" } } // URL을 비우면 웹뷰를 닫음
        )) {
            if let url = URL(string: mainViewModel.url) {
                WebViewDialog(url: url, onDismiss: {
                    mainViewModel.url = "" // 닫을 때 URL 초기화
                })
            }
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
