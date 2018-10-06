/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Ewbf-equihash {
	public var hash : Int?
	public var per_alive_gpus : Int?
	public var per_total_gpus : Int?
	public var per_alive_rigs : Int?
	public var per_total_rigs : Int?
	public var per_hash-gpu : String?
	public var per_hash-rig : String?
	public var current_time : Int?

/**
    Returns an array of models based on given dictionary.
    
    Sample usage:
    let ewbf-equihash_list = Ewbf-equihash.modelsFromDictionaryArray(someDictionaryArrayFromJSON)

    - parameter array:  NSArray from JSON dictionary.

    - returns: Array of Ewbf-equihash Instances.
*/
    public class func modelsFromDictionaryArray(array:NSArray) -> [Ewbf-equihash]
    {
        var models:[Ewbf-equihash] = []
        for item in array
        {
            models.append(Ewbf-equihash(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let ewbf-equihash = Ewbf-equihash(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: Ewbf-equihash Instance.
*/
	required public init?(dictionary: NSDictionary) {

		hash = dictionary["hash"] as? Int
		per_alive_gpus = dictionary["per_alive_gpus"] as? Int
		per_total_gpus = dictionary["per_total_gpus"] as? Int
		per_alive_rigs = dictionary["per_alive_rigs"] as? Int
		per_total_rigs = dictionary["per_total_rigs"] as? Int
		per_hash-gpu = dictionary["per_hash-gpu"] as? String
		per_hash-rig = dictionary["per_hash-rig"] as? String
		current_time = dictionary["current_time"] as? Int
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.hash, forKey: "hash")
		dictionary.setValue(self.per_alive_gpus, forKey: "per_alive_gpus")
		dictionary.setValue(self.per_total_gpus, forKey: "per_total_gpus")
		dictionary.setValue(self.per_alive_rigs, forKey: "per_alive_rigs")
		dictionary.setValue(self.per_total_rigs, forKey: "per_total_rigs")
		dictionary.setValue(self.per_hash-gpu, forKey: "per_hash-gpu")
		dictionary.setValue(self.per_hash-rig, forKey: "per_hash-rig")
		dictionary.setValue(self.current_time, forKey: "current_time")

		return dictionary
	}

}