#import <Foundation/Foundation.h>

#define REPLACE_IT_WITH_GRAVATAR_EMAIL_ADDRESS ^id(){ @throw [NSException exceptionWithName:@"PLNoEmailAddressSetException" reason:@"Go to PLAPIAProxy.h and set gravatar email address." userInfo:nil]; }()

#define PL_EMAIL REPLACE_IT_WITH_GRAVATAR_EMAIL_ADDRESS // => @"my-gravatar-email@email.xxx"


extern NSString *const UTApiAccessorResponseHeadersIdentifier;
extern NSString *const UTApiAccessorResponseDataIdentifier;
extern NSString *const UTApiAccessorResponseStringDataIdentifier;

@interface PLAPIProxy : NSObject

@property(nonatomic, readonly) NSString *serverUrl;

- (void)doNotUseThisHelperMethod;
/**
* Synchronously performs a request.
 */
- (NSDictionary *)performRequest:(NSMutableURLRequest *)request error:(NSError **)error;
/**
* Returns default request with parameters.
*/
- (NSMutableURLRequest *)defaultRequestWithMethod:(NSString *)method endpoint:(NSString *)endpoint;
- (NSMutableURLRequest *)defaultRequestWithMethod:(NSString *)method endpoint:(NSString *)endpoint parameters:(NSDictionary *)parameters;
@end
