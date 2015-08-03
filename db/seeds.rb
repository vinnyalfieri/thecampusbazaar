# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

users = User.create([{name: 'Karlie Kloss', email: 'kkloss@flatironschool.edu', password: "imamodel123", password_confirmation: 'imamodel123'}, 
  {name: 'Vinny Alfieri', email: 'vinnyboy@flatironschool.edu', password: 'newjerseyroxmysox',password_confirmation: 'newjerseyroxmysox'}, 
  {name: 'MinLing Zhao', email: 'ml@nyu.edu', password: 'projectivespace', password_confirmation: 'projectivespace'}, 
  {name: 'Jake Faris', email: 'farisj@flatironschool.edu', password: 'californiaboy27',password_confirmation: 'californiaboy27'}, 
  {name: 'Sara Tibbetts', email: 'sxt4866@rit.edu', password: 'thisisapassword',password_confirmation: 'thisisapassword'}, 
  {name: 'Elle Woods', email: 'prettyinpink@harvard.edu', password: 'bruiserwoods',password_confirmation: 'bruiserwoods'}, 
  {name: 'Ada Lovelace', email: 'a.lovelace@flatironschool.edu', password: 'codeispoetry',password_confirmation: 'codeispoetry'}, 
  {name: 'Tommy McGuire', email:'nerdyengineer@rit.edu', password:'eequalsmcsquared',password_confirmation:'eequalsmcsquared'}, 
  {name: 'Emanuel Lori', email: 'e.lori@flatironschool.edu', password: 'iamemanuel',password_confirmation: 'iamemanuel'}, 
  {name: 'Avi Flombaum', email: 'avi@flatironschool.edu', password: 'iliketwitter',password_confirmation: 'iliketwitter'}, 
  {name: 'George Hotz', email: 'geohot@rit.edu', password: 'ihackthings',password_confirmation: 'ihackthings'}, 
  {name: 'Emma McSeedy', email: 'emma@nyu.edu', password: 'seedsareseedy',password_confirmation: 'seedsareseedy'}, 
  {name: 'Gloria Winnebago', email: 'gloria@nyu.edu', password: 'inexcelcisdeo',password_confirmation: 'inexcelcisdeo'}, 
  {name: 'Dorothy Cohen Schwartz', email: 'dime1@nyu.edu', password: 'dphie',password_confirmation: 'dphie'}, 
  {name: 'Ida Beinstalk Landau', email: 'dime2@nyu.edu', password: 'unicorn',password_confirmation: 'unicorn'}, 
  {name: 'Minna Goldsmith Mahler', email: 'dime3@nyu.edu', password: 'lovelypurpleiris',password_confirmation: 'lovelypurpleiris'}, 
  {name: 'Eva Effron Robin', email: 'dime4@nyu.edu', password: 'essequamvidere',password_confirmation: 'essequamvidere'}, 
  {name: 'Sylvia Steir Cohn', email: 'dime5@nyu.edu', password: 'ilovepearls',password_confirmation: 'ilovepearls'}, 
  {name: 'Sam Feine', email: 'sammyboy@rit.edu', password: 'loud',password_confirmation: 'loud'}, 
  {name: 'Billy Fanelli', email: 'waf6826@rit.edu', password: 'imfromridgewood',password_confirmation: 'imfromridgewood'}, 
  {name: 'Kristen VonSteuben', email: 'kristen@rit.edu', password: 'toothless',password_confirmation: 'toothless'}, 
  {name: 'Mikenzie Kusenberger', email: 'kenzie@rit.edu', password: 'captainamerica',password_confirmation: 'captainamerica'}, 
  {name: 'Will Kommritz', email: 'willy@rit.edu', password: 'kommritzatrit',password_confirmation: 'kommritzatrit'}, 
  {name: 'Stew Ped', email: 'stewwy@harvard.edu', password: 'imnotstupid',password_confirmation: 'imnotstupid'}, 
  {name: 'Laura Wilbar', email: 'laura@harvard.edu', password: 'imsupersmart',password_confirmation: 'imsupersmart'}, 
  {name: 'Harry Potter', email: 'harry@harvard.edu', password: 'whyditransfer',password_confirmation: 'whyditransfer'}])

