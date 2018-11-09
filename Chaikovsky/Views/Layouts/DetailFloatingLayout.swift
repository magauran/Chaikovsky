//
//  DetailFloatingLayout.swift
//  Chaikovsky
//
//  Created by Алексей on 09/11/2018.
//  Copyright © 2018 Алексей. All rights reserved.
//

import FloatingPanel

class DetailFloatingPanelLayout: FloatingPanelLayout {

    var initialPosition: FloatingPanelPosition {
        return .tip
    }

    var supportedPositions: Set<FloatingPanelPosition> {
        return [.tip, .half, .full]
    }

    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return 40.0
        case .half: return 270.0
        case .tip: return 70.0
        }
    }

}
