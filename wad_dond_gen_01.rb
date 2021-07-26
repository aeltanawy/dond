# Ruby code file - All your code should be located between the comments provided.

# Main class module
module DOND_Game
	# Input and output constants processed by subprocesses. MUST NOT change.
	GOES = 5

	class Game
		attr_reader :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts
		attr_writer :sequence, :selectedboxes, :openedboxes, :chosenbox, :selectedbox, :turn, :input, :output, :winner, :played, :wins, :losses, :guess, :values, :amounts

		def initialize(input, output)
			@input = input
			@output = output
		end

		def getinput
			@input.gets.chomp.upcase
		end

		def storeguess(guess)
			if guess != ""
				@selectedboxes = @selectedboxes.to_a.push "#{guess}"
			end
		end

		# Any code/methods aimed at passing the RSpect tests should be added below.

		def start
			@output.puts "Welcome to Deal or No Deal!"
			@output.puts "Designed by: #{created_by}"
			@output.puts "StudentID: #{student_id}"
			@output.puts "Starting game..."
		end

		def created_by
			"Abeer Eltanawy"
		end

		def student_id
			"51773155"
		end

		def displaymenu
			@output.puts "Menu: (1) Play | (2) New | (3) Analysis | (9) Exit"
		end

		def resetgame
			@output.puts "New game..."
			self.sequence = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			self.selectedboxes = []
			self.openedboxes = [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]
			self.chosenbox = 0
			self.selectedbox = 0
			self.turn = 0
			self.winner = 0
			self.played = 0
			self.wins = 0
			self.losses = 0
			self.guess = ""
			self.values = [0.01,0.10,0.50,1.00,5.00,10.00,50.00,100.00,250.00,500.00,750.00,1000.00,3000.00,5000.00,10000.00,15000.00,20000.00,35000.00,50000.00,75000.00,100000.00,250000.00]
			self.amounts = self.values
			#assignvaluestoboxes
		end

		def assignvaluestoboxes
			#@sequence = Array.new
			@sequence = @values.clone
			@sequence.shuffle!
		end

		def showboxes
			for n in (1..22) do
				if @openedboxes[n-1] == 0 && @chosenbox != n
					s = "Closed"
					g = "[#{n}]"
				elsif @openedboxes[n-1] == 1 && @chosenbox != n
					s = "Opened"
					g = "|#{n}|"
				elsif @chosenbox == n
					s = "Kept"
					g = "*#{n}*"
				end
				#@output.print "Box #{n}: "
				@output.print "#{g} "
				@output.print "Box "
				@output.puts "#{g} Status: #{s}"
			end
		end

		def showamounts
			col1 = 0
			col2 = 11
			for i in (0..10)
				c1 = @amounts[col1 + i]
				c2 = @amounts[col2 + i]
				@output.puts "#{c1}   #{c2}"
			end
		end

		def removeamount(value)
			n = @amounts.index(value)
			@amounts[n] = "    "
		end

		def setchosenbox(b)
			@chosenbox = b
		end

		def getchosenbox
			@chosenbox
		end

		def displaychosenbox
			box = getchosenbox
			@output.puts "Chosen box: [#{box}]"
		end

		def displaychosenboxvalue
			value = @sequence[getchosenbox - 1]
			box = getchosenbox
			@output.puts "Chosen box: [#{box}] contains: #{value}"
		end

		def displaychosenboxprompt
			@output.puts "Enter the number of the box you wish to keep."
		end

		def displaychosenboxerror
			@output.puts "Error: Box number must be 1 to 22."
		end

		def displayanalysis
			@output.puts "Game analysis..."
			showboxes
		end

		def boxvalid(guess)
			@guess = guess.to_i
			if @guess.between?(1, 22)
				return 0
			else
				return 1
			end
		end

		def showselectedboxes
			@output.puts "Log: #{@selectedboxes.inspect}"
		end

		def displayselectboxprompt
			@output.puts "Enter the number of the box you wish to open. Enter returns to menu."
		end

		def openbox(guess)
			@openedboxes[guess-1] = 1
		end

		def bankerphoneswithvalue(offer)
			#offer = rand(0..100000)
			@output.puts "Banker offers you for your chosen box: #{offer}"
			@output.puts "Deal (Y) or no Deal (N)?"
		end

		def bankercalcsvalue(value)
			value / 2
		end

		def numberofboxesclosed
			c = 0
			for i in (0..21) do
				if @openedboxes[i] == 0
					c += 1
				end
			end
			return c
		end

		def incrementturn
			@turn += 1
		end

		def getturnsleft
			#incrementturn
			GOES - @turn
		end

		def finish
			@output.puts "... game finished."
		end

		#extra
		def displayselectedboxvalue
			value = @sequence[@selectedbox - 1]
			removeamount(value)
			box = @selectedbox
			@output.puts "Selected box: [#{box}] contains: #{value}"
		end

		def setselectedbox(b)
			@selectedbox = b
		end

		def addselectedbox(b)
			@selectedboxes.push(b)
		end
		#extra

		# Any code/methods aimed at passing the RSpect tests should be added above.

	end
end
