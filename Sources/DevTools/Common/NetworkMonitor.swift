//
//  NetworkMonitor.swift
//  DevTools
//
//  Created by aleksejermolaev on 04.07.2021.
//

import Network

public protocol NetworkMonitorProtocol {
    var isConnected: Bool { get }
    func startMonitor()
    func stopMonitor()
}

public class NetworkMonitor: NetworkMonitorProtocol {
    public var isConnected: Bool { status == .satisfied }
    private let monitor: NWPathMonitor
    private var status: NWPath.Status

    public init() {
        self.monitor = NWPathMonitor()
        self.status = .requiresConnection
    }

    public func startMonitor() {
        monitor.pathUpdateHandler = { path in
            self.status = path.status
        }
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
    }

    public func stopMonitor() {
        monitor.cancel()
    }
}
