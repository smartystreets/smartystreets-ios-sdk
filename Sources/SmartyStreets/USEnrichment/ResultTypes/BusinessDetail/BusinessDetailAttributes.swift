import Foundation

public struct BusinessDetailAttributes: Codable {
    public let accountingExpenseRange, accountingExpenseTotal, advertisingExpenseRange, advertisingExpenseTotal: String?
    public let businessInsuranceExpenseRange, businessInsuranceExpenseTotal, businessStatus, businessType: String?
    public let carrierRoute, censusBlock, censusTract, cityName: String?
    public let companyName, companyNameSecondary, contactFirstName, contactFullName: String?
    public let contactGender, contactLastName, contactMiddleName, contactPrefix: String?
    public let contactProfessionalTitle, contactSuffix, coreBasedStatAreaCode, coreBasedStatAreaName: String?
    public let corporateEmployeeCountRange, corporateEmployeeCountTotal, countyFips, countyName: String?
    public let creditCapacity, creditCapacityRange, creditScore, creditScoreDescription: String?
    public let dateOfLastUpdate, deliveryLine1, deliveryPoint, deliveryPointCheckDigit: String?
    public let domesticForeignOwnerIndicator, ein, email, emailAvailableIndicator: String?
    public let executiveDepartment, executiveLevel, executiveVerificationType, fax: String?
    public let femaleOwnedIndicator, foreignParentCityName, foreignParentCompanyName, foreignParentCountry: String?
    public let fortune1000Branches, fortune1000Indicator, fortune1000Rank, holdingCityName: String?
    public let holdingCompanyName, holdingId, holdingStateAbbreviation, homeBasedBusinessIndicator: String?
    public let hqCityName, hqCompanyName, hqId, hqNumberOfCompanies: String?
    public let hqStateAbbreviation, latitude, legalExpenseRange, legalExpenseTotal: String?
    public let linkageCompanyName, linkageIndicator, linkageLevel, linkageType: String?
    public let locationEmployeeCount, locationEmployeeCountRange, locationSalesRange, locationSalesTotal: String?
    public let longitude, mailScoreCode, mailScoreDescription, mailingCarrierRoute: String?
    public let mailingCityName, mailingDeliveryLine1, mailingDeliveryPoint, mailingDeliveryPointCheckDigit: String?
    public let mailingPlus4Code, mailingStateAbbreviation, mailingZipcode, manufacturingIndicator: String?
    public let minorityOwnedIndicator, minorityType, naics01Code, naics01Description: String?
    public let naics02Code, naics02Description, naics03Code, naics03Description: String?
    public let naics04Code, naics04Description, naics05Code, naics05Description: String?
    public let naics06Code, naics06Description, newBusinessIndicator, nonProfitIndicator: String?
    public let numOfPcsRange, numOfPcsTotal, numberOfYearsInBusiness, numberOfYearsInBusinessRange: String?
    public let officeEquipmentExpenseRange, officeEquipmentExpenseTotal, operatingHoursFriday, operatingHoursMonday: String?
    public let operatingHoursSaturday, operatingHoursSunday, operatingHoursThursday, operatingHoursTuesday: String?
    public let operatingHoursWednesday, phone, phoneAreaCode, phoneSecondary: String?
    public let phoneTollFree, plus4Code, populationRange, precision: String?
    public let primaryExecutiveIndicator, primaryNumber, primarySic2digitCode, primarySic2digitDescription: String?
    public let primarySic4digitCode, primarySic4digitDescription, primarySicCode, primarySicDescription: String?
    public let publicIndicator, rdi, rentExpenseRange, rentExpenseTotal: String?
    public let secondary01Sic7digitCode, secondary01Sic7digitDescription, secondary02Sic7digitCode, secondary02Sic7digitDescription: String?
    public let secondary03Sic7digitCode, secondary03Sic7digitDescription, secondary04Sic7digitCode, secondary04Sic7digitDescription: String?
    public let secondary05Sic7digitCode, secondary05Sic7digitDescription, secondaryDesignator, secondaryNumber: String?
    public let sectionalCenterFacility, smallBusinessIndicator, sourceTitle, squareFootage: String?
    public let squareFootageRange, standardizedTitle, standardizedTitleRank, stateAbbreviation: String?
    public let stockExchange, streetName, streetPostdirection, streetPredirection: String?
    public let streetSuffix, subHqCityName, subHqCompanyName, subHqId: String?
    public let subHqNumberOfCompanies, subHqStateAbbreviation, technologyExpenseRange, technologyExpenseTotal: String?
    public let telecomExpenseRange, telecomExpenseTotal, tickerSymbol, timeZone: String?
    public let url, urlFacebook, urlInstagram, urlLinkedin: String?
    public let urlTwitter, urlYelp, urlYoutube, utilitiesExpenseRange: String?
    public let utilitiesExpenseTotal, webmailIndicator, yearCurrent, yearCurrentEmployeeCount: String?
    public let yearEstablished, yearFourPrior, yearFourPriorEmployeeCount, yearFourPriorEmployeeGrowth: String?
    public let yearOnePrior, yearOnePriorEmployeeCount, yearOnePriorEmployeeGrowth, yearThreePrior: String?
    public let yearThreePriorEmployeeCount, yearThreePriorEmployeeGrowth, yearTwoPrior, yearTwoPriorEmployeeCount: String?
    public let yearTwoPriorEmployeeGrowth, zipcode: String?

