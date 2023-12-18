import XCTest
@testable import SmartyStreets

class USEnrichmentFinancialResultTest: XCTestCase {
    
    var expectedJsonInput:String!
    var obj:NSDictionary!
    var sobj:String!
    var error:NSError!
    let serializer = PropertyFinancialSerializer()
    
    override func setUp() {
        super.setUp()
        expectedJsonInput = """
        {"data_set_name":"property","data_subset_name":"financial","smarty_key":"xxx"}
        """
        
        sobj = """
            [{"smarty_key":"xxx","data_set_name":"property","data_subset_name":"financial","attributes":{"assessed_improvement_percent":"Assessed_Improvement_Percent","assessed_improvement_value":"Assessed_Improvement_Value","assessed_land_value":"Assessed_Land_Value","assessed_value":"Assessed_Value","assessor_last_update":"Assessor_Last_Update","assessor_taxroll_update":"Assessor_Taxroll_Update","contact_city":"Contact_City","contact_crrt":"Contact_Crrt","contact_full_address":"Contact_Full_Address","contact_house_number":"Contact_House_Number","contact_mail_info_format":"Contact_Mail_Info_Format","contact_mail_info_privacy":"Contact_Mail_Info_Privacy","contact_mailing_county":"Contact_Mailing_County","contact_mailing_fips":"Contact_Mailing_Fips","contact_post_direction":"Contact_Post_Direction","contact_pre_direction":"Contact_PRE_Direction","contact_state":"Contact_State","contact_street_name":"Contact_Street_Name","contact_suffix":"Contact_Suffix","contact_unit_designator":"Contact_Unit_Designator","contact_value":"Contact_Value","contact_zip":"Contact_Zip","contact_zip4":"Contact_Zip4","deed_document_book":"Deed_Document_Book","deed_document_number":"Deed_Document_Number","deed_document_page":"Deed_Document_Page","deed_owner_first_name":"Deed_Owner_First_Name","deed_owner_first_name2":"Deed_Owner_First_Name2","deed_owner_first_name3":"Deed_Owner_First_Name3","deed_owner_first_name4":"Deed_Owner_First_Name4","deed_owner_full_name":"Deed_Owner_Full_Name","deed_owner_full_name2":"Deed_Owner_Full_Name2","deed_owner_full_name3":"Deed_Owner_Full_Name3","deed_owner_full_name4":"Deed_Owner_Full_Name4","deed_owner_last_name":"Deed_Owner_Last_Name","deed_owner_last_name2":"Deed_Owner_Last_Name2","deed_owner_last_name3":"Deed_Owner_Last_Name3","deed_owner_last_name4":"Deed_Owner_Last_Name4","deed_owner_middle_name":"Deed_Owner_Middle_Name","deed_owner_middle_name2":"Deed_Owner_Middle_Name2","deed_owner_middle_name3":"Deed_Owner_Middle_Name3","deed_owner_middle_name4":"Deed_Owner_Middle_Name4","deed_owner_suffix":"Deed_Owner_Suffix","deed_owner_suffix2":"Deed_Owner_Suffix2","deed_owner_suffix3":"Deed_Owner_Suffix3","deed_owner_suffix4":"Deed_Owner_Suffix4","deed_sale_date":"Deed_Sale_Date","deed_sale_price":"Deed_Sale_Price","deed_transaction_id":"Deed_Transaction_ID","disabled_tax_exemption":"Disabled_Tax_Exemption","financial_history":[{"code_title_company":"Code_Title_Company","document_type_description":"Document_Type_Description","instrument_date":"Instrument_Date","interest_rate_type_2":"Interest_Rate_Type_2","lender_address":"Lender_Address","lender_address_2":"Lender_Address_2","lender_city":"Lender_City","lender_city_2":"Lender_City_2","lender_code_2":"Lender_Code_2","lender_first_name":"Lender_First_Name","lender_first_name_2":"Lender_First_Name_2","lender_last_name":"Lender_Last_Name","lender_last_name_2":"Lender_Last_Name_2","lender_name":"Lender_Name","lender_name_2":"Lender_Name_2","lender_seller_carry_back":"Lender_Seller_Carry_Back","lender_seller_carry_back_2":"Lender_Seller_Carry_Back_2","lender_state":"Lender_State","lender_state_2":"Lender_State_2","lender_zip":"Lender_Zip","lender_zip_2":"Lender_Zip_2","lender_zip_extended":"Lender_Zip_Extended","lender_zip_extended_2":"Lender_Zip_Extended_2","mortgage_amount":"Mortgage_Amount","mortgage_amount_2":"Mortgage_Amount_2","mortgage_due_date":"Mortgage_Due_Date","mortgage_due_date_2":"Mortgage_Due_Date_2","mortgage_interest_rate":"Mortgage_Interest_Rate","mortgage_interest_rate_type":"Mortgage_Interest_Rate_Type","mortgage_lender_code":"Mortgage_Lender_Code","mortgage_rate_2":"Mortgage_Rate_2","mortgage_recording_date":"Mortgage_Recording_Date","mortgage_recording_date_2":"Mortgage_Recording_Date_2","mortgage_term":"Mortgage_Term","mortgage_term_2":"Mortgage_Term_2","mortgage_term_type":"Mortgage_Term_Type","mortgage_term_type_2":"Mortgage_Term_Type_2","mortgage_type":"Mortgage_Type","mortgage_type_2":"Mortgage_Type_2","multi_parcel_flag":"Multi_Parcel_Flag","name_title_company":"Name_Title_Company","recording_date":"Recording_Date","transfer_amount":"Transfer_Amount"}],"first_name":"First_Name","first_name_2":"First_Name_2","first_name_3":"First_Name_3","first_name_4":"First_Name_4","homeowner_tax_exemption":"Homeowner_Tax_Exemption","last_name":"Last_Name","last_name_2":"Last_Name_2","last_name_3":"Last_Name_3","last_name_4":"Last_Name_4","market_improvement_percent":"Market_Improvement_Percent","market_improvement_value":"Market_Improvement_Value","market_land_value":"Market_Land_Value","market_value_year":"Market_Value_Year","match_type":"match_type","middle_name":"Middle_Name","middle_name_2":"Middle_Name_2","middle_name_3":"Middle_Name_3","middle_name_4":"Middle_Name_4","other_tax_exemption":"Other_Tax_Exemption","owner_full_name":"Owner_Full_Name","owner_full_name_2":"Owner_Full_Name_2","owner_full_name_3":"Owner_Full_Name_3","owner_full_name_4":"Owner_Full_Name_4","ownership_transfer_date":"Ownership_Transfer_Date","ownership_transfer_doc_number":"Ownership_Transfer_DOC_Number","ownership_transfer_transaction_id":"Ownership_Transfer_Transaction_ID","ownership_type":"Ownership_Type","ownership_type_2":"Ownership_Type_2","previous_assessed_value":"Previous_Assessed_Value","prior_sale_amount":"Prior_Sale_Amount","prior_sale_date":"Prior_Sale_Date","sale_amount":"Sale_Amount","sale_date":"Sale_Date","senior_tax_exemption":"Senior_Tax_Exemption","suffix":"Suffix","suffix_2":"Suffix_2","suffix_3":"Suffix_3","suffix_4":"Suffix_4","tax_assess_year":"Tax_Assess_Year","tax_billed_amount":"Tax_Billed_Amount","tax_delinquent_year":"Tax_Delinquent_Year","tax_fiscal_year":"Tax_Fiscal_Year","tax_rate_area":"Tax_Rate_Area","total_market_value":"Total_Market_Value","trust_description":"Trust_Description","veteran_tax_exemption":"Veteran_Tax_Exemption","widow_tax_exemption":"Widow_Tax_Exemption"}}]
        """
        self.error = nil
    }
    
    override func tearDown() {
        super.tearDown()
        self.error = nil
    }
    
    func testSerialization() {
        let lookup = PropertyFinancialEnrichmentLookup(smartyKey: "xxx")
        let actualBytes = serializer.Serialize(obj: lookup, error: &self.error)
        
        let data = Data(base64Encoded: (actualBytes?.base64EncodedString())!)
        let string = String(data: data!, encoding: .utf8)
        XCTAssertNil(self.error)
        XCTAssertEqual(string, expectedJsonInput)
    }
    
    func testAllFieldsFilledCorrectly() throws {
        let data = sobj.data(using: .utf8)
        // Convert the JSON string to a JSON object
        let jsonObject = try JSONSerialization.jsonObject(with: data!, options: []) as? [[String: Any]]
        // Convert the JSON object to JSON data
        let jsonData = try JSONSerialization.data(withJSONObject: jsonObject!, options: .prettyPrinted)
       
       // Deserialize the JSON data
        let results = serializer.Deserialize(payload: jsonData, error: &self.error) as? [FinancialResult]
        print(results!)
        let result = results![0]
        
        XCTAssertEqual("xxx", result.smartyKey)

        let _ = result.attributes
        
    }
}
