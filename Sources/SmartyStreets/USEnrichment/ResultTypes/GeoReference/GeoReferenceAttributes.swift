import Foundation

public struct GeoReferenceAttributes: Codable {
    let censusBlock: CensusBlockEntry?
    let censusCountyDivision: CensusCountyDivisionEntry?
    let censusTract: CensusTractEntry?
    let coreBasedStatArea: CoreBasedStatAreaEntry?
    let place: PlaceEntry?
    
    enum CodingKeys: String, CodingKey {
        case censusBlock = "census_block"
        case censusCountyDivision = "census_county_division"
        case censusTract = "census_tract"
        case coreBasedStatArea = "core_based_stat_area"
        case place = "place"
    }
}
