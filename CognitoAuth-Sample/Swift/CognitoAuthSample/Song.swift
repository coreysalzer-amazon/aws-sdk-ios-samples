//
//  Song.swift
//  CognitoAuthSample
//
//  Created by Salzer, Corey on 1/3/18.
//  Copyright © 2018 Behroozi, David. All rights reserved.
//

import Foundation

class Song {
    public var artist:String!
    public var name:String!

    init(json: NSDictionary) {
        self.artist = json.object(forKey: "Artist") as? String
        self.name = json.object(forKey: "Name") as? String
    }
}

