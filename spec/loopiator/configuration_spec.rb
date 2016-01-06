require File.expand_path('../../spec_helper', __FILE__)

describe "Loopiator Configuration"  do
  context "When configuring Loopiator" do
    
    context "Using defaults" do
      it "should not have a username set" do
        expect(Loopiator.configuration.username).to be == nil
      end

      it "should not have a password set" do
        expect(Loopiator.configuration.password).to be == nil
      end
      
      it "should have a default port set" do
        expect(Loopiator.configuration.port).to be == 443
      end
      
      it "should have a default path set" do
        expect(Loopiator.configuration.path).to be == "/RPCSERV"
      end
      
      it "should have a default timeout set" do
        expect(Loopiator.configuration.timeout).to be == 180
      end
    end
    
    context "Using custom configuration" do
      before :each do
        Loopiator.configure do |config|
          config.username     =   "test_user"
          config.password     =   "test_password"
          config.timeout      =   200
          config.proxy_host   =   "192.1.1.1"
          config.proxy_port   =   8080
        end
      end
      
      after :each do
        Loopiator.reset
      end

      it "should have a custom username set" do
        expect(Loopiator.configuration.username).to be == "test_user"
      end

      it "should have a custom password set" do
        expect(Loopiator.configuration.password).to be == "test_password"
      end
      
      it "should have a custom timeout set" do
        expect(Loopiator.configuration.timeout).to be == 200
      end
      
      it "should have a custom proxy host set" do
        expect(Loopiator.configuration.proxy_host).to be == "192.1.1.1"
      end
      
      it "should have a custom proxy port set" do
        expect(Loopiator.configuration.proxy_port).to be == 8080
      end
      
      it "should have a default port set" do
        expect(Loopiator.configuration.port).to be == 443
      end
      
      it "should have a default path set" do
        expect(Loopiator.configuration.path).to be == "/RPCSERV"
      end
    end

  end
end