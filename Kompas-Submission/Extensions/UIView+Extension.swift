//
//  UIView+Extension.swift
//  Kompas-Submission
//
//  Created by Felinda Gracia Lubis on 07/01/22.
//

import UIKit

extension UIView {
    func roundCorner(withRadius radius: CGFloat?) {
        self.layer.cornerRadius = radius ?? 8
        self.clipsToBounds = true
    }
}
