# Ruby code file - All your code should be located between the comments provided.

# Add any additional gems and global variables here
require 'sinatra'

$reset = true
$offer = 0
$repeat_menu_display = true

# The file where you are to write code to pass the tests must be present in the same folder.
# See http://rspec.codeschool.com/levels/1 for help about RSpec
require "#{File.dirname(__FILE__)}/wad_dond_gen_01"

# Main program
module DOND_Game
	@input = STDIN
	@output = STDOUT
	g = Game.new(@input, @output)
	playing = true
	input = ""
	menu = ""
	guess = ""
	box = 0
	turn = 0
	win = 0
	deal = 0
	@output.puts "\n" + '-------------------------------------------------------------------------' + "\n"
	@output.puts "\n" + 'Enter "1" runs game in command-line window or "2" runs it in web browser.' + "\n"
	@output.puts "\n" + '-------------------------------------------------------------------------' + "\n"
	game = @input.gets.chomp
	if game == "1"
		@output.puts "\nCommand line game.\n"
	elsif game == "2"
		@output.puts "\nWeb-based game.\n"
	else
		@output.puts "\nInvalid input! No game selected.\n"
		exit
	end

	if game == "1"

	# Any code added to command line game should be added below.

		while $reset == true #New game loop
			g.start				# calls start method
			g.resetgame				# calls resetgame method
			@output.puts "\n"			# outputs newline to terminal command line window
			g.assignvaluestoboxes
			@output.puts "--- #{g.values} ---\n\n"
			g.showboxes
			@output.puts "\n"
			g.played += 1

			while g.played < 22 && g.numberofboxesclosed != 2 #loop to continue playing
				$reset = false #
				if g.getchosenbox == 0 #conditional statement if chosen box is not set to choose a box to keep
					g.displaychosenboxprompt
					loop do
						box = gets.chomp.to_i
						@output.puts "\n"
						#g.boxvalid(box)
						break if g.boxvalid(box) == 0
						g.displaychosenboxerror
					end
					g.setchosenbox(box)
					g.displaychosenbox
					#@output.puts "\n"
				end
				repeat = 1

				while repeat == 1 #loop to validate menu number
					@output.puts "\n"
					$repeat_menu_display = true

					while $repeat_menu_display == true && g.numberofboxesclosed != 2
						#$repeat_menu_display = false
						g.displaymenu
						menu = gets.chomp
						@output.puts "\n"

						case menu

							when "1"
								repeat = 0
								17.times{@output.print "-"}
								@output.puts "\n"
								g.showamounts
								17.times{@output.print "-"}
								@output.puts "\n\n"
								g.showboxes
								@output.puts "\n"
								g.showselectedboxes
								@output.puts "\n"
								g.displayselectboxprompt
								loop do #loop to check validiting of box number
									box = gets
									@output.puts "\n"
									if box == "\n"
										#$repeat_menu_display = true
										break
									else #if box != "\n"
										box = box.to_i
										$repeat_menu_display = false
										if g.boxvalid(box) == 1
											g.displaychosenboxerror
										elsif g.itself.selectedboxes.include? box
											@output.puts "Error: Box #{box} has already been opened! Choose another number."
										elsif g.itself.chosenbox == box
											@output.puts "Error: Box #{box} is your chosen box to keep! Choose another number."
										else
											#$repeat_menu_display = false
											break
										end
									end
								end
								if $repeat_menu_display == false #to be only executed if global variable repeat_menu_display is false
									$repeat_menu_display = true
									g.setselectedbox(box)
									g.displayselectedboxvalue
									@output.puts "\n"
									g.played += 1
									g.incrementturn
									if g.getturnsleft == 0  && deal == 0 #check for turns left and start banker offer
										#value = rand(0..100000)
										#@output.puts "\n"
										#offer = g.bankercalcsvalue(value)
										offer = 0
										sum = 0
										g.itself.amounts.each { |b| sum += b.to_f }
										offer = sum / g.numberofboxesclosed #offer based on closed boxes average
										offer = offer.round(2) #rounding to 2 decimal places
										g.bankerphoneswithvalue(offer)
										loop do #banker offer loop if decision is not N or Y
											decision = gets.chomp.upcase
											#@output.puts "\n"
											if decision == "Y"
												#win = 1
												deal = 1
												win = offer
												@output.puts "\nDeal! You win: #{win}.\nContinue to open boxes!"
												break
											elsif decision == "N"
												g.itself.turn = 0
												break
											elsif
												@output.puts "\nError: You must enter 'Y' to accept the banker deal, or 'N' to refuse it!"
											end
										end #end of decision validation loop
									elsif deal != 1
										@output.puts "You have #{g.getturnsleft} turns left before the banker offer!"
									end #end of banker offer
									g.addselectedbox(box)
									@output.puts "\n"
									g.showselectedboxes if g.numberofboxesclosed != 2
									g.openbox(box)
								end

							when "2"
								repeat = 0
								#deal = 0
								#g.played = 0
								$reset = true
								#$repeat_menu_display = true
								break

							when "3"
								repeat = 0
								@output.puts "\n"
								g.displayanalysis
								@output.puts "\n"

							when "9"
								@output.puts "Are you sure you want to exit the game? (Y/N):"
								loop do #loop to validate entry is Y or N
									end_game = gets.chomp.upcase
									#@output.puts "\n"
									if end_game == "Y"
										@output.puts "\n"
										g.finish
										exit
									elsif end_game == "N"
										break
									else
										@output.puts "\nError: You must enter 'Y' to end the game or 'N' to resume playing."
									end #ends loop to validate entry of Y or N
								end

							else
								repeat = 1
								@output.puts "You must select a number from the menu! Try again."
						end #ends case statement

					end #ends repeat displaying menu

				end #ends loop for validating menu choices when repeat == 0

				if $reset == true #if statement to restart the game
					break
				end

			end #ends playing the current game

			@output.puts "\n"
			for i in (1..22) #display last 2 boxes
				if g.itself.openedboxes[i-1] == 0
					value = g.itself.sequence[i-1]
					@output.puts "Box: #{i} contains: #{value}"
				end

			end

			if $reset != true
				@output.puts "\n"
				g.displaychosenboxvalue
				if deal == 1
					@output.puts "\nYou win the banker offer of: #{win}!\n"
				elsif
					value = g.itself.sequence[g.getchosenbox-1]
					@output.puts "\nYou win the chosen box value of: #{value}!\n"
				end
			end

			$reset = true
			@output.puts "\n" + '-------------------------------------------------------------------------' + "\nRestarting Deal or no Deal!\n"

		end #ends loop for restaring a new game

		@output.puts "\n"
		g.finish				# calls finish method

	# Any code added to command line game should be added above.

		exit	# Does not allow command-line game to run code below relating to web-based version

	end

