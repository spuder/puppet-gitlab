# Add files and commands to this file, like the example:
#   watch(%r{file/path}) { `command(s)` }
# A guard file based on this implementation
# https://github.com/arioch/puppet-percona/blob/master/Guardfile
# By running the command 'guard' in the terminal, the following taks are executed
# every time a file is saved

# - puppet parser validate
# - puppet lint
# - .erb syntax check
# - .rb syntax check
require 'colorize'

guard :shell do

    # Watch all files in the manifests directory that end in .pp
    watch(%r{^manifests\/.+\.pp$}) do |m|
        guard_shell_exit = nil

        # Run puppet parser validate
        if guard_shell_exit != 1
            puts "Running puppet parser verify....".blue
            parser = `puppet parser validate --color=true #{m[0]}`
            retval = $?.to_i
            case retval
                when 0
                    puts '1. Puppet Parser Validate: passed!'.green
                    n "#{m[0]} Parser can parse!", 'Puppet-Parser'
                    guard_shell_exit = 0
                else
                    n "#{m[0]} Parser can't parse! #{parser}", 'Puppet-Parser', :failed
                    guard_shell_exit = 1
            end
        end

        # Run puppet lint
        if guard_shell_exit != 1
            puts "Running puppet-lint....".blue
            lint = `puppet-lint --no-autoloader_layout-check --no-80chars-check --no-class_inherits_from_params_class-check --with-filename #{m[0]}`
            retval = $?.to_i
            case retval
                when 0
                    if lint.length > 0 then
                        puts lint.red
                        n "#{m[0]} You can do better, warnings left on Terminal!", 'Puppet-Lint', :pending
                        guard_shell_exit = 1
                    else
                        puts lint
                        puts '2. Puppet-Lint: passed!'.green
                        n "#{m[0]} Fully lintified!", 'Puppet-Lint', :success
                        guard_shell_exit = 0
                    end
                else
                    puts lint
                    n "#{m[0]} There are errors on Terminal left!", 'Puppet-Lint', :failed
                    guard_shell_exit = 1
            end
        end

        # Run Rake Spec
        if guard_shell_exit != 1
            puts "Running rake spec....".blue
            spec = `rake spec`
            retval = $?.to_i
            case retval
            when 0
                if spec.length > 0 then
                    puts spec
                    n "#{m[0]} Tests Failed!", 'Rake Spec', :pending
                    guard_shell_exit = 1

                else
                    puts spec.green
                    n "#{m[0]} Tests Passed!", 'Rake Spec', :pending
                    guard_shell_exit = 0

                end
                puts '3. Rake Spec: passed!'.green
            else
                puts '3. Rake Spec: failed!'.red
            end
            print "============================"
        end
    end

    # Watch all files in templates directory that end in .erb
    watch(%r{^templates\/.*\.erb$}) do |m|
        # Verify .erb template syntax
        case system "cat #{m[0]} | erb -P -x -T - | ruby -c"
            when true
                puts 'ERB Check: passed!'.green
                n "#{m[0]} is valid", 'ERB-Check'
            when false
                puts 'ERB Check: failed!'.red
                n "#{m[0]} is invalid", 'ERB-Check', :failed
        end
    end

    # Watch all files in the spec directory that end in .rb
    watch(%r{^spec/classes\/.+\.rb$}) do |m|
        puts "Running rake spec....".blue
        spec = `rake spec`
        retval = $?.to_i
        case retval
        when 0
            if spec.length > 0 then
                puts spec
                n "#{m[0]} Tests Failed!", 'Rake Spec', :pending
                guard_shell_exit = 1

            else
                puts spec.green
                n "#{m[0]} Tests Passed!", 'Rake Spec', :pending
                guard_shell_exit = 0

            end
            puts '3. Rake Spec: passed!'.green
        else
            puts '3. Rake Spec: failed!'.red
        end
        print "============================"
    end

    # Commenting out because I don't need it, and doesn't always work
    # # Watch all files that end in .rb
    # watch /(.*\.rb$)/ do |m|
    #     # Verify .rb file syntax
    #     case system "ruby -c #{m[0]}"
    #         when true
    #             puts 'Ruby Check: passed!'.green
    #             n "#{m[0]} is valid", 'Ruby-Syntax-Check'
    #         when false
    #             puts 'Ruby Check: failed!'.red
    #             n "#{m[0]} is invalid", 'Ruby-Syntax-Check', :failed
    #     end
    # end

end

# vim: set syntax=ruby
