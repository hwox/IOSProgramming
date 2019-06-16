//
//  Like.swift
//  TranditionalHouse
//
//  Created by KPU_GAME on 17/06/2019.
//  Copyright © 2019 KPU_GAME. All rights reserved.
//

import Foundation
import UIKit


struct Like {
    var name: String?
    var memo: String?
    var rating: Int

    init(name: String?, memo: String?,  rating: Int) {
        self.name = name
        self.memo = memo
        self.rating = rating
    }
}
