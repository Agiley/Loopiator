require File.expand_path('../../spec_helper', __FILE__)

describe "Loopiator Api Client"  do
  describe "- When initializing a new client" do

    describe "- With defaults:" do
      before(:each) do
        config = {username:  "test_user",
                  password:  "test_password",
                  endpoint:  "https://api.loopia.se/RPCSERV" }
        
        Loopiator::Client.any_instance.expects(:set_config).at_least_once.returns(config)
        
        @client = Loopiator::Client.new(config)
      end

      it "should have a username set" do
      	@client.username.should == "test_user"
      end

      it "should have a password set" do
      	@client.password.should == "test_password"
      end
      
      it "should have an endpoint set" do
      	@client.endpoint.should == "https://api.loopia.se/RPCSERV"
      end

    end

  end
end

