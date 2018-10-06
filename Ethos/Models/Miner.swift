/* 
Copyright (c) 2018 Swift Models Generated from JSON powered by http://www.json4swift.com

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import Foundation
 
/* For support, please feel free to contact me at https://www.linkedin.com/in/syedabsar */

public class Miner {
	public var condition : String?
	public var version : String?
	public var driver : String?
	public var miner : String?
	public var gpus : String?
	public var miner_instance : String?
	public var miner_hashes : String?
	public var bioses : String?
	public var meminfo : String?
	public var vramsize : String?
	public var drive_name : String?
	public var mobo : String?
	public var biosversion : String?
	public var lan_chip : String?
	public var connected_displays : String?
	public var ram : String?
	public var flags : String?
	public var rack_loc : String?
	public var pdu_name : String?
	public var pdu_port : String?
	public var pdu_ip : String?
	public var ext_temp1 : String?
	public var ext_temp2 : String?
	public var ext_temp3 : String?
	public var ext_temp4 : String?
	public var ext_temp5 : String?
	public var ext_temp6 : String?
	public var ext_temp7 : String?
	public var ext_temp8 : String?
	public var ext_temp9 : String?
	public var ext_temp10 : String?
	public var ip : String?
	public var server_time : Int?
	public var uptime : String?
	public var miner_secs : Int?
	public var rx_kbps : String?
	public var tx_kbps : String?
	public var possible_intrusion : String?
	public var load : String?
	public var cpu_temp : String?
	public var freespace : Double?
	public var hash : Int?
	public var pool : String?
	public var temp : String?
	public var powertune : String?
	public var voltage : String?
	public var watts : String?
	public var fanrpm : String?
	public var core : String?
	public var mem : String?

