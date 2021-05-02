//
//  DigitalClockDotView.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 5/2/21.
//

import UIKit

/// Digital Clock Dot seperator
class DigitalClockDotView: UIView {
    private lazy var topDot: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        return view
    } ()

    private lazy var bottomDot: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.white.cgColor
        addSubview(view)
        return view
    } ()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setConstraints()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)
        // make circle
        topDot.layer.cornerRadius = rect.width / 8
        bottomDot.layer.cornerRadius = rect.width / 8
    }

    private func setConstraints() {
        let topWrapper = UIView()
        topWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(topWrapper)
        topWrapper.addSubview(topDot)

        let bottomWrapper = UIView()
        bottomWrapper.translatesAutoresizingMaskIntoConstraints = false
        addSubview(bottomWrapper)
        bottomWrapper.addSubview(bottomDot)

        NSLayoutConstraint.activate([
            topWrapper.leadingAnchor.constraint(equalTo: leadingAnchor),
            topWrapper.trailingAnchor.constraint(equalTo: trailingAnchor),
            topWrapper.topAnchor.constraint(equalTo: topAnchor),
            topWrapper.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.5)
        ])

        NSLayoutConstraint.activate([
            bottomWrapper.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomWrapper.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomWrapper.topAnchor.constraint(equalTo: topWrapper.bottomAnchor),
            bottomWrapper.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])

        NSLayoutConstraint.activate([
            topDot.centerXAnchor.constraint(equalTo: topWrapper.centerXAnchor),
            topDot.centerYAnchor.constraint(equalTo: topWrapper.centerYAnchor),
            topDot.widthAnchor.constraint(equalTo: topWrapper.widthAnchor, multiplier: 0.25),
            topDot.heightAnchor.constraint(equalTo: topDot.widthAnchor)
        ])

        NSLayoutConstraint.activate([
            bottomDot.centerXAnchor.constraint(equalTo: bottomWrapper.centerXAnchor),
            bottomDot.centerYAnchor.constraint(equalTo: bottomWrapper.centerYAnchor),
            bottomDot.widthAnchor.constraint(equalTo: topDot.widthAnchor),
            bottomDot.heightAnchor.constraint(equalTo: topDot.heightAnchor)
        ])
    }
}
