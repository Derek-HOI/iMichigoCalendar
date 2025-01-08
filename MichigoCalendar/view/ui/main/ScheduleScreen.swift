//
//  ScheduleScreen.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import SwiftUI

struct ScheduleScreen: View {
    
    @ObservedObject var mainViewModel: MainViewModel

    let onClick: (String) -> Void

    var body: some View {
        if mainViewModel.gameSchedule.isEmpty {
            VStack {
                Text("\(mainViewModel.currentDateText()) 일정 없어요.\n쉬세요.")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        } else {
            ScrollView {
                VStack(spacing: 16) {
                    ForEach(mainViewModel.gameSchedule, id: \.id) { schedule in
                        ScheduleItem(schedule: schedule, onClick: onClick)
                    }
                }
                .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
    }
    
}
