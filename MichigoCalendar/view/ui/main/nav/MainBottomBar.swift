//
//  BottomBar.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import SwiftUI

struct MainBottomBar: View {
    
    @ObservedObject var mainViewModel: MainViewModel
    
    let items: [Team] = [.michigo, .diemons]
    
    var body: some View {
        HStack(spacing: 8) {
            ForEach(items, id: \.self) { item in
                MainBottomNavItem(
                    selected: item == mainViewModel.currentTeam, // item과 currentTeam 비교
                    item: item,
                    onClick: {
                        mainViewModel.setTeam(by: item)
                    }
                )
            }
        }
        .padding(.vertical, 10)
        .frame(maxWidth: .infinity, alignment: .center)
        .background(Color("BottomBarColor"))
    }
}
