//
//  ScheduleItem.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import SwiftUI

struct ScheduleItem: View {
    
    let schedule: Schedule
    let onClick: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(schedule.matchDate)
                .font(.system(size: 12))
                .foregroundColor(.gray)

            Text(schedule.leagueInfo)
                .font(.system(size: 12))
                .foregroundColor(.blue)

            Text(schedule.gameState.text)
                .font(.system(size: 12))
                .foregroundColor(.white)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(schedule.gameState.color)
                .cornerRadius(50)

            HStack(alignment: .center, spacing: 8) {
                TeamItem(team: schedule.leftTeam)
                Text("VS")
                    .font(.system(size: 16))
                    .foregroundColor(.black)
                TeamItem(team: schedule.rightTeam)
            }.frame(maxWidth: .infinity)

            HStack(spacing: 8) {
                LinkButton(text: "하이라이트", enabled: schedule.highlight != nil, onClick: {
                    if let highlight = schedule.highlight {
                        onClick(highlight)
                    }
                })
                LinkButton(text: "경기 결과 상세 보기", enabled: schedule.details != nil, onClick: {
                    if let details = schedule.details {
                        onClick(details)
                    }
                })
            }
            .frame(maxWidth: .infinity)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(6)
        .shadow(radius: 2)
        .frame(maxWidth: .infinity)
    }
}

struct TeamItem: View {
    let team: TeamInfo

    var body: some View {
        VStack {
            if let logo = team.logo {
                AsyncImage(url: URL(string: logo)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView() // 로딩 중
                    case .success(let image):
                        image
                            .resizable()
                            .frame(width: 40, height: 40)
                            .scaledToFit() // 이미지 표시
                    case .failure:
//                        Image(systemName: "photo") // 오류 시 대체 이미지
                        Spacer()
                            .frame(width: 40, height: 40)
                            .background(.gray)
                    @unknown default:
                        EmptyView()
                    }
                }//.frame(width: 40, height: 40)
                    
            }
            Text(team.name)
                .font(.system(size: 12))
                .foregroundColor(team.scoreColor)
            Text("\(team.score)")
                .font(.system(size: 16))
                .foregroundColor(.black)
        }
    }
}

struct LinkButton: View {
    let text: String
    let enabled: Bool
    let onClick: () -> Void

    var body: some View {
        Button(action: {
            if enabled {
                onClick()
            }
        }) {
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(enabled ? .black : .gray)
                .padding()
        }
        .background(
            RoundedRectangle(cornerRadius: 8)
                .stroke(Color.gray, lineWidth: 1)
        )
        .frame(maxWidth: .infinity)
        .disabled(!enabled)
    }
}
