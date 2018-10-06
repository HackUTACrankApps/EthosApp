/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Ethos {
	public var rigs : Rigs?
	public var total_hash : Double?
	public var total_watts : Int?
	public var alive_gpus : Int?
	public var total_gpus : Int?
	public var alive_rigs : Int?
	public var total_rigs : Int?
	public var current_version : String?
	public var avg_temp : Double?
	public var capacity : String?
	public var per_info : Per_info?
	public var licenses : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Json4Swift_Base Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Ethos]
    {
        var models:[Ethos] = []
        for item in array
        {
            models.append(Ethos(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Json4Swift_Base Instance.
*/
	required public init?(dictionary: NSDictionary) {
		if (dictionary["rigs"] != nil) { rigs = Rigs(dictionary: dictionary["rigs"] as! NSDictionary) }
		total_hash = dictionary["total_hash"] as? Double
		total_watts = dictionary["total_watts"] as? Int
		alive_gpus = dictionary["alive_gpus"] as? Int
		total_gpus = dictionary["total_gpus"] as? Int
		alive_rigs = dictionary["alive_rigs"] as? Int
		total_rigs = dictionary["total_rigs"] as? Int
		current_version = dictionary["current_version"] as? String
		avg_temp = dictionary["avg_temp"] as? Double
		capacity = dictionary["capacity"] as? String
		if (dictionary["per_info"] != nil) { per_info = Per_info(dictionary: dictionary["per_info"] as! NSDictionary) }
		licenses = dictionary["licenses"] as? Int
    }
}
