//
//  Timeout.swift
//  Flag Game
//
//  Created by Rzayev Gara on 23.02.23.
//

import Foundation

class Timeout: NSObject {
    private var timer: Timer?
    private var callback: (() -> Void)?

    init(_ delaySeconds: TimeInterval, _ callback: @escaping () -> Void) {
        super.init()
        self.callback = callback
        self.timer = Timer.scheduledTimer(
            timeInterval: TimeInterval(delaySeconds),
            target: self,
            selector: #selector(invoke),
            userInfo: nil,
            repeats: false
        )
    }

    @objc func invoke() {
        self.callback?()
        self.callback = nil
        self.timer = nil
    }

    func cancel() {
        self.timer?.invalidate()
        self.timer = nil
    }
}
