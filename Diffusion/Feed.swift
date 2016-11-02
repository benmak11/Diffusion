//
//  Feed.swift
//  Diffusion
//
//  Created by Baynham Makusha on 11/2/16.
//  Copyright © 2016 Ben Makusha. All rights reserved.
//

import Foundation
import Firebase

class Feed {
    private var _feedDescription: String!
    private var _subjectPost: String!
    private var _likes: Int!
    private var _postKey: String!
    private var _postRef: FIRDatabaseReference!
    
    var feedDescription: String {
        return _feedDescription
    }
    
    var subjectPost: String {
        return _subjectPost
    }
    
    var likes: Int {
        return _likes
    }
    
    var postKey: String {
        return _postKey
    }
    
    init(feedDescription: String, subjectPost: String, likes: Int) {
        self._feedDescription = feedDescription
        self._subjectPost = subjectPost
        self._likes = likes
    }
    
    init(postKey: String, postData: Dictionary<String, Any>) {
        self._postKey = postKey
        
        if let feedDescription = postData["postDescription"] as? String {
            self._feedDescription = feedDescription
        }
        
        if let subjectPost = postData["subjects"] as? String {
            self._subjectPost = subjectPost
        }
        
        if let likes = postData["likes"] as? Int {
            self._likes = likes
        }
        
        _postRef = DataService.ds.REF_FEED.child(_postKey)
    }
    
    func adjustLikes(addLike: Bool) {
        if addLike {
            _likes = _likes + 1
        } else {
            _likes = _likes - 1
        }
        
        _postRef.child("likes").setValue(_likes)
    }
}
