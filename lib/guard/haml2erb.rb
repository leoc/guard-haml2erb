require 'guard'
require 'guard/guard'
require 'guard/watcher'
require 'haml2erb'

module Guard
  class Haml2Erb < Guard
    
    def initialize(watchers = [], options = {})
      super(watchers, {
        :notifications => true      
      }.merge(options))
      @watchers, @options = watchers, options
    end
    
    def convert_haml file
      content = File.new(file).read
      begin
        ::Haml2Erb.convert(content)
      rescue StandardError => error
        ::Guard::UI.info "HAML2ERB Error: " + error.message
      end
    end

    # Get the file path to output the html based on the file being
    # built.  The output path is relative to where guard is being run.
    #
    # @param file [String] path to file being built
    # @return [String] path to file where output should be written
    #
    def get_output(file)
      file_dir = File.dirname(file)
      file_name = (File.basename(file).split('.')[0..-2] << 'erb').join('.')
      
      file_dir = file_dir.gsub(Regexp.new("#{@options[:input]}(\/){0,1}"), '') if @options[:input]
      file_dir = File.join(@options[:output], file_dir) if @options[:output]

      if file_dir == ''
        file_name
      else
        File.join(file_dir, file_name)
      end
    end
    
    def run_all
      run_on_change(Watcher.match_files(self, Dir.glob(File.join('**', '*.*'))))
    end
  
    def run_on_change(paths)
      paths.each do |file|
        output_file = get_output(file)
        FileUtils.mkdir_p File.dirname(output_file)
        File.open(output_file, 'w') { |f| f.write(convert_haml(file)) }
        ::Guard::UI.info "# converted haml in '#{file}' to erb in '#{output_file}'"
        ::Guard::Notifier.notify("# converted haml in #{file}", :title => "Guard::Haml", :image => :success) if @options[:notifications]
      end
      notify paths
    end

    def notify(changed_files)
      ::Guard.guards.reject{ |guard| guard == self }.each do |guard|
        paths = Watcher.match_files(guard, changed_files)
        guard.run_on_change paths unless paths.empty?
      end
    end
    
  end
end