    public class func modelsFromDictionaryArray(array:NSArray) -> [Miner]
    {
        var models:[Miner] = []
        for item in array
        {
            models.append(Miner(dictionary: item as! NSDictionary)!)
        }
        return models
    }

/**
    Constructs the object based on the given dictionary.
    
    Sample usage:
    let a976d1 = A976d1(someDictionaryFromJSON)

    - parameter dictionary:  NSDictionary from JSON.

    - returns: A976d1 Instance.
*/
	required public init?(dictionary: NSDictionary) {

		condition = dictionary["condition"] as? String
		version = dictionary["version"] as? String
		driver = dictionary["driver"] as? String
		miner = dictionary["miner"] as? String
		gpus = dictionary["gpus"] as? String
		miner_instance = dictionary["miner_instance"] as? String
		miner_hashes = dictionary["miner_hashes"] as? String
		bioses = dictionary["bioses"] as? String
		meminfo = dictionary["meminfo"] as? String
		vramsize = dictionary["vramsize"] as? String
		drive_name = dictionary["drive_name"] as? String
		mobo = dictionary["mobo"] as? String
		biosversion = dictionary["biosversion"] as? String
		lan_chip = dictionary["lan_chip"] as? String
		connected_displays = dictionary["connected_displays"] as? String
		ram = dictionary["ram"] as? String
		flags = dictionary["flags"] as? String
		rack_loc = dictionary["rack_loc"] as? String
		pdu_name = dictionary["pdu_name"] as? String
		pdu_port = dictionary["pdu_port"] as? String
		pdu_ip = dictionary["pdu_ip"] as? String
		ext_temp1 = dictionary["ext_temp1"] as? String
		ext_temp2 = dictionary["ext_temp2"] as? String
		ext_temp3 = dictionary["ext_temp3"] as? String
		ext_temp4 = dictionary["ext_temp4"] as? String
		ext_temp5 = dictionary["ext_temp5"] as? String
		ext_temp6 = dictionary["ext_temp6"] as? String
		ext_temp7 = dictionary["ext_temp7"] as? String
		ext_temp8 = dictionary["ext_temp8"] as? String
		ext_temp9 = dictionary["ext_temp9"] as? String
		ext_temp10 = dictionary["ext_temp10"] as? String
		ip = dictionary["ip"] as? String
		server_time = dictionary["server_time"] as? Int
		uptime = dictionary["uptime"] as? String
		miner_secs = dictionary["miner_secs"] as? Int
		rx_kbps = dictionary["rx_kbps"] as? String
		tx_kbps = dictionary["tx_kbps"] as? String
		possible_intrusion = dictionary["possible_intrusion"] as? String
		load = dictionary["load"] as? String
		cpu_temp = dictionary["cpu_temp"] as? String
		freespace = dictionary["freespace"] as? Double
		hash = dictionary["hash"] as? Int
		pool = dictionary["pool"] as? String
		temp = dictionary["temp"] as? String
		powertune = dictionary["powertune"] as? String
		voltage = dictionary["voltage"] as? String
		watts = dictionary["watts"] as? String
		fanrpm = dictionary["fanrpm"] as? String
		core = dictionary["core"] as? String
		mem = dictionary["mem"] as? String
	}

		
/**
    Returns the dictionary representation for the current instance.
    
    - returns: NSDictionary.
*/
	public func dictionaryRepresentation() -> NSDictionary {

		let dictionary = NSMutableDictionary()

		dictionary.setValue(self.condition, forKey: "condition")
		dictionary.setValue(self.version, forKey: "version")
		dictionary.setValue(self.driver, forKey: "driver")
		dictionary.setValue(self.miner, forKey: "miner")
		dictionary.setValue(self.gpus, forKey: "gpus")
		dictionary.setValue(self.miner_instance, forKey: "miner_instance")
		dictionary.setValue(self.miner_hashes, forKey: "miner_hashes")
		dictionary.setValue(self.bioses, forKey: "bioses")
		dictionary.setValue(self.meminfo, forKey: "meminfo")
		dictionary.setValue(self.vramsize, forKey: "vramsize")
		dictionary.setValue(self.drive_name, forKey: "drive_name")
		dictionary.setValue(self.mobo, forKey: "mobo")
		dictionary.setValue(self.biosversion, forKey: "biosversion")
		dictionary.setValue(self.lan_chip, forKey: "lan_chip")
		dictionary.setValue(self.connected_displays, forKey: "connected_displays")
		dictionary.setValue(self.ram, forKey: "ram")
		dictionary.setValue(self.flags, forKey: "flags")
		dictionary.setValue(self.rack_loc, forKey: "rack_loc")
		dictionary.setValue(self.pdu_name, forKey: "pdu_name")
		dictionary.setValue(self.pdu_port, forKey: "pdu_port")
		dictionary.setValue(self.pdu_ip, forKey: "pdu_ip")
		dictionary.setValue(self.ext_temp1, forKey: "ext_temp1")
		dictionary.setValue(self.ext_temp2, forKey: "ext_temp2")
		dictionary.setValue(self.ext_temp3, forKey: "ext_temp3")
		dictionary.setValue(self.ext_temp4, forKey: "ext_temp4")
		dictionary.setValue(self.ext_temp5, forKey: "ext_temp5")
		dictionary.setValue(self.ext_temp6, forKey: "ext_temp6")
		dictionary.setValue(self.ext_temp7, forKey: "ext_temp7")
		dictionary.setValue(self.ext_temp8, forKey: "ext_temp8")
		dictionary.setValue(self.ext_temp9, forKey: "ext_temp9")
		dictionary.setValue(self.ext_temp10, forKey: "ext_temp10")
		dictionary.setValue(self.ip, forKey: "ip")
		dictionary.setValue(self.server_time, forKey: "server_time")
		dictionary.setValue(self.uptime, forKey: "uptime")
		dictionary.setValue(self.miner_secs, forKey: "miner_secs")
		dictionary.setValue(self.rx_kbps, forKey: "rx_kbps")
		dictionary.setValue(self.tx_kbps, forKey: "tx_kbps")
		dictionary.setValue(self.possible_intrusion, forKey: "possible_intrusion")
		dictionary.setValue(self.load, forKey: "load")
		dictionary.setValue(self.cpu_temp, forKey: "cpu_temp")
		dictionary.setValue(self.freespace, forKey: "freespace")
		dictionary.setValue(self.hash, forKey: "hash")
		dictionary.setValue(self.pool, forKey: "pool")
		dictionary.setValue(self.temp, forKey: "temp")
		dictionary.setValue(self.powertune, forKey: "powertune")
		dictionary.setValue(self.voltage, forKey: "voltage")
		dictionary.setValue(self.watts, forKey: "watts")
		dictionary.setValue(self.fanrpm, forKey: "fanrpm")
		dictionary.setValue(self.core, forKey: "core")
		dictionary.setValue(self.mem, forKey: "mem")

		return dictionary
	}

}
