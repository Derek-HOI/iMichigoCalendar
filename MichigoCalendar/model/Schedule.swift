//
//  Schedule.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/3/25.
//

import Foundation
import SwiftUI

struct Schedule {
    let id = UUID() // For unique identification in SwiftUI lists
    let date: Date
    let matchDate: String // "yyyy년 MM월 dd일\nHH:mm\n소망야구장" 형식
    let leagueInfo: String // "소망주말리그 - 소망토요#부"
    let leftTeam: TeamInfo
    let rightTeam: TeamInfo
    let gameState: GameState
    let highlight: String?
    let details: String?

    // Formatter to parse and format dates
    static let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy년 MM월 dd일\nHH:mm\n소망야구장"
        return formatter
    }()
}
