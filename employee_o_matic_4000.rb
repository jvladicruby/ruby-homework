class Employee
    attr_accessor :full_name
    attr_accessor :id

    def initialize(full_name, id)
        @full_name = full_name
	@id = id
    end

    def last_name
        @full_name.split(' ', 2).last
    end

    def first_name
        @full_name.split(' ', 2).first
    end
end

class Programmer < Employee
    attr_accessor :languages

    def initialize(full_name, id, languages)
        super(full_name, id)
	@languages = languages.split(', ')
    end
end

class OfficeManager < Employee
    attr_accessor :office

    def initialize(full_name, id, office)
        super(full_name, id)
        @office = "(#{office})"
    end

    def off
        @office.downcase[1]
    end
end

# Here we are declaring methods

def add_employee(employees)
    puts '[Add an employee]'
    print 'Full name: '
    full_name = gets.chomp
    print 'ID: '
    id = gets.chomp

    print 'Is the person an [e]mployee, [p]rogrammer or an [o]ffice manager? '
    action = get_action
    case action
    when 'e' then employee = Employee.new(full_name, id)
    when 'p' then
        print 'Programming languages: '
        languages = gets.chomp	
        employee = Programmer.new(full_name, id, languages)
    when 'o' then
        print 'Office: '
        office = gets.chomp
	employee = OfficeManager.new(full_name, id, office)
    else
        puts 'That wasn\'t an instruction!'
	employee = Employee.new(full_name, id)
    end

    employees << employee
end

def edit_employee(employees)
    puts '[Edit an employee]'
    print 'ID of the employee you want to edit: '
    id = gets.chomp
    employees.each do |employee|
        if (employee.id == id) then
            puts "Current full name: #{employee.full_name}"
	    puts "Current ID: #{employee.id}"
	    action = ''
	    case employee
	    when Programmer then 
                puts "Current languages: #{employee.languages}"
	        print 'Do you want to edit [i]d or [p]rogramming languages? '
                action = get_action
            when OfficeManager then 
	        puts "Current office: #{employee.office}"
		print 'Do you want to edit [i]d or [o]ffice? '
		action = get_action
	    else
                action = 'i'
	    end
	    case action
            when 'p' then
                print 'New programming languages: '
		employee.languages = gets.chomp.split(', ')
	    when 'o' then
	        print 'New office: '
		employee.office = "(#{gets.chomp})"
	    else
                print 'New ID: '
		employee.id = gets.chomp
	    end
	    break
	end
    end
end

def view_employees(employees)
    print 'Sort by [f]irst name or [l]ast name? '
    keyword = get_action
    sorted_employees(employees, keyword).each do |employee|
        print "#{employee.full_name}, #{employee.id}"
	case employee
	when Programmer then puts ", #{employee.languages}"
	when OfficeManager then puts ", #{employee.office}"
        else
            puts ""
	end
    end
end

def sorted_employees(employees, keyword)
    case keyword
    when 'f' then
	employees.sort_by do |employee|
            employee.first_name
        end
    when 'l' then
        employees.sort_by do |employee|
            employee.last_name
        end
    else
        puts 'Sorry! We can\'t do anything if you don\'t follow instructions...' 
        employees.sort_by do |employee|
            employee.id
        end
    end
end

def quit
    puts 'Goodbye!'
    exit
end

def print_help
    puts '[HELP]'
    puts 'Enter one of the following:'
    puts 'a - to add a new employee'
    puts 'e - to edit an existing employee'
    puts 'v - to view existing employees'
    puts 'q - to quit the program'
end

def get_action
    gets.downcase[0]
end

# Main program starts here

puts 'Employee-o-matic 4000'

employees = []

loop do
    print 'What do you want to do? '
    action = get_action

    case action
    when 'a' then add_employee(employees)
    when 'e' then edit_employee(employees)
    when 'v' then view_employees(employees)
    when 'q' then quit
    else
        print_help
    end
end
