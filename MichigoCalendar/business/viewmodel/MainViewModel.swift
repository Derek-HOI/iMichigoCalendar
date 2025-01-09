//
//  MainViewModel.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/2/25.
//

import Foundation
import Moya
import SwiftSoup

class MainViewModel: ObservableObject {
    
    private let apiProvider: MoyaProvider<GameScheduleAPI>
    
    //TODO url is not blank -> show webview.
    @Published var url: String = ""
    
    @Published var currentTeam: Team = .michigo
    @Published var currentDate = Date()
    @Published var gameSchedule: [Schedule] = []
    
    //TODO
    init(apiProvider: MoyaProvider<GameScheduleAPI>) {
        self.apiProvider = apiProvider
    }

    /**
     * 팀 변경
     */
    func setTeam(by team: Team) {
        if (team != currentTeam) {
            currentTeam = team
            getGameSchedule()
        }
    }
    
    // 월 변경 메서드
    private func changeMonth(by value: Int) {
        if let newDate = Calendar.current.date(byAdding: .month, value: value, to: currentDate) {
            currentDate = newDate
        }
    }
    
    /**
     * 다음 달
     */
    func nextMonth() {
        changeMonth(by: 1)
        getGameSchedule()
    }
    
    /**
     * 이전 달
     */
    func prevMonth() {
        changeMonth(by: -1)
        getGameSchedule()
    }
    
    func getGameSchedule() {
        getGameSchedule(teamSeq: currentTeam.rawValue, thisYear: Calendar.current.component(.year, from: currentDate), thisMonth: Calendar.current.component(.month, from: currentDate))
    }
    
    func getGameSchedule(teamSeq: Int, thisYear: Int, thisMonth: Int) {
        
        gameSchedule.removeAll()
        
        let keyHighlight = "highlight"
        let keyDetails = "details"
        
        getSaturdays(year: thisYear, month: thisMonth).forEach { date in
            
            apiProvider.request(.getGameSchedule(teamSeq: teamSeq, thisYear: thisYear, thisMonth: thisMonth, thisDay: getDay(from: date))) { [weak self] result in
                switch result {
                case .success(let response):
                    if let html = String(data: response.data, encoding: .utf8) {
                        do {
                            // SwiftSoup의 throwing 메서드 처리
                            let document = try SwiftSoup.parse(html)
                            
                            if (try document.select(DivEmptyMatch).isEmpty()) {
                                let additional = document.getAdditional()
                                
                                let schedule = Schedule(
                                    date: date,
                                    matchDate: document.getMatchDate(),
                                    leagueInfo: document.getLeagueInfo(),
                                    leftTeam: document.getTeam(isLeft: true),
                                    rightTeam: document.getTeam(isLeft: false),
                                    gameState: document.getGameState(),
                                    highlight: additional[keyHighlight],
                                    details: additional[keyDetails]
                                )

                                DispatchQueue.main.async {
                                    self?.gameSchedule.append(schedule)
                                    self?.gameSchedule.sort(by: { $0.date < $1.date })
                                    print("HTML Response: \(html)")
                                }
                            }
                        } catch {
                            print("Error parsing HTML with SwiftSoup: \(error)")
                        }
                    } else {
                        print("Failed to decode HTML response.")
                    }
                case .failure(let error):
                    print("API request failed: \(error.localizedDescription)")
                }
            }
        }
    }
    
    // 현재 날짜를 "YYYY년 MM월" 형식으로 표시
    func currentDateText() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY년 MM월"
        return formatter.string(from: currentDate)
    }
}

/**
 * 테스트용 mocking view model
 */
class MockMainViewModel: MainViewModel {
    init() {
        // Mock API Provider를 사용하여 초기화
        let mockProvider = MockGameScheduleAPIProvider.createMockProvider()
        super.init(apiProvider: mockProvider)

        // Mock 초기 데이터 설정
        self.currentDate = Date()
        self.gameSchedule = [
            Schedule(
                date: Date(),
                matchDate: "2025년 01월 01일\n12:00\n소망야구장",
                leagueInfo: "소망주말리그 - 소망토요#부",
                leftTeam: TeamInfo(name: "팀A", logo: nil, score: 6, scoreColor: .blue),
                rightTeam: TeamInfo(name: "팀B", logo: nil, score: 5, scoreColor: .red),
                gameState: .upcoming,
                highlight: nil,
                details: nil
            )
        ]
    }

    override func getGameSchedule(teamSeq: Int, thisYear: Int, thisMonth: Int) {
        // Mock API 응답 설정
        DispatchQueue.main.async {
            _ = """
            <html>
                <body>
                    <h1>Mock Schedule for \(thisYear)-\(thisMonth)-none</h1>
                </body>
            </html>
            """
            print("Mock API called for teamSeq: \(teamSeq)")
        }
    }
}
