# Google Search Appliance - JSON Frontend

This JSON generator in XSLT is specifically to match the GSP format XML that is generated as a common format for many search implementations.

The JSON wraps everything in one master node 'GSP', then handles results by wrapping those (if they exist) in GSP/RES.

It currently needs some more work in relation to sanity checking but thankfully the format imposes lots of restrictions on that anyhow.


## Todo
* Test cases
* Sanity checks
* JavaScript Examples
* Other client features


## Changelog

### 0.0.7
* Added Dynamic Navigation Elements

### 0.0.6
* Moved PARAM to a template, instead of doing inline processing. Inline with local version.

### 0.0.5 
* Fixed minor issue in readme file.

### 0.0.4
* Added CRAWLDATE to R (Issue #8)
* Fixed FS tag (Issue #7)
* Set the S tag to populate -- need to sanitize (Issue #9)

### 0.0.3
* Added OneBox support [ENTOBRESULT](http://code.google.com/apis/searchappliance/documentation/50/oneboxguide.html)
* Added Key Match support (GM)
* Added Spelling support (Spelling/Suggestion)
* Added Synonym support (Synonym)

### 0.0.2
Added Meta Tag support and handled generation of display urls slightly better to match the standard XSLT output.

### 0.0.1
Initial commit. Push to get things working.
