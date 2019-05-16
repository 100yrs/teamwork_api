# frozen_string_literal: true

require 'spec_helper'

describe TeamworkApi::API::People do
  subject { TeamworkApi::Client.new('http://localhost:3000', 'xxx') }

  describe '#people' do
    before do
      stub_get(
        'http://localhost:3000/people.json'
      ).to_return(
        body: fixture('people.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.people
      expect(a_get('http://localhost:3000/people.json')).to have_been_made
    end

    it 'returns the requested people' do
      people = subject.people
      expect(people).to be_an Array
      people.each { |g| expect(g).to be_a Hash }
    end
  end

  describe '#person' do
    before do
      stub_get(
        'http://localhost:3000/people/1.json'
      ).to_return(
        body: fixture('person.json'),
        headers: { content_type: 'application/json' }
      )
    end

    it 'requests the correct resource' do
      subject.person(1)
      expect(
        a_get('http://localhost:3000/people/1.json')
      ).to have_been_made
    end

    it 'returns a single person' do
      person = subject.person(1)
      expect(person).to be_a Hash
    end
  end

  describe 'add_person_to_project' do
    it 'adds person to project' do
      stub_put('http://localhost:3000/projects/999/people.json')
      subject.add_person_to_project(999, 1)

      expect(
        a_put(
          'http://localhost:3000/projects/999/people.json'
        ).with(body: { add: { userIdList: 1 } })
      ).to have_been_made
    end
  end

  describe '#set_permissions' do
    it 'sets permissions for person on project' do
      stub_put('http://localhost:3000/projects/999/people/1.json')
      subject.set_permissions(999, 1, 'project-administrator': true)

      expect(
        a_put(
          'http://localhost:3000/projects/999/people/1.json'
        ).with(body: { permissions: { 'project-administrator': true } })
      ).to have_been_made
    end
  end
end
