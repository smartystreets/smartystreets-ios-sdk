import Foundation

public struct PrincipalAttributes: Codable {
    let firstFloorSqft, secondFloorSqft, acres, airConditioner, arborPergola: String?
    let assessedImprovementPercent, assessedImprovementValue, assessedLandValue, assessedValue: String?
    let assessorLastUpdate, assessorTaxrollUpdate, atticArea, atticFlag: String?
    let balcony, balconyArea, basementSqft, basementSqftFinished: String?
    let basementSqftUnfinished, bathHouse, bathHouseSqft, bathroomsPartial: String?
    let bathroomsTotal, bedrooms, block1, block2: String?
    let boatAccess, boatHouse, boatHouseSqft, boatLift: String?
    let bonusRoom, breakfastNook, breezeway, buildingDefinitionCode: String?
    let buildingSqft, cabin, cabinSqft, canopy: String?
    let canopySqft, carport, carportSqft, cbsaCode: String?
    let cbsaName, cellar, censusBlock, censusBlockGroup: String?
    let censusFIPSPlaceCode, censusTract, centralVacuum, codeTitleCompany: String?
    let combinedStatisticalArea, communityRec, companyFlag, congressionalDistrict: String?
    let constructionType, contactCity, contactCrrt, contactFullAddress: String?
    let contactHouseNumber, contactMailInfoFormat, contactMailInfoPrivacy, contactMailingCounty: String?
    let contactMailingFIPS, contactPostDirection, contactPreDirection, contactState: String?
    let contactStreetName, contactSuffix, contactUnitDesignator, contactValue: String?
    let contactZip, contactZip4, courtyard, courtyardArea: String?
    let deck, deckArea, deedDocumentBook, deedDocumentNumber: String?
    let deedDocumentPage, deedOwnerFirstName, deedOwnerFirstName2, deedOwnerFirstName3: String?
    let deedOwnerFirstName4, deedOwnerFullName, deedOwnerFullName2, deedOwnerFullName3: String?
    let deedOwnerFullName4, deedOwnerLastName, deedOwnerLastName2, deedOwnerLastName3: String?
    let deedOwnerLastName4, deedOwnerMiddleName, deedOwnerMiddleName2, deedOwnerMiddleName3: String?
    let deedOwnerMiddleName4, deedOwnerSuffix, deedOwnerSuffix2, deedOwnerSuffix3: String?
    let deedOwnerSuffix4, deedSaleDate, deedSalePrice, deedTransactionID: String?
    let depthLinearFootage, disabledTaxExemption, documentTypeDescription, drivewaySqft: String?
    let drivewayType, effectiveYearBuilt, elevationFeet, elevator: String?
    let equestrianArena, escalator, exerciseRoom, exteriorWalls: String?
    let familyRoom, fence, fenceArea, fipsCode: String?
    let financialHistory: [PrincipalFinancialHistoryEntry]
    let fireResistanceCode, fireSprinklersFlag, fireplace, fireplaceNumber: String?
    let firstName, firstName2, firstName3, firstName4: String?
    let flooring, foundation, gameRoom, garage: String?
    let garageSqft, gazebo, gazeboSqft, golfCourse: String?
    let grainery, grainerySqft, greatRoom, greenhouse: String?
    let greenhouseSqft, grossSqft, guesthouse, guesthouseSqft: String?
    let handicapAccessibility, heat, heatFuelType, hobbyRoom: String?
    let homeownerTaxExemption, instrumentDate, intercomSystem, interestRateType2: String?
    let interiorStructure, kennel, kennelSqft, landUseCode: String?
    let landUseGroup, landUseStandard, lastName, lastName2: String?
    let lastName3, lastName4, latitude, laundry: String?
    let leanTo, leanToSqft, legalDescription, legalUnit: String?
    let lenderAddress, lenderAddress2, lenderCity, lenderCity2: String?
    let lenderCode2, lenderFirstName, lenderFirstName2, lenderLastName: String?
    let lenderLastName2, lenderName, lenderName2, lenderSellerCarryBack: String?
    let lenderSellerCarryBack2, lenderState, lenderState2, lenderZip: String?
    let lenderZip2, lenderZipExtended, lenderZipExtended2, loadingPlatform: String?
    let loadingPlatformSqft, longitude, lot1, lot2: String?
    let lot3, lotSqft, marketImprovementPercent, marketImprovementValue: String?
    let marketLandValue, marketValueYear, matchType, mediaRoom: String?
    let metroDivision, middleName, middleName2, middleName3: String?
    let middleName4, milkhouse, milkhouseSqft, minorCivilDivisionCode: String?
    let minorCivilDivisionName, mobileHomeHookup, mortgageAmount, mortgageAmount2: String?
    let mortgageDueDate, mortgageDueDate2, mortgageInterestRate, mortgageInterestRateType: String?
    let mortgageLenderCode, mortgageRate2, mortgageRecordingDate, mortgageRecordingDate2: String?
    let mortgageTerm, mortgageTerm2, mortgageTermType, mortgageTermType2: String?
    let mortgageType, mortgageType2, msaCode, msaName: String?
    let mudRoom, multiParcelFlag, nameTitleCompany, neighborhoodCode: String?
    let numberOfBuildings, office, officeSqft, otherTaxExemption: String?
    let outdoorKitchenFireplace, overheadDoor, ownerFullName, ownerFullName2: String?
    let ownerFullName3, ownerFullName4, ownerOccupancyStatus, ownershipTransferDate: String?
    let ownershipTransferDocNumber, ownershipTransferTransactionID, ownershipType, ownershipType2: String?
    let ownershipVestingRelationCode, parcelAccountNumber, parcelMapBook, parcelMapPage: String?
    let parcelNumberAlternate, parcelNumberFormatted, parcelNumberPrevious, parcelNumberYearAdded: String?
    let parcelNumberYearChange, parcelRawNumber, parcelShellRecord, parkingSpaces: String?
    let patioArea, phaseName, plumbingFixturesCount, poleStruct: String?
    let poleStructSqft, pond, pool, poolArea: String?
    let poolhouse, poolhouseSqft, porch, porchArea: String?
    let poultryHouse, poultryHouseSqft, previousAssessedValue, priorSaleAmount: String?
    let priorSaleDate, propertyAddressCarrierRouteCode, propertyAddressCity, propertyAddressFull: String?
    let propertyAddressHouseNumber, propertyAddressPostDirection, propertyAddressPreDirection, propertyAddressState: String?
    let propertyAddressStreetName, propertyAddressStreetSuffix, propertyAddressUnitDesignator, propertyAddressUnitValue: String?
    let propertyAddressZip4, propertyAddressZipcode, publicationDate, quarter: String?
    let quarterQuarter, quonset, quonsetSqft, range: String?
    let recordingDate, roofCover, roofFrame, rooms: String?
    let rvParking, safeRoom, saleAmount, saleDate: String?
    let sauna, section, securityAlarm, seniorTaxExemption: String?
    let sewerType, shed, shedSqft, silo: String?
    let siloSqft, sittingRoom, situsCounty, situsState: String?
    let soundSystem, sportsCourt, sprinklers, stable: String?
    let stableSqft, storageBuilding, storageBuildingSqft, storiesNumber: String?
    let stormShelter, stormShutter, structureStyle, study: String?
    let subdivision, suffix, suffix2, suffix3: String?
    let suffix4, sunroom, taxAssessYear, taxBilledAmount: String?
    let taxDelinquentYear, taxFiscalYear, taxJurisdiction, taxRateArea: String?
    let tennisCourt, topographyCode, totalMarketValue, township: String?
    let tractNumber, transferAmount, trustDescription, unitCount: String?
    let upperFloorsSqft, utility, utilityBuilding, utilityBuildingSqft: String?
    let utilitySqft, veteranTaxExemption, viewDescription, waterFeature: String?
    let waterServiceType, wetBar, widowTaxExemption, widthLinearFootage: String?
    let wineCellar, yearBuilt, zoning: String?

