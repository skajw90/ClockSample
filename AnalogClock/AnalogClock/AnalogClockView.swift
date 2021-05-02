//
//  AnalogClockView.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 4/24/21.
//

import UIKit

class AnalogClockView: UIView {
    private let numbers: [String] = ["12", "1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11"]
    private var hourHand = TickHand(type: .hour)
    private var minHand = TickHand(type: .minute)
    private var secHand = TickHand(type: .second)
    private var numLabels: [UILabel] = []
    private lazy var midCircle: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemRed
        view.layer.cornerRadius = 10
        view.layer.masksToBounds = true
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.black.cgColor
        addSubview(view)
        return view
    } ()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.addSublayer(hourHand)
        layer.addSublayer(minHand)
        layer.addSublayer(secHand)
        NSLayoutConstraint.activate([
            midCircle.centerXAnchor.constraint(equalTo: centerXAnchor),
            midCircle.centerYAnchor.constraint(equalTo: centerYAnchor),
            midCircle.widthAnchor.constraint(equalToConstant: 20),
            midCircle.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        for _ in 0 ..< 12 {
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
            label.textColor = .black
            addSubview(label)
            numLabels.append(label)
        }
        
        backgroundColor = .white
        layer.masksToBounds = true
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        configuration()
    }
    
    private func configuration() {
        drawCircle()
        drawTicks()
        drawNumbers()
    }
    
    private func drawCircle() {
        layer.cornerRadius = bounds.width / 2
        layer.borderColor = UIColor.black.cgColor
        layer.borderWidth = 2
    }
    
    private func drawTicks() {
        for i in 0 ..< 60 {
            drawTick(index: i)
        }
    }
    
    private func drawTick(index: Int) {
        let tickHeight: CGFloat = index % 5 == 0 ? 15 : 8
        let angle = 2 * CGFloat.pi * CGFloat(index) / 60
        let radius = bounds.width / 2
        let yPosFrom = bounds.midY - radius * cos(angle)
        let xPosFrom = bounds.midX + radius * sin(angle)
        
        let yPosTo = bounds.midY - (radius - tickHeight) * cos(angle)
        let xPosTo = bounds.midX + (radius - tickHeight) * sin(angle)

        let line = UIBezierPath()
        line.move(to: CGPoint(x: xPosFrom, y: yPosFrom))
        line.addLine(to: CGPoint(x: xPosTo, y: yPosTo))
        line.close()
        
        line.lineWidth = index % 5 == 0 ? 3 : 1.5
        line.stroke()
    }
    
    private func drawNumbers() {
        for i in 0 ..< 12 {
            drawNumber(index: i)
        }
    }
    
    private func drawNumber(index: Int) {
        let number = numbers[index]
        numLabels[index].text = number
        numLabels[index].sizeToFit()
        let angle = 2 * CGFloat.pi * CGFloat(index) / 12
        let radius = bounds.width / 2 - 15 - 15
        let xPos = bounds.midX + radius * sin(angle)
        let yPos = bounds.midY - radius * cos(angle)
        
        numLabels[index].center = CGPoint(x: xPos, y: yPos)
    }
    
    func drawHands(hour: Int = 0, minute: Int = 0, second: Int = 0) {
        let mid = CGPoint(x: bounds.midX, y: bounds.midY)
        let radius = bounds.width / 2
        hourHand.drawPath(value: hour, mid: mid, radius: radius)
        minHand.drawPath(value: minute, mid: mid, radius: radius)
        secHand.drawPath(value: second, mid: mid, radius: radius)
    }
}
