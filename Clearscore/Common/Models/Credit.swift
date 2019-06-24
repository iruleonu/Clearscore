//
//  Credit.swift
//  Clearscore
//
//  Created by Nuno Salvador on 23/06/2019.
//  Copyright © 2019 Nuno Salvador. All rights reserved.
//

import Foundation

struct Credit: Codable {
    let creditReportInfo: CreditReportInfo
    
    enum CodingKeys: String, CodingKey {
        case creditReportInfo
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let creditReportInfo = try container.decode(CreditReportInfo.self, forKey: .creditReportInfo)
        self.init(creditReportInfo: creditReportInfo)
    }
    
    init(creditReportInfo: CreditReportInfo) {
        self.creditReportInfo = creditReportInfo
    }
}