    enum CodingKeys: String, CodingKey {
        case firstFloorSqft = "1st_floor_sqft"
        case secondFloorSqft = "2nd_floor_sqft"
        case acres
        case airConditioner = "air_conditioner"
        case arborPergola = "arbor_pergola"
        case assessedImprovementPercent = "assessed_improvement_percent"
        case assessedImprovementValue = "assessed_improvement_value"
        case assessedLandValue = "assessed_land_value"
        case assessedValue = "assessed_value"
        case assessorLastUpdate = "assessor_last_update"
        case assessorTaxrollUpdate = "assessor_taxroll_update"
        case atticArea = "attic_area"
        case atticFlag = "attic_flag"
        case balcony
        case balconyArea = "balcony_area"
        case basementSqft = "basement_sqft"
        case basementSqftFinished = "basement_sqft_finished"
        case basementSqftUnfinished = "basement_sqft_unfinished"
        case bathHouse = "bath_house"
        case bathHouseSqft = "bath_house_sqft"
        case bathroomsPartial = "bathrooms_partial"
        case bathroomsTotal = "bathrooms_total"
        case bedrooms, block1, block2
        case boatAccess = "boat_access"
        case boatHouse = "boat_house"
        case boatHouseSqft = "boat_house_sqft"
        case boatLift = "boat_lift"
        case bonusRoom = "bonus_room"
        case breakfastNook = "breakfast_nook"
        case breezeway
        case buildingDefinitionCode = "building_definition_code"
        case buildingSqft = "building_sqft"
        case cabin
        case cabinSqft = "cabin_sqft"
        case canopy
        case canopySqft = "canopy_sqft"
        case carport
        case carportSqft = "carport_sqft"
        case cbsaCode = "cbsa_code"
        case cbsaName = "cbsa_name"
        case cellar
        case censusBlock = "census_block"
        case censusBlockGroup = "census_block_group"
        case censusFIPSPlaceCode = "census_fips_place_code"
        case censusTract = "census_tract"
        case centralVacuum = "central_vacuum"
        case codeTitleCompany = "code_title_company"
        case combinedStatisticalArea = "combined_statistical_area"
        case communityRec = "community_rec"
        case companyFlag = "company_flag"
        case congressionalDistrict = "congressional_district"
        case constructionType = "construction_type"
        case contactCity = "contact_city"
        case contactCrrt = "contact_crrt"
        case contactFullAddress = "contact_full_address"
        case contactHouseNumber = "contact_house_number"
        case contactMailInfoFormat = "contact_mail_info_format"
        case contactMailInfoPrivacy = "contact_mail_info_privacy"
        case contactMailingCounty = "contact_mailing_county"
        case contactMailingFIPS = "contact_mailing_fips"
        case contactPostDirection = "contact_post_direction"
        case contactPreDirection = "contact_pre_direction"
        case contactState = "contact_state"
        case contactStreetName = "contact_street_name"
        case contactSuffix = "contact_suffix"
        case contactUnitDesignator = "contact_unit_designator"
        case contactValue = "contact_value"
        case contactZip = "contact_zip"
        case contactZip4 = "contact_zip4"
        case courtyard
        case courtyardArea = "courtyard_area"
        case deck
        case deckArea = "deck_area"
        case deedDocumentBook = "deed_document_book"
        case deedDocumentNumber = "deed_document_number"
        case deedDocumentPage = "deed_document_page"
        case deedOwnerFirstName = "deed_owner_first_name"
        case deedOwnerFirstName2 = "deed_owner_first_name2"
        case deedOwnerFirstName3 = "deed_owner_first_name3"
        case deedOwnerFirstName4 = "deed_owner_first_name4"
        case deedOwnerFullName = "deed_owner_full_name"
        case deedOwnerFullName2 = "deed_owner_full_name2"
        case deedOwnerFullName3 = "deed_owner_full_name3"
        case deedOwnerFullName4 = "deed_owner_full_name4"
        case deedOwnerLastName = "deed_owner_last_name"
        case deedOwnerLastName2 = "deed_owner_last_name2"
        case deedOwnerLastName3 = "deed_owner_last_name3"
        case deedOwnerLastName4 = "deed_owner_last_name4"
        case deedOwnerMiddleName = "deed_owner_middle_name"
        case deedOwnerMiddleName2 = "deed_owner_middle_name2"
        case deedOwnerMiddleName3 = "deed_owner_middle_name3"
        case deedOwnerMiddleName4 = "deed_owner_middle_name4"
        case deedOwnerSuffix = "deed_owner_suffix"
        case deedOwnerSuffix2 = "deed_owner_suffix2"
        case deedOwnerSuffix3 = "deed_owner_suffix3"
        case deedOwnerSuffix4 = "deed_owner_suffix4"
        case deedSaleDate = "deed_sale_date"
        case deedSalePrice = "deed_sale_price"
        case deedTransactionID = "deed_transaction_id"
        case depthLinearFootage = "depth_linear_footage"
        case disabledTaxExemption = "disabled_tax_exemption"
        case documentTypeDescription = "document_type_description"
        case drivewaySqft = "driveway_sqft"
        case drivewayType = "driveway_type"
        case effectiveYearBuilt = "effective_year_built"
        case elevationFeet = "elevation_feet"
        case elevator
        case equestrianArena = "equestrian_arena"
        case escalator
        case exerciseRoom = "exercise_room"
        case exteriorWalls = "exterior_walls"
        case familyRoom = "family_room"
        case fence
        case fenceArea = "fence_area"
        case financialHistory = "financial_history"
        case fipsCode = "fips_code"
        case fireResistanceCode = "fire_resistance_code"
        case fireSprinklersFlag = "fire_sprinklers_flag"
        case fireplace
        case fireplaceNumber = "fireplace_number"
        case firstName = "first_name"
        case firstName2 = "first_name_2"
        case firstName3 = "first_name_3"
        case firstName4 = "first_name_4"
        case flooring, foundation
        case gameRoom = "game_room"
        case garage
        case garageSqft = "garage_sqft"
        case gazebo
        case gazeboSqft = "gazebo_sqft"
        case golfCourse = "golf_course"
        case grainery
        case grainerySqft = "grainery_sqft"
        case greatRoom = "great_room"
        case greenhouse
        case greenhouseSqft = "greenhouse_sqft"
        case grossSqft = "gross_sqft"
        case guesthouse
        case guesthouseSqft = "guesthouse_sqft"
        case handicapAccessibility = "handicap_accessibility"
        case heat
        case heatFuelType = "heat_fuel_type"
        case hobbyRoom = "hobby_room"
        case homeownerTaxExemption = "homeowner_tax_exemption"
        case instrumentDate = "instrument_date"
        case intercomSystem = "intercom_system"
        case interestRateType2 = "interest_rate_type_2"
        case interiorStructure = "interior_structure"
        case kennel
        case kennelSqft = "kennel_sqft"
        case landUseCode = "land_use_code"
        case landUseGroup = "land_use_group"
        case landUseStandard = "land_use_standard"
        case lastName = "last_name"
        case lastName2 = "last_name_2"
        case lastName3 = "last_name_3"
        case lastName4 = "last_name_4"
        case latitude, laundry
        case leanTo = "lean_to"
        case leanToSqft = "lean_to_sqft"
        case legalDescription = "legal_description"
        case legalUnit = "legal_unit"
        case lenderAddress = "lender_address"
        case lenderAddress2 = "lender_address_2"
        case lenderCity = "lender_city"
        case lenderCity2 = "lender_city_2"
        case lenderCode2 = "lender_code_2"
        case lenderFirstName = "lender_first_name"
        case lenderFirstName2 = "lender_first_name_2"
        case lenderLastName = "lender_last_name"
        case lenderLastName2 = "lender_last_name_2"
        case lenderName = "lender_name"
        case lenderName2 = "lender_name_2"
        case lenderSellerCarryBack = "lender_seller_carry_back"
        case lenderSellerCarryBack2 = "lender_seller_carry_back_2"
        case lenderState = "lender_state"
        case lenderState2 = "lender_state_2"
        case lenderZip = "lender_zip"
        case lenderZip2 = "lender_zip_2"
        case lenderZipExtended = "lender_zip_extended"
        case lenderZipExtended2 = "lender_zip_extended_2"
        case loadingPlatform = "loading_platform"
        case loadingPlatformSqft = "loading_platform_sqft"
        case longitude
        case lot1 = "lot_1"
        case lot2 = "lot_2"
        case lot3 = "lot_3"
        case lotSqft = "lot_sqft"
        case marketImprovementPercent = "market_improvement_percent"
        case marketImprovementValue = "market_improvement_value"
        case marketLandValue = "market_land_value"
        case marketValueYear = "market_value_year"
        case matchType = "match_type"
        case mediaRoom = "media_room"
        case metroDivision = "metro_division"
        case middleName = "middle_name"
        case middleName2 = "middle_name_2"
        case middleName3 = "middle_name_3"
        case middleName4 = "middle_name_4"
        case milkhouse
        case milkhouseSqft = "milkhouse_sqft"
        case minorCivilDivisionCode = "minor_civil_division_code"
        case minorCivilDivisionName = "minor_civil_division_name"
        case mobileHomeHookup = "mobile_home_hookup"
        case mortgageAmount = "mortgage_amount"
        case mortgageAmount2 = "mortgage_amount_2"
        case mortgageDueDate = "mortgage_due_date"
        case mortgageDueDate2 = "mortgage_due_date_2"
        case mortgageInterestRate = "mortgage_interest_rate"
        case mortgageInterestRateType = "mortgage_interest_rate_type"
        case mortgageLenderCode = "mortgage_lender_code"
        case mortgageRate2 = "mortgage_rate_2"
        case mortgageRecordingDate = "mortgage_recording_date"
        case mortgageRecordingDate2 = "mortgage_recording_date_2"
        case mortgageTerm = "mortgage_term"
        case mortgageTerm2 = "mortgage_term_2"
        case mortgageTermType = "mortgage_term_type"
        case mortgageTermType2 = "mortgage_term_type_2"
        case mortgageType = "mortgage_type"
        case mortgageType2 = "mortgage_type_2"
        case msaCode = "msa_code"
        case msaName = "msa_name"
        case mudRoom = "mud_room"
        case multiParcelFlag = "multi_parcel_flag"
        case nameTitleCompany = "name_title_company"
        case neighborhoodCode = "neighborhood_code"
        case numberOfBuildings = "number_of_buildings"
        case office
        case officeSqft = "office_sqft"
        case otherTaxExemption = "other_tax_exemption"
        case outdoorKitchenFireplace = "outdoor_kitchen_fireplace"
        case overheadDoor = "overhead_door"
        case ownerFullName = "owner_full_name"
        case ownerFullName2 = "owner_full_name_2"
        case ownerFullName3 = "owner_full_name_3"
        case ownerFullName4 = "owner_full_name_4"
        case ownerOccupancyStatus = "owner_occupancy_status"
        case ownershipTransferDate = "ownership_transfer_date"
        case ownershipTransferDocNumber = "ownership_transfer_doc_number"
        case ownershipTransferTransactionID = "ownership_transfer_transaction_id"
        case ownershipType = "ownership_type"
        case ownershipType2 = "ownership_type_2"
        case ownershipVestingRelationCode = "ownership_vesting_relation_code"
        case parcelAccountNumber = "parcel_account_number"
        case parcelMapBook = "parcel_map_book"
        case parcelMapPage = "parcel_map_page"
        case parcelNumberAlternate = "parcel_number_alternate"
        case parcelNumberFormatted = "parcel_number_formatted"
        case parcelNumberPrevious = "parcel_number_previous"
        case parcelNumberYearAdded = "parcel_number_year_added"
        case parcelNumberYearChange = "parcel_number_year_change"
        case parcelRawNumber = "parcel_raw_number"
        case parcelShellRecord = "parcel_shell_record"
        case parkingSpaces = "parking_spaces"
        case patioArea = "patio_area"
        case phaseName = "phase_name"
        case plumbingFixturesCount = "plumbing_fixtures_count"
        case poleStruct = "pole_struct"
        case poleStructSqft = "pole_struct_sqft"
        case pond, pool
        case poolArea = "pool_area"
        case poolhouse
        case poolhouseSqft = "poolhouse_sqft"
        case porch
        case porchArea = "porch_area"
        case poultryHouse = "poultry_house"
        case poultryHouseSqft = "poultry_house_sqft"
        case previousAssessedValue = "previous_assessed_value"
        case priorSaleAmount = "prior_sale_amount"
        case priorSaleDate = "prior_sale_date"
        case propertyAddressCarrierRouteCode = "property_address_carrier_route_code"
        case propertyAddressCity = "property_address_city"
        case propertyAddressFull = "property_address_full"
        case propertyAddressHouseNumber = "property_address_house_number"
        case propertyAddressPostDirection = "property_address_post_direction"
        case propertyAddressPreDirection = "property_address_pre_direction"
        case propertyAddressState = "property_address_state"
        case propertyAddressStreetName = "property_address_street_name"
        case propertyAddressStreetSuffix = "property_address_street_suffix"
        case propertyAddressUnitDesignator = "property_address_unit_designator"
        case propertyAddressUnitValue = "property_address_unit_value"
        case propertyAddressZip4 = "property_address_zip_4"
        case propertyAddressZipcode = "property_address_zipcode"
        case publicationDate = "publication_date"
        case quarter
        case quarterQuarter = "quarter_quarter"
        case quonset
        case quonsetSqft = "quonset_sqft"
        case range
        case recordingDate = "recording_date"
        case roofCover = "roof_cover"
        case roofFrame = "roof_frame"
        case rooms
        case rvParking = "rv_parking"
        case safeRoom = "safe_room"
        case saleAmount = "sale_amount"
        case saleDate = "sale_date"
        case sauna, section
        case securityAlarm = "security_alarm"
        case seniorTaxExemption = "senior_tax_exemption"
        case sewerType = "sewer_type"
        case shed
        case shedSqft = "shed_sqft"
        case silo
        case siloSqft = "silo_sqft"
        case sittingRoom = "sitting_room"
        case situsCounty = "situs_county"
        case situsState = "situs_state"
        case soundSystem = "sound_system"
        case sportsCourt = "sports_court"
        case sprinklers, stable
        case stableSqft = "stable_sqft"
        case storageBuilding = "storage_building"
        case storageBuildingSqft = "storage_building_sqft"
        case storiesNumber = "stories_number"
        case stormShelter = "storm_shelter"
        case stormShutter = "storm_shutter"
        case structureStyle = "structure_style"
        case study, subdivision, suffix
        case suffix2 = "suffix_2"
        case suffix3 = "suffix_3"
        case suffix4 = "suffix_4"
        case sunroom
        case taxAssessYear = "tax_assess_year"
        case taxBilledAmount = "tax_billed_amount"
        case taxDelinquentYear = "tax_delinquent_year"
        case taxFiscalYear = "tax_fiscal_year"
        case taxJurisdiction = "tax_jurisdiction"
        case taxRateArea = "tax_rate_area"
        case tennisCourt = "tennis_court"
        case topographyCode = "topography_code"
        case totalMarketValue = "total_market_value"
        case township
        case tractNumber = "tract_number"
        case transferAmount = "transfer_amount"
        case trustDescription = "trust_description"
        case unitCount = "unit_count"
        case upperFloorsSqft = "upper_floors_sqft"
        case utility
        case utilityBuilding = "utility_building"
        case utilityBuildingSqft = "utility_building_sqft"
        case utilitySqft = "utility_sqft"
        case veteranTaxExemption = "veteran_tax_exemption"
        case viewDescription = "view_description"
        case waterFeature = "water_feature"
        case waterServiceType = "water_service_type"
        case wetBar = "wet_bar"
        case widowTaxExemption = "widow_tax_exemption"
        case widthLinearFootage = "width_linear_footage"
        case wineCellar = "wine_cellar"
        case yearBuilt = "year_built"
        case zoning
    }
}
