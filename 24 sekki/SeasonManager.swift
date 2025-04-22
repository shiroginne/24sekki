import Foundation

struct Season: Codable {
    let id: Int
    let nameKey: String
    let japanese: String
    let descriptionKey: String
    let startDate: String
    let endDate: String

    enum CodingKeys: String, CodingKey {
        case id
        case nameKey = "name_key"
        case japanese
        case descriptionKey = "description_key"
        case startDate = "start_date"
        case endDate = "end_date"
    }

    var localizedName: String {
        NSLocalizedString(nameKey, comment: "")
    }

    var localizedDescription: String {
        NSLocalizedString(descriptionKey, comment: "")
    }
}

class SeasonManager {
    var seasons: [Season] = []
    
    func loadSeasons() {
        guard let url = Bundle.main.url(forResource: "seasons", withExtension: "json") else { return }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            seasons = try decoder.decode([Season].self, from: data)
        } catch {
            print("Failed to load seasons: \(error)")
        }
    }
    
    func currentSeason() -> Season? {
        let currentDate = Date()
        let calendar = Calendar.current
        let currentMonthDay = calendar.dateComponents([.month, .day], from: currentDate)
        
        for season in seasons {
            if let startComponents = dateComponentsFromString(season.startDate),
               let endComponents = dateComponentsFromString(season.endDate) {
                if isDate(currentMonthDay, withinRangeOf: startComponents, endDate: endComponents) {
                    return season
                }
            }
        }
        
        return nil
    }
    
    private func dateComponentsFromString(_ dateString: String) -> DateComponents? {
        let components = dateString.split(separator: "-")
        if components.count == 2 {
            return DateComponents(month: Int(components[0]), day: Int(components[1]))
        }
        return nil
    }
    
    private func isDate(_ date: DateComponents, withinRangeOf startDate: DateComponents, endDate: DateComponents) -> Bool {
        guard let startMonth = startDate.month, let startDay = startDate.day,
              let endMonth = endDate.month, let endDay = endDate.day,
              let currentMonth = date.month, let currentDay = date.day else { return false }
        
        let startValue = startMonth * 100 + startDay
        let endValue = endMonth * 100 + endDay
        let currentValue = currentMonth * 100 + currentDay
        
        if startValue <= endValue {
            return (startValue...endValue).contains(currentValue)
        }
        else {
            return (startValue...1231).contains(currentValue) || (1...endValue).contains(currentValue)
        }
    }
}
