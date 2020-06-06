//
//  ButtonExtension.swift
//  openCard
//
//  Created by Joey Liu on 6/2/20.
//  Copyright © 2020 Joey Liu. All rights reserved.
//

import UIKit

extension Array {
    mutating func makeRandomNumbers(start:Int, end: Int) {
            for i in start...end {
                self.append(i as! Element)
            }
        self.shuffle()
    }
}
