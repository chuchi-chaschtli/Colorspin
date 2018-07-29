//
//  Build.swift
//  Colorspin
//
//  Created by Anand Kumar on 7/28/18.
//  Copyright © 2018 Anand Kumar. All rights reserved.
//

import Foundation

class Build {
    static var isRunningUnitTests: Bool {
        #if DEBUG
            return ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
        #else
            return false
        #endif
    }
}
