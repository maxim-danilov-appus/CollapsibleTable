//
//  ArrowSectionHeaderView.swift
//  CollapsibleTableDemo
//
//  Created by Robert Nash on 09/08/2017.
//  Copyright © 2017 Robert Nash. All rights reserved.
//

import UIKit
import CollapsibleTable

class ArrowSectionHeaderView: UITableViewHeaderFooterView
{
    @IBOutlet fileprivate weak var mainTitleLabel: UILabel!
    
    @IBOutlet fileprivate weak var arrowImageView: UIImageView?
    
    fileprivate var isRotating = false
}

extension ArrowSectionHeaderView: HeaderFooterViewCollapsible
{
    func updateTitle(with value: String) {
        mainTitleLabel.text = value
    }
    
    func open(animated: Bool) {
        if animated == true && isRotating == false {
            isRotating = true
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear,.allowUserInteraction], animations: {
                self.arrowImageView?.transform = .identity
            }, completion: { _ in
                self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            arrowImageView?.transform = .identity
            isRotating = false
        }
    }
    
    private func radians(degrees: CGFloat) -> CGFloat {
        return .pi * degrees / 180
    }
    
    func close(animated: Bool) {
        let angle = radians(degrees: 90)
        let transform = CGAffineTransform(rotationAngle: angle)
        if animated == true && isRotating == false {
            isRotating = true
            UIView.animate(withDuration: 0.2, delay: 0, options: [.curveLinear,.allowUserInteraction], animations: {
                self.arrowImageView?.transform = transform
            }, completion: { _ in
                self.isRotating = false
            })
        } else {
            layer.removeAllAnimations()
            arrowImageView?.transform = transform
            isRotating = false
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesEnded(touches, with: event)
        guard let t = touches.first else { return }
        let point = t.location(in: self)
        respondToTouchAtPoint(point)
    }
}
