//
//  CreditReportInfo.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

struct CreditReportInfo: Codable {
    let score: Int
    let maximumScore: Int
    
    enum CodingKeys: String, CodingKey {
        case score
        case maximumScore = "maxScoreValue"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let score = try container.decode(Int.self, forKey: .score)
        let maximumScore = try container.decode(Int.self, forKey: .maximumScore)
        self.init(score: score, maximumScore: maximumScore)
    }
    
    init(score: Int, maximumScore: Int) {
        self.score = score
        self.maximumScore = maximumScore
    }
}
