#import "PLAPIProxy.h"
#import "AFNetworking.h"
#import "PLJSONSerialization.h"

NSUInteger UTApiAccessorLogEntryMaximumSize = 512;
NSString *const UTApiAccessorResponseHeadersIdentifier = @"headers";
NSString *const UTApiAccessorResponseDataIdentifier = @"data";
NSString *const UTApiAccessorResponseStringDataIdentifier = @"string";

@implementation PLAPIProxy {
    NSUInteger _requestsCounter;
    NSOperationQueue *_opQueue;
}

- (id)init {
    self = [super init];
    if (self) {
        _opQueue = [[NSOperationQueue alloc] init];
        _opQueue.maxConcurrentOperationCount = 1;
        _requestsCounter = 0;

        _serverUrl = @"http://maciek-oczko.local.polidea.com:8080";

    }
    return self;
}

- (void)doNotUseThisHelperMethod {
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        NSMutableURLRequest *request = [self defaultRequestWithMethod:@"POST" endpoint:@"/hello"];
        [self performRequest:request error:nil];
    });
}

- (NSDictionary *)performRequest:(NSMutableURLRequest *)request error:(NSError **)error {
    NSUInteger currentRequestId = _requestsCounter++;

    NSString *bodyToLog = [[NSString alloc] initWithData:request.HTTPBody encoding:NSUTF8StringEncoding];

    NSLog(@"%u -> [%@] %@ + %@", currentRequestId, request.HTTPMethod, request.URL.absoluteString, bodyToLog);

    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [_opQueue addOperation:operation];
    [operation waitUntilFinished];

    id parsedResponseData = [PLJSONSerialization JSONObjectWithData:operation.responseData];

    NSLog(@"%u <- %@", currentRequestId, operation.responseData.length < UTApiAccessorLogEntryMaximumSize ? parsedResponseData : [NSString stringWithFormat:@"%@\nLog message too long (%u bytes)",
                                                                                                                                                            [operation.responseString substringToIndex:UTApiAccessorLogEntryMaximumSize],
                                                                                                                                                            operation.responseData.length]);

    if (operation.error != nil) {
        *error = operation.error;
        return nil;
    }

    NSMutableDictionary *returnDict = [NSMutableDictionary dictionary];

    BOOL responseDataExist = parsedResponseData != nil;
    if (responseDataExist) {
        returnDict[UTApiAccessorResponseDataIdentifier] = parsedResponseData;
    }

    BOOL responseHeaderExist = operation.response.allHeaderFields != nil;
    if (responseHeaderExist) {
        returnDict[UTApiAccessorResponseHeadersIdentifier] = operation.response.allHeaderFields;
    }

    BOOL responseStringDataExist = operation.responseString != nil;
    if (responseStringDataExist) {
        returnDict[UTApiAccessorResponseStringDataIdentifier] = operation.responseString;
    }

    return returnDict;
}


- (NSMutableURLRequest *)defaultRequestWithMethod:(NSString *)method endpoint:(NSString *)endpoint {
    return [self defaultRequestWithMethod:method endpoint:endpoint parameters:nil];
}

- (NSMutableURLRequest *)defaultRequestWithMethod:(NSString *)method endpoint:(NSString *)endpoint parameters:(NSDictionary *)parameters {
    if (parameters && ![parameters isKindOfClass:[NSArray class]] && ![parameters isKindOfClass:[NSDictionary class]]) {
        @throw [NSException exceptionWithName:@"UTApiAccessorBadParametersTypeException" reason:@"Parameters variable has wrong type." userInfo:nil];
    }

    if (!parameters) {
        parameters = @{};
    }

    NSMutableDictionary *emailParameters = [@{
            @"gravatar_email" : PL_EMAIL,
    } mutableCopy];
    [emailParameters addEntriesFromDictionary:parameters];
    parameters = emailParameters;

    NSString *absoluteURLString = [NSString stringWithFormat:@"%@%@", _serverUrl, endpoint];

    NSMutableURLRequest *request = nil;
    if (parameters) {
        AFHTTPRequestSerializer *serializer = [AFHTTPRequestSerializer serializer];
        serializer.stringEncoding = NSUTF8StringEncoding;
        request = [serializer requestWithMethod:method
                                      URLString:absoluteURLString
                                     parameters:parameters];
    } else {
        request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:absoluteURLString]];
        [request setHTTPMethod:method];
    }

    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];

    return request;
}

@end
