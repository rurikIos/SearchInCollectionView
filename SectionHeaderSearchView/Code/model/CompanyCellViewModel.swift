//
//  CompanyCellViewModel.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

import Foundation

struct CompanyCellViewModel: Hashable {
    static func == (lhs: CompanyCellViewModel, rhs: CompanyCellViewModel) -> Bool {
        lhs.uuid == rhs.uuid
    }
    
    let uuid: UUID
    let name: String
    let count: String
}

extension CompanyCellViewModel {
    init(name: String, count: String) {
        uuid = UUID()
        self.name = name
        self.count = count
    }
}
