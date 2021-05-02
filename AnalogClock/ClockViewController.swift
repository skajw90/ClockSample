//
//  ViewController.swift
//  AnalogClock
//
//  Created by Jiwon Nam on 4/24/21.
//

import UIKit

class ClockViewController: UIViewController {
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 30, weight: .bold)
        label.textColor = .black
        label.text = "CLOCK PROJECT"
        view.addSubview(label)
        return label
    } ()
    
    private lazy var analogClockTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "ANALOG CLOCK"
        view.addSubview(label)
        return label
    } ()
    
    private lazy var clockView: AnalogClockView = {
        let clockView = AnalogClockView()
        clockView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clockView)
        return clockView
    } ()
    
    private lazy var digitalClockTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        label.textColor = .white
        label.text = "DIGITAL CLOCK"
        view.addSubview(label)
        return label
    } ()
    
    private lazy var digitalClock: DigitalClockView = {
       let clock = DigitalClockView()
        clock.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(clock)
        return clock
    } ()
    
    private var timer: Timer!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.systemOrange
        setConstraints()
        tickCurrentTime()
        startTimer()
    }
    
    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 0.1, target: self, selector: #selector(tickCurrentTime), userInfo: nil, repeats: true)
        timer.fire()
    }
    
    @objc private func tickCurrentTime() {
        let date = Date()
        let calendar = Calendar.current
        
        let hour = calendar.component(.hour, from: date)
        let min = calendar.component(.minute, from: date)
        let sec = calendar.component(.second, from: date)
        clockView.drawHands(hour: hour, minute: min, second: sec)
        digitalClock.setCurrentTime(hour: hour, minute: min, second: sec)
    }
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            analogClockTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            analogClockTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            analogClockTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            clockView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clockView.topAnchor.constraint(equalTo: analogClockTitleLabel.bottomAnchor, constant: 30),
            clockView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -60),
            clockView.heightAnchor.constraint(equalTo: view.widthAnchor, constant: -60)
        ])
        
        NSLayoutConstraint.activate([
            digitalClockTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            digitalClockTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            digitalClockTitle.topAnchor.constraint(equalTo: clockView.bottomAnchor, constant: 30)
        ])
        
        NSLayoutConstraint.activate([
            digitalClock.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            digitalClock.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
            digitalClock.topAnchor.constraint(equalTo: digitalClockTitle.bottomAnchor, constant: 30)
        ])
    }


}

