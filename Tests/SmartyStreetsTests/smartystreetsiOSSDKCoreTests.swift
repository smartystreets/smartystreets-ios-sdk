import XCTest
@testable import SmartyStreets

final class sdkTests: XCTestCase {
    
    static var allTests = [
        ("test200Response", StatusCodeSenderTests.test200Response),
        ("test400ResponseThrowsBadRequestError", StatusCodeSenderTests.test400ResponseThrowsBadRequestError),
        ("test401ResponseThrowsBadCredentialsError", StatusCodeSenderTests.test401ResponseThrowsBadCredentialsError),
        ("test402ResponseThrowsPaymentRequiredError", StatusCodeSenderTests.test402ResponseThrowsPaymentRequiredError),
        ("test413ResponseThrowsRequeestEntityTooLargeError", StatusCodeSenderTests.test413ResponseThrowsRequeestEntityTooLargeError),
        ("test422ResponseThrowsUnprocessableEntityError", StatusCodeSenderTests.test422ResponseThrowsUnprocessableEntityError),
        ("test429ResponseThrowsTooManyRequestsError", StatusCodeSenderTests.test429ResponseThrowsTooManyRequestsError),
        ("test500ResponseThrowsInternalServerError", StatusCodeSenderTests.test500ResponseThrowsInternalServerError),
        ("test503ResponseThrowsServiceUnavailableError", StatusCodeSenderTests.test503ResponseThrowsServiceUnavailableError),
        ("test504ResponseThrowsGatewayTimeoutException", StatusCodeSenderTests.test504ResponseThrowsGatewayTimeoutException),
        ("testInitSmartyResponse", SmartyResponseTests.testInit),
        ("testSigningOfRequest", SigningSenderTests.testSigningOfRequest),
        ("testSigningSendRequest", SigningSenderTests.testSigningSendRequest),
        ("testCustomizeInitHttpSender", SmartySenderTests.testCustomizeInitHttpSender),
        ("testBuildHttpRequestFuncOnHTTP", SmartySenderTests.testBuildHttpRequestFuncOnHTTP),
        ("testCopyHeadersFuncOnHTTP", SmartySenderTests.testCopyHeadersFuncOnHTTP),
        ("testSuccessDoesNotRetry", RetrySenderTests.testSuccessDoesNotRetry),
        ("testRetryUntilSuccess", RetrySenderTests.testRetryUntilSuccess),
        ("testRetryUntilMaxAttempts", RetrySenderTests.testRetryUntilMaxAttempts),
        ("testBackoffDoesNotExceedMax", RetrySenderTests.testBackoffDoesNotExceedMax),
        ("testStaticCredentialsPopulated", SmartyCredentialsTests.testStaticCredentialsPopulated),
        ("testStaticSignerFunction", SmartyCredentialsTests.testStaticSignerFunction),
        ("testSharedCredentialsPopulated", SmartyCredentialsTests.testSharedCredentialsPopulated),
        ("testSharedSignerFunction", SmartyCredentialsTests.testSharedSignerFunction),
        ("testBasicInit", ClientBuilderTests.testBasicInit),
        ("testInitWithSigner", ClientBuilderTests.testInitWithSigner),
        ("testInitWithAuthIdAndAuthToken", ClientBuilderTests.testInitWithAuthIdAndAuthToken),
        ("testRetryAtMost", ClientBuilderTests.testRetryAtMost),
        ("testWithMaxTimeout", ClientBuilderTests.testWithMaxTimeout),
        ("testWithSender", ClientBuilderTests.testWithSender),
        ("testWithSerializer", ClientBuilderTests.testWithSerializer),
        ("testWithUrl", ClientBuilderTests.testWithUrl),
        ("testWithProxy", ClientBuilderTests.testWithProxy),
        ("testWithDebug", ClientBuilderTests.testWithDebug),
        ("testBuildSender", ClientBuilderTests.testBuildSender),
        ("testInitializeSmartyRequest", SmartyRequestTests.testInitialize),
        ("testSetHeaderFieldValue", SmartyRequestTests.testSetHeaderFieldValue),
        ("testSetParameterFieldValue", SmartyRequestTests.testSetParameterFieldValue),
        ("testGetURL", SmartyRequestTests.testGetURL),
        ("testSerialize", SerializerTests.testSerialize),
        ("testDeserializeResult", SerializerTests.testDeserializeResult),
        ("testSendingFreeformLookup", InternationalStreetClientTests.testSendingFreeformLookup),
        ("testSendingSingleFullyPopulatedLookup", InternationalStreetClientTests.testSendingSingleFullyPopulatedLookup),
        ("testAllFieldsFilledCorrectly", InternationalCandidateTests.testAllFieldsFilledCorrectly),
        ("testSendingBodyOnlyLookup", USExtractClientTests.testSendingBodyOnlyLookup),
        ("testAllFieldsFilledCorrectly", USExtractResultTests.testAllFieldsFilledCorrectly),
        ("testSerializationOfUSStreetCandidates", USStreetCandidateTests.testSerialization),
        ("testAllFieldsFilledCorrectlyUSStreetCandidates", USStreetCandidateTests.testAllFieldsFilledCorrectly),
        ("testSendingSingleFreeformLookup", USStreetClientTests.testSendingSingleFreeformLookup),
        ("testSendingSingleFullyPopulatedLookup", USStreetClientTests.testSendingSingleFullyPopulatedLookup),
        ("testEmptyBatchNotSent", USStreetClientTests.testEmptyBatchNotSent),
        ("testSendingSingleZipOnlyLookup", USZipCodeClientTests.testSendingSingleZipOnlyLookup),
        ("testIsValidReturnsTrueWhenInputIsValid", USZipCodeResultTests.testIsValidReturnsTrueWhenInputIsValid),
        ("testsIsValidReturnsTrueWhenInputIsNotValid", USZipCodeResultTests.testsIsValidReturnsTrueWhenInputIsNotValid),
        ("testAllFieldsFilledCorrectly", USZipCodeResultTests.testAllFieldsFilledCorrectly),
        ("testWhenZipCodesAndCitiesAreNullCreatesNewNSMutableArray", USZipCodeResultTests.testWhenZipCodesAndCitiesAreNullCreatesNewNSMutableArray),
        ("testWhenAlternatecountiesIsNullCreatesNewNSMutableArray", USZipCodeResultTests.testWhenAlternatecountiesIsNullCreatesNewNSMutableArray),
        ("testGetsLookupsByInputId", USZipCodeBatchTests.testGetsLookupsByInputId),
        ("testGetLookupByIndex", USZipCodeBatchTests.testGetLookupByIndex),
        ("testReturnsCorrectSize", USZipCodeBatchTests.testReturnsCorrectSize),
        ("testAddingALookupWhenThereIsABatchIsFullError", USZipCodeBatchTests.testAddingALookupWhenThereIsABatchIsFullError),
        ("testClearMethodClearsBothLookupCollections", USZipCodeBatchTests.testClearMethodClearsBothLookupCollections),
        ] as [Any]
}