end
#End modules

#Sinatra routes

# Any code added to web-based game should be added below.

set :app_file, __FILE__
set :port, 8080
set :public_folder, Proc.new { File.join(root, "public") }
set :views, Proc.new { File.join(root, "views") }

#set global and local variables
$reset = true
#from wad_dond_gen_01.rb file
helpers do

	def resetgame
		$title = "Deal or No Deal"
		$offer = 0
		$boxes_left = 22
		$turn = 5
		$played = 0
		$values = [0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
		$status = "New game"
		$box_status = Array.new(21) #to define the box div class
		$amount_status = Array.new(21) #to define the amount div class
		$sequence = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		$chosenbox = 0
		$value_to_remove_index = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
		$deal = 0
		@selectedbox = 0
		@win = 0
	end

	def assignvaluestoboxes
		$sequence = $values.clone
		$sequence.shuffle!
	end

	def getchosenboxvalue
		i = $chosenbox.to_i
		return $sequence[i - 1]
	end

	def removevalue_i(selected)
		value = $sequence[selected-1]
		v = $values.index(value)
		$value_to_remove_index[v] = 1
	end

	def decrementturn
		if $deal == 0
			$turn -= 1
		end
	end

	def banker_offer
		offer = 0
		sum = 0
		v_index = $value_to_remove_index
		v_left = $values
		v_left.collect.with_index {|v, i| sum += v.to_f if v_index[i] == 0 }
		offer = sum / ($boxes_left + 1) #offer based on closed boxes average
		$offer = offer.round(2) #rounding to 2 decimal places
	end

	def displayselectedboxvalue
		value = $sequence[@selectedbox-1]
		box = @selectedbox
		@output = "Selected box: [#{box}] contains: #{value}"
	end

end

#Link to game.erb
get '/' do
  $title
	if $reset == true
		resetgame
		assignvaluestoboxes
		for i in (0..21)
			$box_status[i] = "closed"
		end
		erb :choose_box
	elsif $deal == 0
		$status = "Playing"
	   erb :game
	elsif $deal == 1
		$status = "Open Boxes"
		erb :game
	end
end

#Action and processes after clicking a closed box
put '/box/:num' do
	if $boxes_left > 1
		$played += 1 if $deal == 0
		$boxes_left -= 1
		decrementturn
		box = params[:num]
		box = box.to_i
		$box_status[box-1] = "opened"
		removevalue_i(box)
		if $turn == 0 && $deal == 0
			redirect '/offer'
		end
		redirect '/'
	elsif $boxes_left == 1
		redirect '/win'
	end
end

get '/win' do
	$status = "Finished"
	erb :win
end

post '/choose_box' do
	$reset = false
	$chosenbox = "#{params[:chosenbox]}"
	box = $chosenbox.to_i
	$box_status[box-1] = "kept"
	$boxes_left -= 1
	redirect '/'
end

get '/offer' do
	erb :offer
end

get '/offer/deal' do
	$deal = 1
	redirect '/'
end

get '/offer/nodeal' do
	$turn = 5
	redirect '/'
end

get '/restart' do
	$reset = true
	redirect '/'
end

#redirect to homepage when sinatra can't locate the requested URL
not_found do
	status 404
	$reset = false
	redirect '/'
end

# Any code added to web-based game should be added above.

#End program
