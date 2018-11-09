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
        return .half
    }

    var supportedPositions: Set<FloatingPanelPosition> {
        return [.tip, .half]
    }

    func insetFor(position: FloatingPanelPosition) -> CGFloat? {
        switch position {
        case .full: return nil
        case .half: return 140.0
        case .tip: return 0.0
        }
    }

}
