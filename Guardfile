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

    watch(%r{^manifests\/.+\.pp$}) do |m|
        guard_shell_exit = nil

        # Run puppet parser validate
        if guard_shell_exit != 1
            parser = `puppet parser validate --color=true #{m[0]}`
            retval = $?.to_i
            case retval
                when 0
                    puts 'puppet parser validate passed'.green
                    n "#{m[0]} Parser can parse!", 'Puppet-Parser'
                    guard_shell_exit = 0
                else
                    n "#{m[0]} Parser can't parse! #{parser}", 'Puppet-Parser', :failed
                    guard_shell_exit = 1
            end
        end

        # Run puppet lint
        if guard_shell_exit != 1
            lint = `puppet-lint --no-autoloader_layout-check --no-80chars-check --with-filename #{m[0]}`
            retval = $?.to_i
            case retval
                when 0
                    if lint.length > 0 then
                        puts lint.red
                        puts "guard_shell_exit: #{guard_shell_exit}"
                        n "#{m[0]} You can do better, warnings left on Terminal!", 'Puppet-Lint', :pending
                        guard_shell_exit = 1
                    else
                        puts lint
                        puts 'lint tests pass'.green
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
                puts 'spec test passed'.green
            else
                puts 'spec tests failed'.red
            end
        end

    end

    # watch(%r{^templates\/.*\.erb$}) do |m|
    # # watch /(.*\.erb$)/ do |m|
    #     # Verify erb syntax
    #     case system "cat #{m[0]} | erb -P -x -T - | ruby -c"
    #         when true
    #             n "#{m[0]} is valid", 'ERB-Check'
    #         when false
    #             n "#{m[0]} is invalid", 'ERB-Check', :failed
    #     end
    # end


    # watch /(.*\.rb$)/ do |m|

    #     # Verify .rb file syntax
    #     case system "ruby -c #{m[0]}"
    #         when true
    #             n "#{m[0]} is valid", 'Ruby-Syntax-Check'
    #         when false
    #             n "#{m[0]} is invalid", 'Ruby-Syntax-Check', :failed
    #     end
    # end

end

# guard 'rake', :task => 'spec' do
#   watch(%r{^manifests\/.+\.pp$})
#   watch(%r{^spec\/^classes\/.+_spec\.rb$})
# end


# vim: set syntax=ruby