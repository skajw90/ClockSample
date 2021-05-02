//
//  DigitalClockComponent.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 5/2/21.
//

import UIKit

/// Single digital number view
class DigitalClockComponent: UIView {
    private var num: Int = 10
    private var segments: [DigitSegment] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        for _ in 0 ..< 7 {
            let segment = DigitSegment()
            segments.append(segment)
            layer.addSublayer(segment)
        }
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        let height = rect.width * 4 / 5
        let width = height / 8
        setSegmentNumber(value: 0)
        drawSegments(width: width, height: height)
    }
    
    /// segment number setter
    ///
    /// this function only change the color of segments.
    /// - Parameter value: single digit time component.
    func setSegmentNumber(value: Int) {
        if num == value { return }
        num = value
        
        let blacked = getSegment()
        for i in 0 ..< segments.count {
            segments[i].setColor(on: blacked.contains(i))
        }
    }
    
    /// helper function to get segment index by current number
    /// - Returns: list of segment index which need to be colored.
    private func getSegment() -> [Int] {
        if num == 0 { return [0, 1, 2, 3, 4, 6] }
        else if num == 1 { return [4, 6] }
        else if num == 2 { return [0, 2, 3, 5, 6] }
        else if num == 3 { return [0, 3, 4, 5, 6] }
        else if num == 4 { return [1, 4, 5, 6] }
        else if num == 5 { return [0, 1, 3, 4, 5] }
        else if num == 6 { return [0, 1, 2, 3, 4, 5] }
        else if num == 7 { return [0, 4, 6] }
        else if num == 9 { return [0, 1, 3, 4, 5, 6] }
        else { return [0, 1, 2, 3, 4, 5, 6] }
    }
    /*
     SEGMENT
     NOTE:
      0
    1   6
      5
    2   4
      3
     */
    
    /// draw segments.
    ///
    /// segement index note:
    ///
    ///       0
    ///
    ///     1   6
    ///
    ///       5
    ///
    ///     2   4
    ///
    ///       3
    /// - Parameters:
    ///   - width: width of segment bar
    ///   - height: height of segment bar
    private func drawSegments(width: CGFloat, height: CGFloat) {
        let originX = width / 2
        let originY = (bounds.height - 2 * (height + width / 2)) / 2
        segments[0].drawSegment(origin: CGPoint(x: 2 * originX, y: originY), axis: .horizontal, width: width, height: height)
        segments[1].drawSegment(origin: CGPoint(x: originX, y: originY + width / 2), axis: .vertical, width: width, height: height)
        segments[2].drawSegment(origin: CGPoint(x: originX, y: originY + width / 2 + height), axis: .vertical, width: width, height: height)
        segments[3].drawSegment(origin: CGPoint(x: 2 * originX, y: originY + height * 2), axis: .horizontal, width: width, height: height)
        segments[4].drawSegment(origin: CGPoint(x: height + originX, y: originY + width / 2 + height), axis: .vertical, width: width, height: height)
        segments[5].drawSegment(origin: CGPoint(x: 2 * originX, y: originY + height), axis: .horizontal, width: width, height: height)
        segments[6].drawSegment(origin: CGPoint(x: height + originX, y: originY + width / 2), axis: .vertical, width: width, height: height)
    }
}




/// Digital segment axis
///
/// contains vertical and horizontal
enum DigitSegmentAxis {
    case vertical
    case horizontal
}


/// Digit segment shape layer
class DigitSegment: CAShapeLayer {
    
    /// set fill color and stroke color if it is on. Otherwise, clear color.
    /// - Parameter on: Bool
    func setColor(on: Bool) {
        self.lineWidth = on ? 1 : 0
        self.fillColor = on ? UIColor.black.cgColor: UIColor.clear.cgColor
        self.strokeColor = UIColor.white.cgColor
    }
    
    /// set segment path
    /// - Parameters:
    ///   - origin: origin pos
    ///   - axis: segement axis
    ///   - width: segment width
    ///   - height: segment height
    func drawSegment(origin: CGPoint, axis: DigitSegmentAxis, width: CGFloat, height: CGFloat) {
        // default horizontal shape
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: width / 2))
        path.addLine(to: CGPoint(x: width / 2, y: 0))
        path.addLine(to: CGPoint(x: height - (width / 2), y: 0))
        path.addLine(to: CGPoint(x: height, y: width / 2))
        path.addLine(to: CGPoint(x: height - (width / 2), y: width))
        path.addLine(to: CGPoint(x: width / 2, y: width))
        path.addLine(to: CGPoint(x: 0, y: width / 2))
        path.close()
        
        // rotate vertical shape
        if axis == .vertical {
            var transform = CGAffineTransform.identity
            transform = transform.translatedBy(x: height / 2, y: height / 2)
            transform = transform.rotated(by: -.pi / 2)
            transform = transform.translatedBy(x: -height / 2, y: -height / 2)
            path.apply(transform)
        }
        
        path.apply(CGAffineTransform(translationX: origin.x, y: origin.y))
        
        self.path = path.cgPath
    }
    
}
