//
//  Task.swift
//  AOA
//
//  Created by Fransiscus Verrol Yaurentius on 13/09/23.
//

import Foundation

struct Task: Hashable{
    let ownerId: String
    let title: String
    let deadline: Date
    let category: String
}
