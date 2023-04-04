//
//  utils.swift
//  Memory Lane
//
//  Created by Niklas Fischer on 4/4/23.
//

import Foundation

func dateFormatter() -> DateFormatter {
    let formatter = DateFormatter()
    formatter.dateStyle = .long
    formatter.timeStyle = .none
    return formatter
}
