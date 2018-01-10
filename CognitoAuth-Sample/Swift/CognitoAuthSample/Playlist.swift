//
//  Playlist.swift
//  CognitoAuthSample
//
//  Created by Salzer, Corey on 1/3/18.
//  Copyright © 2018 Behroozi, David. All rights reserved.
//

import Foundation

class Playlist {
    public var id:Int!
    public var name:String!
    public var songs:[Song]!
    
    init(json: NSDictionary) {
        self.id = Int(json["ID"] as! String)
        self.name = json.object(forKey: "Name") as? String
        self.songs = []
        for case let songJson as NSDictionary in json.object(forKey: "Songs") as! NSArray {
            self.songs.append(Song(json: songJson))
        }
    }

}
