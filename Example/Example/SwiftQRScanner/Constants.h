

#ifndef Constants_h
#define Constants_h

#define ios7BlueColor [[UIColor alloc] initWithRed:68/255.0 green:176/255.0 blue:220/255.0 alpha:1.0]
#define universalTheme [[UIColor alloc] initWithRed:51/255.0 green:135/255.0 blue:198/255.0 alpha:1.0]


#define IS_PAD  (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#define MyriadProRegular [UIFont fontWithName:@"MyriadPro-Regular" size:IS_PAD?20:16]
#define MyriadProRegular2 [UIFont fontWithName:@"MyriadPro-Regular" size:IS_PAD?18:14]
#define MyriadProRegularSmaller [UIFont fontWithName:@"MyriadPro-Regular" size:IS_PAD?16:12]
#define MyriadProRegularSmallerer [UIFont fontWithName:@"MyriadPro-Regular" size:IS_PAD?16:10]

#define MyriadProSemibold [UIFont fontWithName:@"MyriadPro-Semibold" size:IS_PAD?20:16]

#define JFFlatRegular [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?20:16]
#define JFFlatRegularS [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?18:14]
#define JFFlatRegularSmaller [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?14:14]
#define JFFlatBig [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?50:40]
#define JFFlatMedium [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?30:25]
#define JFFlatMedium2 [UIFont fontWithName:@"JFFlat-Regular" size:IS_PAD?22:20]
#define Helvetica [UIFont fontWithName:@"Helvetica" size:IS_PAD?18:14]

#define myPDVURL @"https://www.mypdv.com/rest/myPDVservWS"
#define LogIn_URL @"http://www.myPDV.com/Rest/myPDVServWS/Login.svc/Authenticate"

#endif /* Constants_h */
