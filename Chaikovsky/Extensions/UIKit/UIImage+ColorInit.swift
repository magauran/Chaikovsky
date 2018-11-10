//
//  UIImage+ColorInit.swift
//  Chaikovsky
//
//  Created by Алексей on 10/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import UIKit

public extension UIImage {

    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }

}