@nyu = Community.create(name: 'New York University')
@rit = Community.create(name: 'Rochester Institue of Technology')
@flatiron = Community.create(name: 'Flatiron School')
@harvard = Community.create(name: 'Harvard University')

User.all.each do |user|
  email = user.email.split("@")[1].gsub(".edu", "")
  case email 
  when "nyu"
    user.community = @nyu
    user.save
  when "flatironschool"
    user.community = @flatiron
    user.save
  when "rit"
    user.community = @rit
    user.save
  when "harvard"
    user.community = @harvard
    user.save
  end
end 

categories = Category.create([{name: 'Furniture'}, {name: 'Textbooks'}, 
  {name: 'Food'}, {name: 'Electronics'}, {name: 'Clothing'}, {name: 'Pets'}, 
  {name: 'Musical Instruments'}, {name: 'Apliances'}, {name: 'Toys'}, 
  {name: 'Jewelry'}, {name: 'Shoes'}, {name: 'Automotive'}, {name: 'Tools'}])

@car1 = Item.create(name: 'Chrysler 200', price: '22000.00', description: '2011 Chrysler 200 in Ruby Red', condition: 'Excellent')
@car2 = Item.create(name: 'Chrysler 300', price: '30000.00', description: '2015 Chrysler 300 in Jet Black', condition: 'Excellent')
@tuba = Item.create(name: 'Tuba', price: '55.50', description: 'Miraphone 98 Siegfried Series 5-Valve 6/4 BBb Tuba Lacquer Yellow Brass Body', condition: 'Excellent')
@cello = Item.create(name: 'Cello', price: '130.99', description: 'Getmore Durable 4/4 Size Wood Acoustic Cello with Bag Bow Rosin Bridge Black', condition: 'Good')
@flute = Item.create(name: 'Flute', price: '15.00', description: 'Gemeinhardt 1SP Student Flute', condition: 'Poor')
@drums = Item.create(name: 'Drum Set', price: '550.00', description: 'Complete 5-Piece Black Junior Drum Set with Cymbals Stands Sticks Hardware & Stool', condition: 'Good')
@kabba = Item.create(name: 'Kabba', price: '12.00', description: 'Seriously understated instrument', condition: 'Excellent')
@jello = Item.create(name: 'Jello', price: '2.00', description: 'JELL-O Gelatin Dessert, Berry Blue', condition: 'Excellent')
@pie = Item.create(name: 'Apple Pie', price: '20.00', description: 'Freshly baked apple pie', condition: 'Excellent')
@cheezits = Item.create(name: 'Cheezits', price: '5.00', description: 'Box of Cheezits', condition: 'Good')
@sloppyjoe = Item.create(name: 'Sloppy Joe', price: '1.00', description: 'The sloppiest sloppy joe', condition: 'Poor')
@car3 = Item.create(name: 'Ford Explorer', price: '1000.00', description: '1995 Ford Explorer in Blue', condition: 'Poor')
@car4 = Item.create(name: 'Porsche', price: '50000.00', description: '2016 Porche in Black', condition: 'Excellent')
@ipad = Item.create(name: 'iPad', price: '200.00', description: 'Apple iPad, some scratches', condition: 'Good')
@dvd = Item.create(name: 'DVD Player', price: '20.00', description: 'Sony DVD Player', condition: 'Good')
@movie1 = Item.create(name: 'Minions', price: '10.00', description: 'The Minions movie! (totally legal)', condition: 'Excellent')
@movie2 = Item.create(name: 'The Road to El Dorado', price: '1.00', description: 'The Road to El Dorado on VHS', condition: 'Good')
@movie3 = Item.create(name: 'Frozen', price: '2.00', description: 'Coldness in a movie', condition: 'Poor')
@lenovo = Item.create(name: 'ThinkPad T430', price: '200.00', description: 'ThinkPad T430 running Windows 10', condition: 'Good')
@shirt = Item.create(name: 'Shirt', price: '3.00', description: 'Black T-Shirt', condition: 'Good')
@movie4 = Item.create(name: 'Legally Blonde', price: '2.00', description: 'The pink in flesh', condition: 'Good')
@hammer = Item.create(name: 'Hammer', price: '4.00', description: 'Hits stuff', condition: 'Good')
@printer = Item.create(name: '3D Printer', price: '400.00', description: 'Makerbot 3D printer', condition: 'Good')
@heels = Item.create(name: 'Heels', price: '10.00', description: 'Fancy formal heels', condition: 'Good')
@tb1 = Item.create(name: 'Physics', price: '200.00', description: 'Physics Edition 1', condition: 'Good')
@tb2 = Item.create(name: 'Computer Organization', price: '400.50', description: 'RIT\'s custom calculus book', condition: 'Excellent')
@tb3 = Item.create(name: 'Thomas Trancendentalist Calculus', price: '50000.00', description: '2016 Porche in Black', condition: 'Excellent')
@tb4 = Item.create(name: 'Circuits I', price: '20.00', description: 'Circuits I textbook', condition: 'Poor')
@tb5 = Item.create(name: 'Intro to Electronics', price: '40.00', description: 'Electronics I textbook', condition: 'Poor')

