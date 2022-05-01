//
//  CustomSocket.swift
//  TradeTable
//
//  Created by 劉聖龍 on 2022/5/1.
//

import Foundation
import Starscream

class CustomSocket {
    private let request = URLRequest(url: URL(string: "wss://stream.yshyqxx.com/stream?streams=btcusdt@trade")!)
    private var socket: WebSocket
    private var handleReceiveData: (_ data: String) -> Void
    
    init(updataDataMethod callback: @escaping (_ data: String) -> Void) {
        self.handleReceiveData = callback

        self.socket = WebSocket(request: self.request)
        self.socket.onEvent = { event in self.didReceive(event: event)}
    }
    
    public func connect() {
        self.socket.connect()
    }
    
    public func disConnect() {
        self.socket.disconnect()
    }
    
    private func didReceive(event: WebSocketEvent) {
        switch event {
        case .connected(let headers):
            print("websocket is connected: \(headers)")
        case .disconnected(let reason, let code):
            print("websocket is disconnected: \(reason) with code: \(code)")
        case .text(let string):
            self.handleReceiveData(string)
        default:
            break
        }
    }
}
