namespace :gen_camp do

  task :populate_users => :environment do
    # generate 3 user
    3.times do |n|
      User.create(email: "sample#{n+2}@email.com", password_digest: Faker::Lorem.sentence(2), first_name: Faker::Name.first_name, last_name: Faker::Name.last_name)
    end     
  end

  task :with_addresses => :environment do
    users = User.all 

    ["1555 w. pender st, vancouver, bc, v6g2t1",
    "1211 melville st, vancouver, bc, v6e2a1",
    "2335 Canton Hwy #6, Windsor, ON, N8N 3N2",
    "6 Arch St #9757, Alcida, NB, E8J 2C4",
    "9547 Belmont Rd #21, Belleville, ON, K8P 1B3",
    "73 Pittsford Victor Rd, Vancouver, BC, V5Z 3K2",
    "447 Commercial St Se, LIle-Perrot, QC, J7V 4T4",
    "47 Garfield Ave, Swift Current, SK, S9H 4V2",
    "3 Mill Rd, Baker Brook, NB, E7A 1T3",
    "136 W Grand Ave #3, Delhi, ON, N4B 1C4",
    "80 Maplewood Dr #34, Bradford, ON, L3Z 2S4",
    "58 Hancock St, Aurora, ON, L4G 2J7",
    "808 Calle De Industrias, New Waterford, NS, B1H 1Z4",
    "2859 Dorsett Rd, North York, ON, M9L 2T9",
    "6857 Wall St, Red Deer, AB, T4R 2H5",
    "169 Journal Sq, Edmonton, AB, T5P 1G9",
    "3 E 31st St #77, Fredericton, NB, E3G 0A3",
    "7 N Dean St, Etobicoke, ON, M8Z 3P6",
    "8788 E 64th Ave, Vancouver, BC, V6R 1N3",
    "6437 Date Palm Dr, Calgary, AB, T2B 0X5",
    "1062 Rd, Saskatoon, SK, S7K 5J3",
    "73 Madison Ave, Vancouver, BC, V6L 2V9",
    "344 Lyndon St, Concord, ON, L4K 1J7",
    "3986 Home Life, Alma, QC, G8B 1K7",
    "8772 Old County Rd #5410, Kent, King, WA",
    "868 State St #38, Cincinnati, Hamilton, OH",
    "772 W River Dr, Bloomington, Monroe, IN",
    "8 S Haven St, Daytona Beach, Volusia, FL",
    "9 Front St, Washington, District of Columbia, DC",
    "1933 Packer Ave #2, Novato, Marin, CA",
    "67 Rv Cent, Boise, Ada, ID",
    "2 Sw Nyberg Rd, Elkhart, Elkhart, IN",
    "89992 E 15th St, Alliance, Box Butte, NE",
    "61556 W 20th Ave, Seattle, King, WA",
    "63 E Aurora Dr, Orlando, Orange, FL"].each do | addr|

      campaign = Campaign.new(title: Faker::Company.bs, 
                              description: Faker::Lorem.paragraph, 
                              goal: (10 + rand(10000)), 
                              due_date: (Time.now + 10.days), 
                              address:addr)
      campaign.user = users.sample

      campaign.reward_levels.build(title: Faker::Company.catch_phrase, 
                                    amount: 1 + rand(100), 
                                    body: Faker::Lorem.paragraph, 
                                    quantity: 1+rand(10) )
      campaign.save
    end
  end 
end

#bin/rake gen_camp:populate_users
#bin/rake gen_camp:with_addresses         to run this rake task.

#example to avoid Google timeout:  #rake geocode:all CLASS=YourModel SLEEP=0.25 BATCH=100