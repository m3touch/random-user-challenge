//
//  PlistEditorProtocol.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

protocol PlistEditorProtocol {

    /**
     Reads all entries inside the given plist.

     - parameters:
         - plistName: The name of the plist to read.

     - returns: Array of strings inside the plist.
     */
    func loadPlist(withName plistName: String) -> [String]

    /**
     Stores the given string to a plist located in the devices Documents folder.

     - parameters:
         - plistName: The name of the plist to write.
         - stringToAdd: The string that has to be added to that plist.
     */
    func addStringToPlist(withName plistName: String, value stringToAdd: String)
}
