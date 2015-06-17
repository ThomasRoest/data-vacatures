require 'rails_helper'

RSpec.describe Job, :type => :model do
  
 it 'is valid with the right attributes' do 
 	job = build(:job)
 	expect(job).to be_valid
 end

 it 'is invalid without a GUID' do
 	job = build(:job, guid: nil)
 	job.valid?
 	expect(job.errors[:guid]).to include('moet opgegeven zijn')
 end

 it 'is invalid without a company name' do 
 	job = build(:job, company: nil)
 	job.valid?
 	expect(job.errors[:company]).to include('moet opgegeven zijn')
 end

 it 'is invalid without a place' do 
 	job = build(:job, place: nil)
 	job.valid?
 	expect(job.errors[:place]).to include(', Voeg een plaatsnaam toe')
 end

 it 'is invalid without a description' do 
 	job = build(:job, description: nil)
 	job.valid?
 	expect(job.errors[:description]).to include(', Voeg een functie omschrijving toe')
 end

 it 'is invalid if a job with this GUID already exists' do
 	job1 = create(:job, guid: '12345')
 	job2 = build(:job, guid: job1.guid)
 	job2.valid?
 	expect(job2).not_to be_valid
 	expect(job2.errors[:guid]).to include(", Er is al een vacature geplaatst met deze aankoop")
 end

  #guid can only be used once also if the job and ubscriptoin are deleted = ok!
  #job cannot be posted if the guid is associated with a subsciption with state 'errored'


end
