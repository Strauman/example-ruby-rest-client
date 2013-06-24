Ruby example client for SMS Global REST API
================================

Requirements
--------------------------------
 - Ruby 1.9.3 or above


Preparation & Compile
--------------------------------
 - Install Ruby if you haven't :) http://www.ruby-lang.org/en/downloads/
 - Make sure your user has the right to execute the file SMSGlobalAPIConsumer.rb if you intend to run it as a script
~~~
/> chmod u+x SMSGlobalAPIConsumer.rb
~~~

Execution
--------------------------------
The consumer file will be your 'main' method, this file can be run as a ruby script and accepts 2 arguments and 1 option
~~~
/> ./SMSGlobalAPIConsumer.rb [-v] [-s] <Key> <Secret>
/> ./SMSGlobalAPIConsumer.rb -h
~~~
Usage:
 * \<APIKey\> : String (required) [1]
 * \<Secret\> : String (required) [1]
 * [-v] : turn on or off debugging (optional)
 * [-s] : turn on or off SSL mode (optional) [2]

Notes:
 * [1] Find your \<APIKey\> and \<Secret\> from within MXT at http://mxt.smsglobal.com/api-key.
 * [2] We're disabling SSL Certificate Verification for ease of development and less braincells burned, please consider turn in it back on by commenting out the following line

``` ruby
   # SMSGlobalAPIWrapper.rb
   http.verify_mode = OpenSSL::SSL::VERIFY_NONE # Dangerous, should not use for PRODUCTION
```

The result would look like this 

~~~
    ./SMSGlobalAPIConsumer.rb 2237275ba354517bdbd2477b7266e3c1 ccbb84e115a66eb2fc83834b8c0f31a3 -v

    == Balance ==
    opening connection to api.local...
    opened
    <- "GET /v1/balance HTTP/1.1\r\nAccept: */*\r\nUser-Agent: Ruby\r\nAuthorization: MAC id=\"2237275ba354517bdbd2477b7266e3c1\",ts=\"1372038429\",nonce=\"194261ab1a02abf8ee50c0c64bbf8534\",mac=\"vUirDqMjaBoMSICImtwQF/hkGAT8XCLMSzZiKLRp4g0=\"\r\nConnection: close\r\nHost: api.local\r\n\r\n"
    -> "HTTP/1.1 200 OK\r\n"
    -> "Server: nginx\r\n"
    -> "Date: Mon, 24 Jun 2013 01:47:19 GMT\r\n"
    -> "Content-Type: application/json\r\n"
    -> "Content-Length: 121\r\n"
    -> "Connection: close\r\n"
    -> "Cache-Control: private\r\n"
    -> "X-UA-Compatible: IE=Edge,chrome=1\r\n"
    -> "\r\n"
    reading 121 bytes...
    -> "{\"balance\":1210.1997238238,\"countryCode\":\"AE\",\"costPerSms\":0.57,\"costPerMms\":1.43,\"smsAvailable\":2111,\"mmsAvailable\":844}"
    read 121 bytes
    Conn close
    Your balance is: 1210.1997238238
    Country code: AE
    Cost per SMS: 0.57
    Cost per MMS: 1.43
    SMS available: 2111
    MMS available: 844
~~~