    enum CodingKeys: String, CodingKey {
        case accountingExpenseRange = "accounting_expense_range"
        case accountingExpenseTotal = "accounting_expense_total"
        case advertisingExpenseRange = "advertising_expense_range"
        case advertisingExpenseTotal = "advertising_expense_total"
        case businessInsuranceExpenseRange = "business_insurance_expense_range"
        case businessInsuranceExpenseTotal = "business_insurance_expense_total"
        case businessStatus = "business_status"
        case businessType = "business_type"
        case carrierRoute = "carrier_route"
        case censusBlock = "census_block"
        case censusTract = "census_tract"
        case cityName = "city_name"
        case companyName = "company_name"
        case companyNameSecondary = "company_name_secondary"
        case contactFirstName = "contact_first_name"
        case contactFullName = "contact_full_name"
        case contactGender = "contact_gender"
        case contactLastName = "contact_last_name"
        case contactMiddleName = "contact_middle_name"
        case contactPrefix = "contact_prefix"
        case contactProfessionalTitle = "contact_professional_title"
        case contactSuffix = "contact_suffix"
        case coreBasedStatAreaCode = "core_based_stat_area_code"
        case coreBasedStatAreaName = "core_based_stat_area_name"
        case corporateEmployeeCountRange = "corporate_employee_count_range"
        case corporateEmployeeCountTotal = "corporate_employee_count_total"
        case countyFips = "county_fips"
        case countyName = "county_name"
        case creditCapacity = "credit_capacity"
        case creditCapacityRange = "credit_capacity_range"
        case creditScore = "credit_score"
        case creditScoreDescription = "credit_score_description"
        case dateOfLastUpdate = "date_of_last_update"
        case deliveryLine1 = "delivery_line_1"
        case deliveryPoint = "delivery_point"
        case deliveryPointCheckDigit = "delivery_point_check_digit"
        case domesticForeignOwnerIndicator = "domestic_foreign_owner_indicator"
        case ein = "ein"
        case email = "email"
        case emailAvailableIndicator = "email_available_indicator"
        case executiveDepartment = "executive_department"
        case executiveLevel = "executive_level"
        case executiveVerificationType = "executive_verification_type"
        case fax = "fax"
        case femaleOwnedIndicator = "female_owned_indicator"
        case foreignParentCityName = "foreign_parent_city_name"
        case foreignParentCompanyName = "foreign_parent_company_name"
        case foreignParentCountry = "foreign_parent_country"
        case fortune1000Branches = "fortune_1000_branches"
        case fortune1000Indicator = "fortune_1000_indicator"
        case fortune1000Rank = "fortune_1000_rank"
        case holdingCityName = "holding_city_name"
        case holdingCompanyName = "holding_company_name"
        case holdingId = "holding_id"
        case holdingStateAbbreviation = "holding_state_abbreviation"
        case homeBasedBusinessIndicator = "home_based_business_indicator"
        case hqCityName = "hq_city_name"
        case hqCompanyName = "hq_company_name"
        case hqId = "hq_id"
        case hqNumberOfCompanies = "hq_number_of_companies"
        case hqStateAbbreviation = "hq_state_abbreviation"
        case latitude = "latitude"
        case legalExpenseRange = "legal_expense_range"
        case legalExpenseTotal = "legal_expense_total"
        case linkageCompanyName = "linkage_company_name"
        case linkageIndicator = "linkage_indicator"
        case linkageLevel = "linkage_level"
        case linkageType = "linkage_type"
        case locationEmployeeCount = "location_employee_count"
        case locationEmployeeCountRange = "location_employee_count_range"
        case locationSalesRange = "location_sales_range"
        case locationSalesTotal = "location_sales_total"
        case longitude = "longitude"
        case mailScoreCode = "mail_score_code"
        case mailScoreDescription = "mail_score_description"
        case mailingCarrierRoute = "mailing_carrier_route"
        case mailingCityName = "mailing_city_name"
        case mailingDeliveryLine1 = "mailing_delivery_line_1"
        case mailingDeliveryPoint = "mailing_delivery_point"
        case mailingDeliveryPointCheckDigit = "mailing_delivery_point_check_digit"
        case mailingPlus4Code = "mailing_plus4_code"
        case mailingStateAbbreviation = "mailing_state_abbreviation"
        case mailingZipcode = "mailing_zipcode"
        case manufacturingIndicator = "manufacturing_indicator"
        case minorityOwnedIndicator = "minority_owned_indicator"
        case minorityType = "minority_type"
        case naics01Code = "naics_01_code"
        case naics01Description = "naics_01_description"
        case naics02Code = "naics_02_code"
        case naics02Description = "naics_02_description"
        case naics03Code = "naics_03_code"
        case naics03Description = "naics_03_description"
        case naics04Code = "naics_04_code"
        case naics04Description = "naics_04_description"
        case naics05Code = "naics_05_code"
        case naics05Description = "naics_05_description"
        case naics06Code = "naics_06_code"
        case naics06Description = "naics_06_description"
        case newBusinessIndicator = "new_business_indicator"
        case nonProfitIndicator = "non_profit_indicator"
        case numOfPcsRange = "num_of_pcs_range"
        case numOfPcsTotal = "num_of_pcs_total"
        case numberOfYearsInBusiness = "number_of_years_in_business"
        case numberOfYearsInBusinessRange = "number_of_years_in_business_range"
        case officeEquipmentExpenseRange = "office_equipment_expense_range"
        case officeEquipmentExpenseTotal = "office_equipment_expense_total"
        case operatingHoursFriday = "operating_hours_friday"
        case operatingHoursMonday = "operating_hours_monday"
        case operatingHoursSaturday = "operating_hours_saturday"
        case operatingHoursSunday = "operating_hours_sunday"
        case operatingHoursThursday = "operating_hours_thursday"
        case operatingHoursTuesday = "operating_hours_tuesday"
        case operatingHoursWednesday = "operating_hours_wednesday"
        case phone = "phone"
        case phoneAreaCode = "phone_area_code"
        case phoneSecondary = "phone_secondary"
        case phoneTollFree = "phone_toll_free"
        case plus4Code = "plus4_code"
        case populationRange = "population_range"
        case precision = "precision"
        case primaryExecutiveIndicator = "primary_executive_indicator"
        case primaryNumber = "primary_number"
        case primarySic2digitCode = "primary_sic_2digit_code"
        case primarySic2digitDescription = "primary_sic_2digit_description"
        case primarySic4digitCode = "primary_sic_4digit_code"
        case primarySic4digitDescription = "primary_sic_4digit_description"
        case primarySicCode = "primary_sic_code"
        case primarySicDescription = "primary_sic_description"
        case publicIndicator = "public_indicator"
        case rdi = "rdi"
        case rentExpenseRange = "rent_expense_range"
        case rentExpenseTotal = "rent_expense_total"
        case secondary01Sic7digitCode = "secondary_01_sic_7digit_code"
        case secondary01Sic7digitDescription = "secondary_01_sic_7digit_description"
        case secondary02Sic7digitCode = "secondary_02_sic_7digit_code"
        case secondary02Sic7digitDescription = "secondary_02_sic_7digit_description"
        case secondary03Sic7digitCode = "secondary_03_sic_7digit_code"
        case secondary03Sic7digitDescription = "secondary_03_sic_7digit_description"
        case secondary04Sic7digitCode = "secondary_04_sic_7digit_code"
        case secondary04Sic7digitDescription = "secondary_04_sic_7digit_description"
        case secondary05Sic7digitCode = "secondary_05_sic_7digit_code"
        case secondary05Sic7digitDescription = "secondary_05_sic_7digit_description"
        case secondaryDesignator = "secondary_designator"
        case secondaryNumber = "secondary_number"
        case sectionalCenterFacility = "sectional_center_facility"
        case smallBusinessIndicator = "small_business_indicator"
        case sourceTitle = "source_title"
        case squareFootage = "square_footage"
        case squareFootageRange = "square_footage_range"
        case standardizedTitle = "standardized_title"
        case standardizedTitleRank = "standardized_title_rank"
        case stateAbbreviation = "state_abbreviation"
        case stockExchange = "stock_exchange"
        case streetName = "street_name"
        case streetPostdirection = "street_postdirection"
        case streetPredirection = "street_predirection"
        case streetSuffix = "street_suffix"
        case subHqCityName = "sub_hq_city_name"
        case subHqCompanyName = "sub_hq_company_name"
        case subHqId = "sub_hq_id"
        case subHqNumberOfCompanies = "sub_hq_number_of_companies"
        case subHqStateAbbreviation = "sub_hq_state_abbreviation"
        case technologyExpenseRange = "technology_expense_range"
        case technologyExpenseTotal = "technology_expense_total"
        case telecomExpenseRange = "telecom_expense_range"
        case telecomExpenseTotal = "telecom_expense_total"
        case tickerSymbol = "ticker_symbol"
        case timeZone = "time_zone"
        case url = "url"
        case urlFacebook = "url_facebook"
        case urlInstagram = "url_instagram"
        case urlLinkedin = "url_linkedin"
        case urlTwitter = "url_twitter"
        case urlYelp = "url_yelp"
        case urlYoutube = "url_youtube"
        case utilitiesExpenseRange = "utilities_expense_range"
        case utilitiesExpenseTotal = "utilities_expense_total"
        case webmailIndicator = "webmail_indicator"
        case yearCurrent = "year_current"
        case yearCurrentEmployeeCount = "year_current_employee_count"
        case yearEstablished = "year_established"
        case yearFourPrior = "year_four_prior"
        case yearFourPriorEmployeeCount = "year_four_prior_employee_count"
        case yearFourPriorEmployeeGrowth = "year_four_prior_employee_growth"
        case yearOnePrior = "year_one_prior"
        case yearOnePriorEmployeeCount = "year_one_prior_employee_count"
        case yearOnePriorEmployeeGrowth = "year_one_prior_employee_growth"
        case yearThreePrior = "year_three_prior"
        case yearThreePriorEmployeeCount = "year_three_prior_employee_count"
        case yearThreePriorEmployeeGrowth = "year_three_prior_employee_growth"
        case yearTwoPrior = "year_two_prior"
        case yearTwoPriorEmployeeCount = "year_two_prior_employee_count"
        case yearTwoPriorEmployeeGrowth = "year_two_prior_employee_growth"
        case zipcode = "zipcode"
    }
}
