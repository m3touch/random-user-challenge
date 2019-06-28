//
//  PlistEditor.swift
//  RandomUserChallenge
//
//  Created by Marta Tarragó on 28/06/2019.
//  Copyright © 2019 mtarrago. All rights reserved.
//

import Foundation

struct PlistEditor: PlistEditorProtocol {

    func loadPlist(named plistName: String) -> [String] {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let readPath = "\(documentsDirectory)/\(plistName).plist"

        guard
            let xml = FileManager.default.contents(atPath: readPath)
        else {
            return []
        }

        return (try? PropertyListSerialization.propertyList(from: xml, options: .mutableContainersAndLeaves, format: nil)) as? [String] ?? []
    }

    func addStringToPlist(named plistName: String, value stringToAdd: String) {
        let documentsDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        let writePath = "\(documentsDirectory)/\(plistName).plist"

        var allPlistStrings = loadPlist(named: plistName)
        allPlistStrings.append(stringToAdd)

        let data = NSArray(array: allPlistStrings)
        data.write(toFile: writePath, atomically: false)
    }
}
