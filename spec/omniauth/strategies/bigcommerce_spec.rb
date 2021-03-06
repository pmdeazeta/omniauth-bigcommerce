require 'spec_helper'

describe OmniAuth::Strategies::Bigcommerce do
  subject do
    OmniAuth::Strategies::Bigcommerce.new({})
  end

  before do
    OmniAuth.config.test_mode = true
  end

  after do
    OmniAuth.config.test_mode = false
  end

  context 'client options' do
    it 'should have correct name' do
      expect(subject.options.name).to eq('bigcommerce')
    end

    it 'should have correct site' do
      # env variable set in spec_helper.rb
      # TODO: change this once we have bigcommerceapp.com url
      expect(subject.options.client_options.site).to eq('https://example.com')
    end

    it 'should have correct authorize url' do
      expect(subject.options.client_options.authorize_url).to eq('/oauth2/authorize')
    end

    it 'should have correct token url' do
      expect(subject.options.client_options.token_url).to eq('/oauth2/token')
    end
  end

  context 'oauth2 settings' do
    it 'should ignore state' do
      expect(subject.options.provider_ignores_state).to eq true
    end
  end

  context 'callback url' do
    it 'should have the correct path' do
      subject.callback_path.should eq('/auth/bigcommerce/callback')
    end
  end

  context 'authorize options' do
    describe 'context' do
      it 'should set the context parameter dynamically in the request' do
        allow(subject).to receive(:request) do
          double('Request', :params => {'context' => 'stores/abcdefg'}, :cookies => {}, :env => {})
        end
        expect(subject.authorize_params['context']).to eq('stores/abcdefg')
      end
    end
  end
end
