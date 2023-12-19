import Foundation

public struct FinancialAttributes: Codable {
    let assessedImprovementPercent, assessedImprovementValue, assessedLandValue, assessedValue: String?
    let assessorLastUpdate, assessorTaxrollUpdate, contactCity, contactCrrt: String?
    let contactFullAddress, contactHouseNumber, contactMailInfoFormat, contactMailInfoPrivacy: String?
    let contactMailingCounty, contactMailingFIPS, contactPostDirection, contactPreDirection: String?
    let contactState, contactStreetName, contactSuffix, contactUnitDesignator: String?
    let contactValue, contactZip, contactZip4, deedDocumentBook: String?
    let deedDocumentNumber, deedDocumentPage, deedOwnerFirstName, deedOwnerFirstName2: String?
    let deedOwnerFirstName3, deedOwnerFirstName4, deedOwnerFullName, deedOwnerFullName2: String?
    let deedOwnerFullName3, deedOwnerFullName4, deedOwnerLastName, deedOwnerLastName2: String?
    let deedOwnerLastName3, deedOwnerLastName4, deedOwnerMiddleName, deedOwnerMiddleName2: String?
    let deedOwnerMiddleName3, deedOwnerMiddleName4, deedOwnerSuffix, deedOwnerSuffix2: String?
    let deedOwnerSuffix3, deedOwnerSuffix4, deedSaleDate, deedSalePrice: String?
    let deedTransactionID, disabledTaxExemption: String?
    let financialHistory: [FinancialHistoryEntry]
    let firstName, firstName2, firstName3, firstName4: String?
    let homeownerTaxExemption, lastName, lastName2, lastName3: String?
    let lastName4, marketImprovementPercent, marketImprovementValue, marketLandValue: String?
    let marketValueYear, matchType, middleName, middleName2: String?
    let middleName3, middleName4, otherTaxExemption, ownerFullName: String?
    let ownerFullName2, ownerFullName3, ownerFullName4, ownershipTransferDate: String?
    let ownershipTransferDocNumber, ownershipTransferTransactionID, ownershipType, ownershipType2: String?
    let previousAssessedValue, priorSaleAmount, priorSaleDate, saleAmount: String?
    let saleDate, seniorTaxExemption, suffix, suffix2: String?
    let suffix3, suffix4, taxAssessYear, taxBilledAmount: String?
    let taxDelinquentYear, taxFiscalYear, taxRateArea, totalMarketValue: String?
    let trustDescription, veteranTaxExemption, widowTaxExemption: String?

    enum CodingKeys: String, CodingKey {
        case assessedImprovementPercent = "assessed_improvement_percent"
        case assessedImprovementValue = "assessed_improvement_value"
        case assessedLandValue = "assessed_land_value"
        case assessedValue = "assessed_value"
        case assessorLastUpdate = "assessor_last_update"
        case assessorTaxrollUpdate = "assessor_taxroll_update"
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
        case disabledTaxExemption = "disabled_tax_exemption"
        case financialHistory = "financial_history"
        case firstName = "first_name"
        case firstName2 = "first_name_2"
        case firstName3 = "first_name_3"
        case firstName4 = "first_name_4"
        case homeownerTaxExemption = "homeowner_tax_exemption"
        case lastName = "last_name"
        case lastName2 = "last_name_2"
        case lastName3 = "last_name_3"
        case lastName4 = "last_name_4"
        case marketImprovementPercent = "market_improvement_percent"
        case marketImprovementValue = "market_improvement_value"
        case marketLandValue = "market_land_value"
        case marketValueYear = "market_value_year"
        case matchType = "match_type"
        case middleName = "middle_name"
        case middleName2 = "middle_name_2"
        case middleName3 = "middle_name_3"
        case middleName4 = "middle_name_4"
        case otherTaxExemption = "other_tax_exemption"
        case ownerFullName = "owner_full_name"
        case ownerFullName2 = "owner_full_name_2"
        case ownerFullName3 = "owner_full_name_3"
        case ownerFullName4 = "owner_full_name_4"
        case ownershipTransferDate = "ownership_transfer_date"
        case ownershipTransferDocNumber = "ownership_transfer_doc_number"
        case ownershipTransferTransactionID = "ownership_transfer_transaction_id"
        case ownershipType = "ownership_type"
        case ownershipType2 = "ownership_type_2"
        case previousAssessedValue = "previous_assessed_value"
        case priorSaleAmount = "prior_sale_amount"
        case priorSaleDate = "prior_sale_date"
        case saleAmount = "sale_amount"
        case saleDate = "sale_date"
        case seniorTaxExemption = "senior_tax_exemption"
        case suffix
        case suffix2 = "suffix_2"
        case suffix3 = "suffix_3"
        case suffix4 = "suffix_4"
        case taxAssessYear = "tax_assess_year"
        case taxBilledAmount = "tax_billed_amount"
        case taxDelinquentYear = "tax_delinquent_year"
        case taxFiscalYear = "tax_fiscal_year"
        case taxRateArea = "tax_rate_area"
        case totalMarketValue = "total_market_value"
        case trustDescription = "trust_description"
        case veteranTaxExemption = "veteran_tax_exemption"
        case widowTaxExemption = "widow_tax_exemption"
    }
}
