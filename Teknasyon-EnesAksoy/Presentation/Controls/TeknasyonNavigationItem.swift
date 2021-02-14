//
//  TeknasyonNavigationItem.swift
//  Teknasyon-EnesAksoy
//
//  Created by ENES AKSOY on 14.02.2021.
//  Copyright © 2021 ENES AKSOY. All rights reserved.
//

import Foundation
import UIKit

class TeknasyonNavigationItem: UINavigationItem {
    @IBInspectable var localizableKey: String? = nil {
        didSet {
            if localizableKey != nil {
                self.title = NSLocalizedString(localizableKey!, comment: "")
            }
        }
    }
}
