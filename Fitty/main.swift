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
    
    static let commandName = URL(fileURLWithPath: CommandLine.arguments[0]).lastPathComponent
    static let configuration = CommandConfiguration(
        commandName: commandName,
        abstract: "Extract Heart rates from FIT Monitoring File"
    )
    
    mutating func validate() throws {

        guard !path.isEmpty else {
            throw ValidationError("Please provide at least one element to choose from.")
        }
        for thePath in path {
            var isDirectory : ObjCBool = false
            if FileManager.default.fileExists(atPath: thePath, isDirectory: &isDirectory) {
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
                throw ValidationError("Error while decoding")
            }
        }
    }
}
/* main */
decode.main()
