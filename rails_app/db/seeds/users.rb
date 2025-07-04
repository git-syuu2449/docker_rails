puts "seeding user"

FactoryBot.create(:user, :admin)
FactoryBot.create(:user, :general)
FactoryBot.create(:user, :editor)