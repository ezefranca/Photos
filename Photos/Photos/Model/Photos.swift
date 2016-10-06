//
//  Photos.swift
//
//  Created by Ezequiel on 10/5/16
//  Copyright (c) Ezequiel França. All rights reserved.
//

import Foundation
import SwiftyJSON
import ObjectMapper

public class Photos: Mappable {
    
    // MARK: Declaration for string constants to be used to decode and also serialize.
    internal let kPhotosTitleKey: String = "title"
    internal let kPhotosUrlKey: String = "url"
    internal let kPhotosInternalIdentifierKey: String = "id"
    internal let kPhotosThumbnailUrlKey: String = "thumbnailUrl"
    internal let kPhotosAlbumIdKey: String = "albumId"
    
    
    // MARK: Properties
    public var title: String?
    public var url: String?
    public var internalIdentifier: Int?
    public var thumbnailUrl: String?
    public var albumId: Int?
    
    
    // MARK: SwiftyJSON Initalizers
    /**
     Initates the class based on the object
     - parameter object: The object of either Dictionary or Array kind that was passed.
     - returns: An initalized instance of the class.
     */
    init(){
        
    }
    
    convenience public init(object: AnyObject) {
        self.init(json: JSON(object))
    }
    
    /**
     Initates the class based on the JSON that was passed.
     - parameter json: JSON object from SwiftyJSON.
     - returns: An initalized instance of the class.
     */
    public init(json: JSON) {
        title = json[kPhotosTitleKey].string
        url = json[kPhotosUrlKey].string
        internalIdentifier = json[kPhotosInternalIdentifierKey].int
        thumbnailUrl = json[kPhotosThumbnailUrlKey].string
        albumId = json[kPhotosAlbumIdKey].int
        
    }
    
    // MARK: ObjectMapper Initalizers
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    required public init?(_ map: Map){
        
    }
    
    /**
     Map a JSON object to this class using ObjectMapper
     - parameter map: A mapping from ObjectMapper
     */
    public func mapping(map: Map) {
        title <- map[kPhotosTitleKey]
        url <- map[kPhotosUrlKey]
        internalIdentifier <- map[kPhotosInternalIdentifierKey]
        thumbnailUrl <- map[kPhotosThumbnailUrlKey]
        albumId <- map[kPhotosAlbumIdKey]
        
    }
    
    /**
     Generates description of the object in the form of a NSDictionary.
     - returns: A Key value pair containing all valid values in the object.
     */
    public func dictionaryRepresentation() -> [String : AnyObject ] {
        
        var dictionary: [String : AnyObject ] = [ : ]
        if title != nil {
            dictionary.updateValue(title!, forKey: kPhotosTitleKey)
        }
        if url != nil {
            dictionary.updateValue(url!, forKey: kPhotosUrlKey)
        }
        if internalIdentifier != nil {
            dictionary.updateValue(internalIdentifier!, forKey: kPhotosInternalIdentifierKey)
        }
        if thumbnailUrl != nil {
            dictionary.updateValue(thumbnailUrl!, forKey: kPhotosThumbnailUrlKey)
        }
        if albumId != nil {
            dictionary.updateValue(albumId!, forKey: kPhotosAlbumIdKey)
        }
        
        return dictionary
    }
    
}
