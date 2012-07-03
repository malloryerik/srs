require 'fileutils'
require 'digest/sha1'

module SRS
	class CLI
		class InsertExercise
			def run!(arguments)
				if not SRS::Workspace.initialised? then
					puts "Current directory is not an SRS Workspace"
					return 3
				end

				data = STDIN.read()
				sha1 = Digest::SHA1.hexdigest data
				sha1_start = sha1[0..1]
				sha1_rest = sha1[2..-1]
				datafile = "exercises/#{sha1_start}/#{sha1_rest}"

				if not File.exists?(datafile) then
					FileUtils::mkdir_p("exercises/#{sha1_start}")
					File.open(datafile, 'w') {|f| f.write(data)}
				end

				puts sha1

				return 0
			end

			def help()
				puts <<-EOF
srs insert-exercise

Reads the contents from stdin and inserts it as an exercise into the workspace.
Returns the id used to access that exercise.
					EOF
			end
		end
	end
end



