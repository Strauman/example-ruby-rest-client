# SMS GLobal
# http://smsglobal.com

require "./SMSGlobalAPIWrapper.rb"

key = "2237275ba354517bdbd2477b7266e3c1"
secret = "ccbb84e115a66eb2fc83834b8c0f31a3"
wrapper = SMSGlobalAPIWrapper.new(key, secret, "http", "api.local", "80", "v1", "")

wrapper.get("balance")
