=begin
Hi there. This file is a demo of how to connect Ruby to Shopify's API using basic authentication.
This is especially helpful in automating difficult tasks, such as mass deleting customers.
We are using HTTParty to connect to the shop's API and then we can use some logic to create loops and have fancy stuff like arrays of data.
I know this seems really simple, it is, but I had a hard time finding a simple way to make changes through the API without installing
an app on the store and this is just enough to do it. This is also setup for beginners like myself!
To start, you will have to install these 3 gems on your system and have ruby installed. Enter the commands below into terminal. Skip this if you already have these installed!
First install Homebrew:
/usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
Then install Ruby using Homebrew:
brew install ruby
Run these commands:
gem install shopify_api
gem install HTTParty
gem install Dotenv
Your ready to run this code! Download it to your computer then follow the next part
=end

puts "Starting program. Initializing libraries..."
require 'shopify_api'
require 'httparty'
require 'dotenv'
Dotenv.load

=begin
To access the shop backend, you need to create an app that is allowed to access the store your working on.
You will be creating API keys and storing them in a secret file that will not upload to Github, called a ".env" file.
This is what the require 'dotenv' library does above, lets you access that data in another file.
In your text editor, create a new file called ".env" and save it in the same directory as this file.
It is a text file, please copy in this text:
API_KEY=ReplaceWithAPIKey
API_SECRET=ReplaceWithAPISecret
API_SHOP="ReplaceWithYourShop.myshopify.com"
You will want to open the shop you want to work on in the browser. Then go to admin -> Apps -> Manage private apps -> Create a new private app
Give it a name, put in your email, set the write permissions (if needed) and Save
Press the "I understand, create the app" button
Copy the API key and paste it into your .env file right after API_KEY=
Copy the Password and paste it right after API_SECRET=
Change the API_SHOP= to your shop name
Save the file.
Done!
Now you are ready to connect to your shop and issue some commands!
PS. When you want to run your program, use terminal, navigate to the directory where you
stored this file and created the .env file then type this command and press enter:
ruby basicApp.rb
=end

# Next you want to declare your Variables
puts "Declaring Variables..."
API_KEY = ENV['API_KEY']
API_SECRET = ENV['API_SECRET']
API_SHOP = ENV['API_SHOP']

@CustomerIds = [
  "803461955695",
  "805660524655",
  "845475872879",
  "1022933041263"
]

#Setup Basic Authentication for httparty
# https://stackoverflow.com/questions/7627419/how-to-use-basic-authentication-with-httparty-in-a-rails-app
puts "Setting Up HTTParty Basic Auth..."
@auth = {:username => API_KEY, :password => API_SECRET}

#Run app
puts "running app test now..."

# Here is a basic test you can do to see if it's working! This will return the shop.json
def testing123
  @test = HTTParty.get("https://" + API_SHOP + "/admin/shop.json", :basic_auth => @auth)
  puts @test
end

# Create access method for code reuse - work in progress!
#def getData(command)
#  gettingData = HTTParty.get("https://" + API_SHOP + command), :basic_auth => @auth)
#  return gettingData
#end

# Access customers, download complete list of customers and push to screen
#def getCustomers
#  @getCustomers = HTTParty.get("https://" + API_SHOP + "/admin/customers.json", :basic_auth => @auth)
#puts @getCustomers
#end

# Working
#def deleteImportedCustomers

#  @CustomerIds.each { |custId|
#    response = HTTParty.delete("https://" + API_SHOP + "/admin/customers/" + custId + ".json", :basic_auth => @auth)
#    puts "Deleting first customer ID:" + custId + response.to_s
#    # Lets not flood API calls so sleep for a small time. Confirmed with Splunk this is fine and should not be throttled.
#    sleep(0.25)
#  }
#end

# When the program runs, this code calls your function/method and starts the operations.
testing123
