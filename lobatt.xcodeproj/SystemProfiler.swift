// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let welcome = try? newJSONDecoder().decode(Welcome.self, from: jsonData)

import Foundation

struct SystemProfiler: Codable {
  static func CurrentProfile() -> SystemProfiler {
    let task = Process()
    task.launchPath = "/usr/sbin/system_profiler"
    task.arguments = ["-json", "SPPowerDataType"]
    
    let pipe = Pipe()
    task.standardOutput = pipe
    task.launch()
    
    let data = pipe.fileHandleForReading.readDataToEndOfFile()
    let profiler = try! JSONDecoder().decode(Self.self, from: data)
    return profiler
  }
  
  let power: [Power]
  
  enum CodingKeys: String, CodingKey {
    case power = "SPPowerDataType"
  }
  
  struct Power: Codable {
    let chargeInfo: Battery.ChargeInfo?
    
    enum CodingKeys: String, CodingKey {
      case chargeInfo = "sppower_battery_charge_info"
    }
    
    enum Battery {
      struct ChargeInfo: Codable {
        let percent: Int
        
        enum CodingKeys: String, CodingKey {
          case percent = "sppower_battery_state_of_charge"
        }
      }
    }
  }
}


