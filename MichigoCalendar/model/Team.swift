//
//  Team.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

enum Team: Int, Hashable {
    case michigo = 292
    case diemons = 212
    
    var name: String {
        switch self {
        case .michigo: return "미치고"
        case .diemons: return "다이몬즈"
        }
    }
}
