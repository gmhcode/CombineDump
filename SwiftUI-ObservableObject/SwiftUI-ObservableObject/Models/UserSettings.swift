//
//  UserSettingssa.swift
//  SwiftUI-ObservableObject
//
//  Created by Greg Hughes on 10/20/20.
//

import Foundation
import SwiftUI
import Combine

class UserSettings: ObservableObject {
    @Published var score: Int = 0
}
