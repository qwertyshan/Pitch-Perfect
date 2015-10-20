//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Shantanu Rao on 9/22/15.
//  Copyright (c) 2015 Shantanu Rao. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL, title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}