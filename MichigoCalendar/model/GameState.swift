//
//  class.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/3/25.
//

import SwiftUI

enum GameState {
    case upcoming
    case ongoing
    case finished

    var color: Color {
        switch self {
        case .upcoming:
            return Color.gray
        case .ongoing:
            return Color.blue // PersianBlue equivalent
        case .finished:
            return Color.red // SpeechRed equivalent
        }
    }

    var text: String {
        switch self {
        case .upcoming:
            return "경기 전"
        case .ongoing:
            return "경기 중"
        case .finished:
            return "경기 종료"
        }
    }
}
