//
//  DateUtils.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import Foundation

func getSaturdays(year: Int, month: Int) -> [Date] {
    var calendar = Calendar.current
    calendar.timeZone = TimeZone.current

    // 해당 달의 첫 번째 날
    var components = DateComponents()
    components.year = year
    components.month = month
    components.day = 1
    components.hour = 0
    components.minute = 0
    components.second = 0

    guard let firstDayOfMonth = calendar.date(from: components) else {
        return []
    }

    // 해당 달의 마지막 날
    guard let range = calendar.range(of: .day, in: .month, for: firstDayOfMonth) else {
        return []
    }
    let lastDayOfMonth = range.count

    // 해당 달의 모든 날짜 중 토요일 필터링
    let saturdays = (1...lastDayOfMonth).compactMap { day -> Date? in
        components.day = day
        guard let date = calendar.date(from: components) else {
            return nil
        }
        if calendar.component(.weekday, from: date) == 7 { // 7은 토요일
            return date
        }
        return nil
    }

    return saturdays
}

func getDay(from date: Date) -> Int {
    let calendar = Calendar.current
    return calendar.component(.day, from: date)
}
