//
//  GameScheduleParser.swift
//  MichigoCalendar
//
//  Created by 변양진 on 1/6/25.
//

import SwiftSoup
import SwiftUI

extension Document {
    /// Match Date를 HTML에서 파싱
    func getMatchDate() -> String {
        (try? select(DivMatchDate).first()?.html().replaceBrToSpace()) ?? MsgNotFound
    }

    /// League Info를 HTML에서 파싱
    func getLeagueInfo() -> String {
        (try? select(DivLeagueInfo).first()?.text()) ?? MsgNotFound
    }

    /// 특정 팀 정보 (Left/Right Team)를 HTML에서 파싱
    func getTeam(isLeft: Bool) -> TeamInfo {
        let element = try? select(isLeft ? DivLeftTeam : DivRightTeam).first()

        let name = (try? element?.select(SpanTeamName).first()?.text()) ?? MsgNotFound
        let logoPath = (try? element?.select(ImgTeamLogo).first()?.attr(AttrSrc))
        let logo = logoPath != nil ? BASE_URL + (logoPath ?? "") : nil
        let score = Int((try? element?.select(SpanScore).first()?.text()) ?? "0") ?? 0
        let isBlue = (try? element?.select(SpanScore).first()?.hasClass("blue")) ?? false
        let scoreColor: Color = isBlue ? .blue : .red

        return TeamInfo(name: name, logo: logo, score: score, scoreColor: scoreColor)
    }

    /// GameState를 HTML에서 파싱
    func getGameState() -> GameState {
        let finishMatchElement = try? select(DivFinishMatch).first()
        if let resultElement = try? finishMatchElement?.select(SpanResult).first(),
           resultElement.hasClass(SpanResultSep) == true {
            return .finished
        } else if finishMatchElement != nil {
            return .ongoing
        } else {
            return .upcoming
        }
    }

    /// 추가 정보 파싱
    func getAdditional() -> [String: String] {
        var result = [String: String]()

        do {
            let elements = try select(DivButtonAreaAnchor)
            for element in elements {
                let href = try element.attr(AttrHref)
                if href != HrefNull {
                    if href.contains("highlight") {
                        result["highlight"] = BASE_URL + href
                    } else {
                        result["details"] = BASE_URL + href
                    }
                }
            }
        } catch {
            print("Error parsing additional info: \(error)")
        }

        return result
    }
}

extension String {
    /// <br> 태그와 줄바꿈을 공백으로 치환
    func replaceBrToSpace() -> String {
        self.replacingOccurrences(of: "<br>", with: ", ").replacingOccurrences(of: "<br />", with: ", ").replacingOccurrences(of: "\n", with: "")
    }
}
