require 'spec_helper'

describe HomeController, :type => :routing do
  describe 'routing' do
    it 'routes to #index' do
      expect(get('/')).to route_to('home#index')
    end

    it 'routes to #rules' do
      expect(get('/rules')).to route_to('home#rules')
    end

    it 'routes to #ranking' do
      expect(get('/ranking')).to route_to('home#ranking')
    end
  end
end
