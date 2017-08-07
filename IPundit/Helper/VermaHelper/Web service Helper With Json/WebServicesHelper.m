


#import "WebServicesHelper.h"
#import "AppDelegate.h"
#import "Constants.h"
#import "DataManager.h"
#import "Helper.h"
#define kServiceURL @"http://swiftpush.com/aws/sendmail.php"

@implementation WebServicesHelper

-(void)sendServerRequest:(NSDictionary *)dct andAPI:(NSString *)api andMethod:(NSString *)GET_POST_Method{
    
    if (DM.mInternetStatus == false) {
        NSLog(@"No Internet Connection.");
        
        return;
    }
    
    [Helper showLoaderVProgressHUD];
    
    NSString *requestStr = [NSString stringWithFormat:@"%@%@",kServiceURL, api];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:requestStr]];
    NSError *error;
    [request setHTTPMethod:GET_POST_Method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    // Convert Request &=
    NSString *mPoststr = [NSString new];

    if ([GET_POST_Method isEqualToString:kGET]) {
        mPoststr =@"";
    }
    else{
        for (NSString *keystr in [dct allKeys]){
            mPoststr = [mPoststr stringByAppendingString:[NSString stringWithFormat:@"%@=%@&", keystr, [dct valueForKey:keystr]]];
        }
        mPoststr = [mPoststr substringToIndex:(mPoststr.length-1)];
        NSLog(@"%@", mPoststr);
    }
    //Convert Request Json
    
    error = nil;
    NSData *json;
    if ([NSJSONSerialization isValidJSONObject:dct]) {
        json = [NSJSONSerialization dataWithJSONObject:dct options:NSJSONWritingPrettyPrinted error:&error];
                if (json != nil && error == nil) {
            NSString *jsonString = [[NSString alloc] initWithData:json encoding:NSUTF8StringEncoding];
                    NSLog(@"%@",jsonString);
            [self establishConnection:request withString:mPoststr];
        }
    }
}

- (void)establishConnection:(NSMutableURLRequest *)request withString:(NSString *)post {
    NSData *postData = [post dataUsingEncoding:NSASCIIStringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postData length]];
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    //[request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-Type"];

    
    [request setHTTPBody:postData];
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:request delegate:self];
    [conn start];
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    _responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    
    NSString *myString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myString);
    [_responseData appendData:data];
    NSString *myStrinag = [[NSString alloc] initWithData:_responseData encoding:NSUTF8StringEncoding];
    NSLog(@"%@",myStrinag);


    NSError* error;
    NSDictionary* json = [NSJSONSerialization JSONObjectWithData:_responseData options:kNilOptions error:&error];
    NSLog(@"Json Resp....: %@", json);
    if (json) {
        [self.serviceDelegate serviceResponseReceived:json];
    }
    else{
        
        //[DM.mAppObj stopSpinner];
        //[Helper showAlert:@"Server Error" andMessage:myString andButton:@"Ok"];

    }

    
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    return nil;
}


- (void)connection:(NSURLConnection*)connection didFailWithError:(NSError*)error
{
     [Helper showAlert:@"Error" andMessage:@"Connection error" andButton:@"Ok"];
    
    NSLog(@"Error %@",error);
}

@end
