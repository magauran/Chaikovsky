//
//  UITableViewCell+Reuse.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

extension UITableView {

    func dequeueReusableCell<T: UITableViewCell>(for indexPath: IndexPath) -> T {
        let identifier = T.className
        return dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! T
    }

}

