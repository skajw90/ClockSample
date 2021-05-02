//
//  TickHand.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 5/2/21.
//

import UIKit

enum TickHandType {
    case hour
    case minute
    case second
    
    var capacity: Int {
        switch self {
        case .hour: return 12
        case .minute: return 60
        case .second: return 60
        }
    }
    
    var width: CGFloat {
        switch self {
        case .hour: return 10
        case .minute: return 5
        case .second: return 2
        }
    }
    
    var heightRatio: CGFloat {
        switch self {
        case .hour: return 1 / 2
        case .minute: return 2 / 3
        case .second: return 5 / 6
        }
    }
}

class TickHand: CAShapeLayer {
    
    var type: TickHandType = .second
    
    convenience init(type: TickHandType) {
        self.init()
        self.type = type
    }
    
    func drawPath(value: Int, mid: CGPoint, radius: CGFloat) {
        let path = UIBezierPath()
        let value = value % type.capacity
        let radius = radius * type.heightRatio
        
        let angle = 2 * CGFloat.pi * CGFloat(value) / CGFloat(type.capacity)
        let yPos = mid.y - radius * cos(angle)
        let xPos = mid.x + radius * sin(angle)
        
        path.move(to: mid)
        path.addLine(to: CGPoint(x: xPos, y: yPos))
        path.close()
        
        path.lineWidth = type.width
        
        self.path = path.cgPath
        self.lineWidth = type.width
        self.strokeColor = type == .second ? UIColor.red.cgColor : UIColor.black.cgColor
    }
    
}
