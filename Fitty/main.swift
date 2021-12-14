//
//  main.swift
//  Fitty
//
//  Created by Hans-Peter Bodden on 10.12.21.
//

import Foundation

import ArgumentParser

struct decode: ParsableCommand {
    @Flag var verbose = false
    
    @Argument(help: "Pathes to FIT file")
    var path: [String]
    static let configuration = CommandConfiguration(
        commandName: "fitty",
        abstract: "Read Heart rates in FIT Monitoring File"
    )
    mutating func validate() throws {

        let fm = FileManager()
        guard !path.isEmpty else {
            throw ValidationError("Please provide at least one element to choose from.")
        }
        for thePath in path {
            var isDirectory : ObjCBool = false
            if fm.fileExists(atPath: thePath, isDirectory: &isDirectory) {
                guard !isDirectory.boolValue else {
                    throw ValidationError("\(thePath) is a directory")
                }
                
            } else {
                throw ValidationError("File \(thePath) does not exist")
            }
        }
    }

    func run() throws {
        for the_path in path {
            guard let _ = DecodeWithBroadcaster(path: the_path, verbose: verbose) else {
                throw ExitCode.failure
            }
        }
    }
}
/* main */
decode.main()
