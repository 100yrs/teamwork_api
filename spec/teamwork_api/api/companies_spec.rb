# frozen_string_literal: true

require 'spec_helper'

describe TeamworkApi::API::Companies do
  subject { TeamworkApi::Client.new('http://localhost:3000', 'xxx') }

  describe '#companies' do
    before do
      stub_get(
        'http://localhost:3000/companies.json'
      ).to_return(
        body: fixture('companies.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.companies
      expect(a_get('http://localhost:3000/companies.json')).to have_been_made
    end

    it 'returns companies' do
      companies = subject.companies
      expect(companies).to be_an Array
      expect(companies.first).to be_a Hash
    end
  end

  describe '#company' do
    before do
      stub_get(
        'http://localhost:3000/companies/999.json'
      ).to_return(
        body: fixture('company.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.company(999)
      expect(
        a_get('http://localhost:3000/companies/999.json')
      ).to have_been_made
    end

    it 'returns a single company' do
      company = subject.company(999)
      expect(company).to be_a Hash
    end
  end

  describe '#company_by_name' do
    before do
      stub_get(
        'http://localhost:3000/companies.json'
      ).to_return(
        body: fixture('companies.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'returns the named company' do
      company = subject.company_by_name('Company One')
      expect(company).to be_a Hash
      expect(company['name']).to eq 'Company One'
    end
  end
end
