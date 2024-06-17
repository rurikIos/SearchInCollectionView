//
//  CellViewModel.swift
//  SectionHeaderSearchView
//
//  Created by Чайков Ю.И. on 10.06.2024.
//

enum CellViewModel: Hashable {
    case company(CompanyCellViewModel)
    case search
    case request(RequestCellViewModel)
}
