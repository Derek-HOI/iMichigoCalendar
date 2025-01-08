//
//  MainBottomNavItem.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import SwiftUI

struct MainBottomNavItem: View {
    let selected: Bool
    let item: Team
    let onClick: () -> Void
    
    var body: some View {
        Text(item.name) // `name`은 이미 문자열 반환
            .foregroundColor(selected ? .white : .gray)
            .font(.system(size: 16, weight: selected ? .bold : .regular))
            .padding(8)
            .onTapGesture {
                onClick()
            }
    }
}
