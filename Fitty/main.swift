//
//  main.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 10.12.21.
//

import Foundation

import ArgumentParser

struct decode: ParsableCommand {
    @Argument(help: "Pathes to FIT file")
    var pathes: [String]
    @Flag var verbose = false
    
    static let configuration = CommandConfiguration(
            abstract: "Read Heart rates in FIT Monitoring File")
    func run() {
        for path in pathes {
        _ = DecodeWithBroadcaster(path: path)
        }
    }
}
/* main */
decode.main()
//for argv in CommandLine.arguments[1...] {
//
//    _ = DecodeWithBroadcaster(path: argv)
//}
