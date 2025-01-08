//
//  GameScheduleApi.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import Moya
import Foundation

enum GameScheduleAPI {
    case getGameSchedule(teamSeq: Int, thisYear: Int, thisMonth: Int, thisDay: Int)
}

extension GameScheduleAPI: TargetType {
    var baseURL: URL {
        return URL(string: "https://www.shbaseball.co.kr")!
    }

    var path: String {
        return "/teamPage/scheduleRecord/getGameSchedule.hs"
    }

    var method: Moya.Method {
        return .post
    }

    var task: Task {
        switch self {
        case .getGameSchedule(let teamSeq, let thisYear, let thisMonth, let thisDay):
            return .requestParameters(
                parameters: [
                    "teamSeq": teamSeq,
                    "thisYear": thisYear,
                    "thisMonth": thisMonth,
                    "thisDay": thisDay
                ],
                encoding: URLEncoding.queryString
            )
        }
    }

    var headers: [String: String]? {
        return ["Content-Type": "application/x-www-form-urlencoded"]
    }

    var sampleData: Data {
            switch self {
            case .getGameSchedule:
                return """
                <html>
                    <body>
                        <h1>Mock Game Schedule</h1>
                        <p>This is a mock HTML response for GameScheduleAPI.</p>
                    </body>
                </html>
                """.data(using: .utf8) ?? Data()
            }
        }
}

/**
 * mocking...
 */
class MockGameScheduleAPIProvider {
    static func createMockProvider() -> MoyaProvider<GameScheduleAPI> {
        let endpointClosure = { (target: GameScheduleAPI) -> Endpoint in
            let sampleResponse = EndpointSampleResponse.networkResponse(200, target.sampleData)
            return Endpoint(
                url: target.baseURL.appendingPathComponent(target.path).absoluteString,
                sampleResponseClosure: { sampleResponse },
                method: target.method,
                task: target.task,
                httpHeaderFields: target.headers
            )
        }

        return MoyaProvider(endpointClosure: endpointClosure, stubClosure: MoyaProvider.immediatelyStub)
    }
}
