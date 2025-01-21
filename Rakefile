namespace :uppy do

  desc "Update Uppy to the latest version"
  task :update => %i[ check_version refresh_vendor update_version_file ]

  desc "Check if the Uppy version in lib/uppy/rails/version.rb has changed"
  task :check_version do
    if local_version == yarn_version
      puts "Uppy version is already up-to-date: #{local_version}"
      exit
    else
      puts "Uppy version will be updated from #{local_version} to #{yarn_version}"
    end
  end

  desc "Import a fresh version of Uppy into vendor/assets using Yarn"
  task :refresh_vendor do
    sh "yarn add uppy@latest"
    zipfile = `ls ~/.yarn/berry/cache | grep uppy-npm`.strip
    sh "unzip -o ~/.yarn/berry/cache/#{zipfile} -d tmp/"
    sh "cp -r tmp/node_modules/uppy/dist/uppy.min.js vendor/assets/javascripts/"
    sh "cp -r tmp/node_modules/uppy/dist/uppy.min.css vendor/assets/stylesheets/"
    sh "rm -rf tmp/node_modules"
  end

  desc "Update the Uppy version in lib/uppy/rails/version.rb based on the one from vendor"
  task :update_version_file do
    content = File.read(local_version_path)
    content.gsub!(local_version, yarn_version)
    File.write(local_versio_path, content)
    puts "Updated Uppy version to #{yarn_version} in #{local_version_path}"
  end

  def yarn_version
    @yarn_version ||= `yarn why uppy | grep uppy@ | awk -F'npm:' '{print $2}' | awk '{print $1}'`.strip
  end

  def local_version_path
    "lib/uppy/rails/version.rb"
  end

  def local_version
    @local_version ||= begin
      content = File.read(local_version_path)
      content.match(/VERSION = "(\d+\.\d+\.\d+)"/)[1]
    end
  end

end

require "bundler/gem_tasks"
task default: %i[uppy:update]