@car1.categories << Category.find_by(name: "Automotive")
@car2.categories << Category.find_by(name: "Automotive")
@car3.categories << Category.find_by(name: "Automotive")
@car4.categories << Category.find_by(name: "Automotive")
@tb1.categories << Category.find_by(name: "Textbooks")
@tb2.categories << Category.find_by(name: "Textbooks")
@tb3.categories << Category.find_by(name: "Textbooks")
@tb4.categories << Category.find_by(name: "Textbooks")
@tb5.categories << Category.find_by(name: "Textbooks")
@heels.categories << Category.find_by(name: "Clothing")
@heels.categories << Category.find_by(name: "Shoes")
@printer.categories << Category.find_by(name: "Tools")
@printer.categories << Category.find_by(name: "Electronics")
@hammer.categories << Category.find_by(name: "Tools")
@movie1.categories << Category.find_by(name: "Electronics")
@movie2.categories << Category.find_by(name: "Electronics")
@movie3.categories << Category.find_by(name: "Electronics")
@movie4.categories << Category.find_by(name: "Electronics")
@shirt.categories << Category.find_by(name: "Clothing")
@lenovo.categories << Category.find_by(name: "Electronics")
@dvd.categories << Category.find_by(name: "Electronics")
@ipad.categories << Category.find_by(name: "Electronics")
@sloppyjoe.categories << Category.find_by(name: "Food")
@cheezits.categories << Category.find_by(name: "Food")
@pie.categories << Category.find_by(name: "Food")
@jello.categories << Category.find_by(name: "Food")
@kabba.categories << Category.find_by(name: "Musical Instruments")
@flute.categories << Category.find_by(name: "Musical Instruments")
@tuba.categories << Category.find_by(name: "Musical Instruments")
@cello.categories << Category.find_by(name: "Musical Instruments")

users[0].items.push(@cello, @ipad, @tuba)
users[1].items.push(@flute, @kabba, @jello, @car1)
users[2].items.push(@pie)
users[3].items.push(@movie1, @movie2, @movie3, @movie4)
users[4].items.push(@cheezits)
users[5].items.push(@sloppyjoe, @dvd)
users[6].items.push(@lenovo)
users[7].items.push(@shirt, @heels, @car2)
users[8].items.push(@hammer)
users[9].items.push(@printer)
users[10].items.push(@tb1, @tb2)
users[11].items.push(@tb3, @car4)
users[12].items.push(@tb5)
users[13].items.push(@car3)

users.each do |user|
  user.save 
end 
























