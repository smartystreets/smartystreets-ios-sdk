import Foundation

public struct PrincipalFinancialHistoryEntry: Codable {
    let codeTitleCompany, documentTypeDescription, instrumentDate, interestRateType2: String?
    let lenderAddress, lenderAddress2, lenderCity, lenderCity2: String?
    let lenderCode2, lenderFirstName, lenderFirstName2, lenderLastName: String?
    let lenderLastName2, lenderName, lenderName2, lenderSellerCarryBack: String?
    let lenderSellerCarryBack2, lenderState, lenderState2, lenderZip: String?
    let lenderZip2, lenderZipExtended, lenderZipExtended2, mortgageAmount: String?
    let mortgageAmount2, mortgageDueDate, mortgageDueDate2, mortgageInterestRate: String?
    let mortgageInterestRateType, mortgageLenderCode, mortgageRate2, mortgageRecordingDate: String?
    let mortgageRecordingDate2, mortgageTerm, mortgageTerm2, mortgageTermType: String?
    let mortgageTermType2, mortgageType, mortgageType2, multiParcelFlag: String?
    let nameTitleCompany, recordingDate, transferAmount: String?

    enum CodingKeys: String, CodingKey {
        case codeTitleCompany = "code_title_company"
        case documentTypeDescription = "document_type_description"
        case instrumentDate = "instrument_date"
        case interestRateType2 = "interest_rate_type_2"
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
        case multiParcelFlag = "multi_parcel_flag"
        case nameTitleCompany = "name_title_company"
        case recordingDate = "recording_date"
        case transferAmount = "transfer_amount"
    }
}
