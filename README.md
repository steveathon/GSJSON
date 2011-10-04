= Google Search Appliance - JSON Frontend

This JSON generator in XSLT is specifically to match the GSP format
XML that is generated as a common format for many search implemen-
tations.

The JSON wraps everything in one master node 'GSP', then handles 
results by wrapping those (if they exist) in GSP/RES.

It currently needs some more work in relation to sanity checking 
but thankfully the format imposes lots of restrictions on that
anyhow.

Planned Improvements:

Onebox Support, Keymatches, Did you Mean and other Client= features.

Version 0.0.2 - Added Meta Tag support and handled generation of
                display urls slightly better to match the standard
                XSLT output.

Version 0.0.1 - Initial commit. Quick push to get working.
