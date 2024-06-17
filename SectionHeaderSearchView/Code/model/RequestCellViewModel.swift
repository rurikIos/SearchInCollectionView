//
//  RequestCellViewModel.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import Foundation

struct RequestCellViewModel: Hashable {
    static func == (lhs: RequestCellViewModel, rhs: RequestCellViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    let uuid: UUID
    let companyName: String
    let requestName: String
    let cost: String
}

extension RequestCellViewModel {
    init(companyName: String, requestName: String, cost: String) {
        uuid = UUID()
        self.companyName = companyName
        self.requestName = requestName
        self.cost = cost
    }
}
