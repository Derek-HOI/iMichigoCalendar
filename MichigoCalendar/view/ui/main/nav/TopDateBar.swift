//
//  TopDateBar.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/2/25.
//

import SwiftUI

struct TopDateBar: View {
    
    @ObservedObject var mainViewModel: MainViewModel

    var body: some View {
        HStack {
            Button(action: {
                // 이전 달
                mainViewModel.prevMonth()
            }) {
                Image(systemName: "chevron.left")
            }
            
            Spacer()
            
            Text(mainViewModel.currentDateText())
                .font(.headline)
            
            Spacer()
            
            Button(action: {
                // 다음 달
                mainViewModel.nextMonth()
            }) {
                Image(systemName: "chevron.right")
            }
        }
        .padding()
    }
    
}

struct TopDateBar_Previews: PreviewProvider {
    
    static var previews: some View {
        let mockViewModel = MockMainViewModel()
        VStack {
            TopDateBar(mainViewModel: mockViewModel)
            Spacer()
        }
    }
}
