//
//  main.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 10.12.21.
//

import Foundation

/* main */
for argv in CommandLine.arguments[1...] {

    _ = DecodeWithBroadcaster(path: argv)
}
